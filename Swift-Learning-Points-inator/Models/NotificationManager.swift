//
//  NotificationManager.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-04-29.
//

import Foundation
import UserNotifications

/// Manages local notifications for the application.
class NotificationManager {
    static let shared = NotificationManager()
    
    enum NotificationType: String {
        case streakReminder = "streak-reminder"
    }
    
    private init() {}
    
    private let notificationPreferenceKey = "userNotificationPreference"
    
    
    /// Sets the user's preference for receiving notifications.
    ///
    /// - Parameter enabled: A boolean value indicating whether notifications should be enabled (`true`) or disabled (`false`).
    func setUserNotificationPreference(enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: notificationPreferenceKey)
    }
    
    /// Retrieves the user's current notification preference.
    ///
    /// - Returns: A boolean value indicating whether notifications are currently enabled (`true`) or disabled (`false`).
    func getUserNotificationPreference() -> Bool {
        return UserDefaults.standard.bool(forKey: notificationPreferenceKey)
    }
    
    /// Requests permission from the user to send local notifications.
    ///
    /// - Parameter completion: A closure that is called with a boolean value indicating whether permission was granted (`true`) or denied (`false`).
    func requestPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Notification permission error: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(granted)
            }
        }
    }
    
    /// Checks the current authorization status for local notifications.
    ///
    /// - Parameter completion: A closure that is called with the current `UNAuthorizationStatus`.
    func checkPermissionStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    /// Removes all pending notifications of a specific type.
    ///
    /// - Parameter type: The `NotificationType` of the notifications to remove.
    func removePendingNotifications(of type: NotificationType) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [type.rawValue])
    }
    
    /// Remove all pending notifications
    func removeAllPendingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    /// Schedules a notification to remind the user about their current learning streak at a specific time.
    ///
    /// - Parameters:
    ///   - currentStreak: The user's current learning streak (number of consecutive days).
    ///   - time: The `Date` at which the notification should be delivered.
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
    
    /// Schedules a streak reminder notification for the end of the current day.
    ///
    /// - Parameters:
    ///   - currentStreak: The user's current learning streak.
    ///   - hour: The hour (in 24-hour format) at which to schedule the reminder (default is 20).
    ///   - minute: The minute at which to schedule the reminder (default is 0).
    func scheduleStreakReminderForEndOfDay(currentStreak: Int, hour: Int = 20, minute: Int = 0) {
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
    
    /// Schedules a streak reminder notification for the beginning of the next day.
    ///
    /// - Parameters:
    ///   - currentStreak: The user's current learning streak.
    ///   - hour: The hour (in 24-hour format) at which to schedule the reminder (default is 9).
    ///   - minute: The minute at which to schedule the reminder (default is 0).
    func scheduleStreakReminderForNextDay(currentStreak: Int, hour: Int = 9, minute: Int = 0) {
        let now = Date()
        let calendar = Calendar.current
        
        guard let tomorrow = calendar.date(byAdding: .day, value: 1, to: now) else {
            print("Failed to calculate tomorrow's date")
            return
        }
        
        var components = calendar.dateComponents([.year, .month, .day], from: tomorrow)
        components.hour = hour
        components.minute = minute
        
        guard let reminderTime = calendar.date(from: components) else {
            print("Failed to create date for reminder")
            return
        }
        
        scheduleStreakReminder(currentStreak: currentStreak, at: reminderTime)
    }
    
    /// Sends a test notification immediately (after a short delay). This is useful for debugging notification setup.
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
