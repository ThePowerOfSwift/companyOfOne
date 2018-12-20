//
//  NotificationHandler.swift
//  companyOfOne
//
//  Created by Jamie on 2018-12-20.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationHandler: NSObject {
    
    class func scheduleNotification() {

//        var date = DateComponents()
//        date.year = 2017
//        date.month = 6
//        date.day = 12
//        date.hour = 22
//        date.minute = 39
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
       // let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "Schedule Notification"
        content.body = "Today is my Birthday"
        content.sound = UNNotificationSound.default
        content.badge = 1
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("error: \(error)")
            }
        }
        print("5 seconds from now")
}
}
