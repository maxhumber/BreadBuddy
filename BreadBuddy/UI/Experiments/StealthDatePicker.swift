import SwiftUI

struct StealthDatePicker: View {
    @State private var date = Date()
    
    var body: some View {
        ZStack {
            DatePicker("", selection: $date, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(.compact)
                .labelsHidden()
            SwiftUIWrapper {
                Text(date.weekday())
            }
            .allowsHitTesting(false)
        }
        .fixedSize()
    }
}

struct SwiftUIWrapper<T: View>: UIViewControllerRepresentable {
    let content: () -> T
    
    func makeUIViewController(context: Context) -> UIHostingController<T> {
        UIHostingController(rootView: content())
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<T>, context: Context) {}
}

struct StealthDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            StealthDatePicker()
                .font(.title2)
            StealthDatePicker()
                .font(.body)
        }
    }
}
