//
//  NotificationManager.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-29.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    enum NotificationType: String {
        case streakReminder = "streak-reminder"
    }
    
    private init() {}
    
    private let notificationPreferenceKey = "userNotificationPreference"

    func setUserNotificationPreference(enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: notificationPreferenceKey)
    }

    func getUserNotificationPreference() -> Bool {
        return UserDefaults.standard.bool(forKey: notificationPreferenceKey)
    }
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    // now we’re using the error constant…
                    print("Notification permission error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(granted)
            }
        }
    }
    
    /// Check notification permission status
    func checkPermissionStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    /// Remove pending notifications of a specific type
    func removePendingNotifications(of type: NotificationType) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [type.rawValue])
    }
    
    /// Remove all pending notifications
    func removeAllPendingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func scheduleStreakReminder(currentStreak: Int, at time: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Don't break your streak!"
        content.body = "You have a \(currentStreak)-day streak. Complete a task today to keep it going!"
        content.sound = .default
        content.badge = 1
        
        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: NotificationType.streakReminder.rawValue, content: content, trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling streak reminder: \(error.localizedDescription)")
            } else {
                print("Streak reminder scheduled successfully for \(time)")
            }
        }
    }
    
    func scheduleStreakReminderForEndOfDay(currentStreak: Int, hour: Int = 20, minute: Int = 0) {
        // Create a date for today at the specified hour and minute
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        
        guard let reminderTime = Calendar.current.date(from: components) else {
            print("Failed to create date for reminder")
            return
        }
        
        let now = Date()
        
        if reminderTime > now {
            scheduleStreakReminder(currentStreak: currentStreak, at: reminderTime)
        } else {
            print("Cannot schedule reminder for time in the past: \(reminderTime)")
        }
    }
    
    func scheduleStreakReminderForNextDay(currentStreak: Int, hour: Int = 9, minute: Int = 0) {
        let now = Date()
        let calendar = Calendar.current
        
        // Get tomorrow's date
        guard let tomorrow = calendar.date(byAdding: .day, value: 1, to: now) else {
            print("Failed to calculate tomorrow's date")
            return
        }
        
        // Create components for tomorrow at the specified time
        var components = calendar.dateComponents([.year, .month, .day], from: tomorrow)
        components.hour = hour
        components.minute = minute
        
        guard let reminderTime = calendar.date(from: components) else {
            print("Failed to create date for reminder")
            return
        }
        
        scheduleStreakReminder(currentStreak: currentStreak, at: reminderTime)
    }
    
    // Add this to NotificationManager.swift
    func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Test Notification"
        content.body = "This is a test notification from your app"
        content.sound = .default
        
        // Trigger after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: "test-notification",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling test notification: \(error.localizedDescription)")
            } else {
                print("Test notification scheduled successfully")
            }
        }
    }
    
    
}
