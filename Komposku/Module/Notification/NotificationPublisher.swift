//
//  NotificationPublisher.swift
//  Komposku
//
//  Created by Clara Anggraini on 05/08/21.
//

import UIKit
import UserNotifications

class NotificationPublisher{
    var date: Date?
    
    func sendNotification(title: String, body: String, badge: Int?, date: Date){
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        self.date = date
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.date!)
        
        let delayTimeTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        if let badge = badge{
            var currentBadgeCount = UIApplication.shared.applicationIconBadgeNumber
            currentBadgeCount += badge
            content.badge = NSNumber(integerLiteral: currentBadgeCount)
        }
        
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: delayTimeTrigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
}
