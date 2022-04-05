import SwiftUI

struct NotificationTestView: View {
    var body: some View {
        VStack(spacing: 10) {
            Button {
                UNUserNotificationCenter.current()
                    .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                }
            } label: {
                Text("Request Permission")
            }
            Button {
                let content = UNMutableNotificationContent()
                content.title = "Feed the starter"
                content.subtitle = "It looks hungry"
                content.sound = .default
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            } label: {
                Text("Schedule Notification")
            }
        }
    }
    
//    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    
//    var dateComponents = DateComponents()
//    dateComponents.hour = 11
//    dateComponents.minute = 59
//    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
}

struct NotificationTestView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationTestView()
    }
}
