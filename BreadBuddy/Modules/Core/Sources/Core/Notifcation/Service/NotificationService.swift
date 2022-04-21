import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    var authorizationStatus: UNAuthorizationStatus {
        var authorizationStatus: UNAuthorizationStatus = .notDetermined
        getNotificationSettings { settings in
            authorizationStatus = settings.authorizationStatus
        }
        return authorizationStatus
    }
}

public final class NotificationService {
    private var notificationCenter: UNUserNotificationCenter
    
    public init(notificationCenter: UNUserNotificationCenter = .current()) {
        self.notificationCenter = notificationCenter
    }
    
    public func checkAuthorizationStatus() {
        notificationCenter.getNotificationSettings { settings in
            print("Checking notification status")
            switch settings.authorizationStatus {
            case .authorized:
                print("authorized")
            case .denied:
                print("denied")
            case .notDetermined:
                print("notDetermined")
            case .ephemeral:
                print("ephemeral")
            case .provisional:
                print("provisional")
            default:
                print("unknown")
            }
        }
    }
    
    public func foo() {
        notificationCenter.removeAllDeliveredNotifications()
        notificationCenter.removeDeliveredNotifications(withIdentifiers: ["hey"])
    }
    
    public func requestAuthorization(options: UNAuthorizationOptions = [.alert, .badge, .sound]) async throws {
        try await notificationCenter.requestAuthorization(options: options)
    }
    
    public func schedule(_ notification: Notification) {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        if let subtitle = notification.subtitle {
            content.subtitle = subtitle
        }
        content.sound = .default
        let trigger = UNCalendarNotificationTrigger(dateMatching: notification.time.components(), repeats: false)
        let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
        notificationCenter.add(request)
    }
    
    public func removePendingNotification(_ notification: Notification) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [notification.id])
    }
    
    public func removeAllPendingNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    public func getPendingNotifications() {
        notificationCenter.getPendingNotificationRequests { requests in
            for request in requests {
                print(request)
            }
        }
    }
}
