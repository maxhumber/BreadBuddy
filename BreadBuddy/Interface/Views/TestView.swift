import SwiftUI

struct Note: Codable {
    var id: String
    var text: String
    var lastEdited: Date
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}


struct ShareSheet: UIViewControllerRepresentable {
    // To setup the share sheet
    struct Config {
        let activityItems: [Any]
        var applicationActivities: [UIActivity]?
        var excludedActivityTypes: [UIActivity.ActivityType]?
    }
    
    // Result object
    struct Result {
        let error: Error?
        let activityType: UIActivity.ActivityType?
        let completed: Bool
        let returnedItems: [Any]?
    }
    
    @Binding var isPresented: Bool
    
    private var handler: ((Result) -> Void)?
    private let shareSheet: UIActivityViewController
    
    init(
        isPresented: Binding<Bool>,
        config: Config,
        onEnd: ((Result) -> Void)? = nil
    ) {
        self._isPresented = isPresented
        shareSheet = UIActivityViewController(
            activityItems: config.activityItems,
            applicationActivities: config.applicationActivities
        )
        shareSheet.excludedActivityTypes = config.excludedActivityTypes
        shareSheet.completionWithItemsHandler = { activityType, completed, returnedItems, error in
            onEnd?(
                .init(
                    error: error,
                    activityType: activityType,
                    completed: completed,
                    returnedItems: returnedItems
                )
            )
            // Set isPresented to false after complete
            isPresented.wrappedValue = false
        }
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(
        _ uiViewController: UIViewController,
        context: Context
    ) {
        if isPresented, shareSheet.view.window == nil {
            uiViewController.present(shareSheet, animated: true, completion: nil)
        } else if !isPresented, shareSheet.view.window != nil {
            shareSheet.dismiss(animated: true)
        }
    }
}

extension View {
    func shareSheet(
        isPresented: Binding<Bool>,
        config: ShareSheet.Config,
        onEnd: ((ShareSheet.Result) -> Void)? = nil
    ) -> some View {
        self.background(
            ShareSheet(isPresented: isPresented, config: config, onEnd: onEnd)
        )
    }
}


struct TestView: View {
    @State var isPresented = false
    
    var body: some View {
        Button(action: {
            isPresented = true
        }, label: {
            Text("Toggle")
        })
        .shareSheet(isPresented: $isPresented, config: ShareSheet.Config(
            activityItems: ["You can add some text or other items here", URL(string: "https://www.apple.com")!],
            applicationActivities: nil
        ))
    }
    
    func exportToFileURL(note: Note) -> URL? {
        guard let contents = try? note.asDictionary() else {
            return nil
        }
        
        guard let path = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let saveFileURL = path.appendingPathComponent("/\(note.id).note")
        (contents as NSDictionary).write(to: saveFileURL, atomically: true)
        return saveFileURL
    }

    func share() {
        let currentNote = Note(id: "1", text: "ABC", lastEdited: .now)
        guard let url = exportToFileURL(note: currentNote) else { return }
        let _ = ShareSheet.Config(
            activityItems: ["You can add some text or other items here", url],
            applicationActivities: nil
        )
    }

}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
