import Foundation
import UserNotifications

public struct Notification {
    public var id: String = UUID().uuidString
    public var title: String
    public var subtitle: String?
    public var time: Date
    
    public init(id: String = UUID().uuidString, title: String, subtitle: String? = nil, time: Date) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.time = time
    }
}

public final class NotificationService {
    private var notificationCenter: UNUserNotificationCenter
    
    public init(notificationCenter: UNUserNotificationCenter = .current()) {
        self.notificationCenter = notificationCenter
    }
    
    public func requestAuthorization(options: UNAuthorizationOptions = [.alert, .badge, .sound]) async throws {
        try await notificationCenter.requestAuthorization(options: options)
    }

    public func clearAllPendingNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    public func schedule(_ notification: Notification) {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        if let subtitle = notification.subtitle {
            content.subtitle = subtitle
        }
        content.sound = .default
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notification.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
        notificationCenter.add(request)
    }
    
    public func clearPendingNotification(_ notification: Notification) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [notification.id])
    }
}
