//
//  NotificationManager.swift
//  Local Notification Assignment
//
//  Created by admin on 21/12/2021.
//

import Foundation
import UserNotifications

class NotificationManager {
    class func askUserPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { isAllowed, error in }
    }
    
    class func getNotificationRequest(tracker: Tracker) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = tracker.assignmentName
        content.body = "You worked hard for \(tracker.timerDisplayValue)! Now, take a rest."
        
        //trigger
        //Configure the recurring date.
        let timeInterval = TimeInterval.init(tracker.timerInterval)
        let triggerTime = Date(timeIntervalSinceNow: timeInterval)
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: triggerTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        //Create the request object.
        let request = UNNotificationRequest(identifier: tracker.assignmentName, content: content, trigger: trigger)
        return request
    }
}
