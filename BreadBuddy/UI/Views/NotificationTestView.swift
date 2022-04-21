import SwiftUI
import Core

extension NotificationTestView {
    @MainActor final class ViewModel: ObservableObject {
        var service = NotificationService()
        
        func requestAuthorization() {
            Task {
                try? await service.requestAuthorization()
            }
        }
        
        func scheduleTest() {
            let time = Date().addingTimeInterval(10)
            let notification = Notification(title: "Title", subtitle: "Subtitle", time: time)
            service.schedule(notification)
        }
    }
}

struct NotificationTestView: View {
    @StateObject var viewModel: ViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: .init())
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Button {
                viewModel.requestAuthorization()
            } label: {
                Text("Request Permission")
            }
            Button {
                viewModel.scheduleTest()
            } label: {
                Text("Schedule Test Notification")
            }
        }
    }
}

struct NotificationTestView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationTestView()
    }
}
