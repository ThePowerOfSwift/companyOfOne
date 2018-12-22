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
    
    private static var pendingNotificationCount:Int = 0
    private static var noticationIdentifiers:[String] = []
    
    class func scheduleNotification() {
        
//        func createDate(weekday: Int, hour: Int, minute: Int, year: Int)->Date{
//
//            var components = DateComponents()
//            components.hour = hour
//            components.minute = minute
//            components.year = year
//            components.weekday = weekday // sunday = 1 ... saturday = 7
//            components.weekdayOrdinal = 10
//            components.timeZone = .current
//
//            let calendar = Calendar(identifier: .gregorian)
//            return calendar.date(from: components)!
//        }
//
//        //Schedule Notification with weekly bases.
//        func scheduleNotification(at date: Date, body: String, titles:String) {
//
//            let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute,.second,], from: date)
//
//            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
//
//            let content = UNMutableNotificationContent()
//            content.title = titles
//            content.body = body
//            content.sound = UNNotificationSound.default()
//            content.categoryIdentifier = "todoList"
//
//            let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
//
//            UNUserNotificationCenter.current().delegate = self
//            //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//            UNUserNotificationCenter.current().add(request) {(error) in
//                if let error = error {
//                    print("Uh oh! We had an error: \(error)")
//                }
//            }
//        }
//------------------------------------------------------------------------------

        //        var date = DateComponents()
        //        date.year = 2017
        //        date.month = 6
        //        date.day = 12
        //        date.hour = 22
        //        date.minute = 39
        // let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        
        // I think this will repeat every year
        //       var futureDate = DateComponents()
        //        futureDate.year = 1
        //        futureDate.weekday = 5
        //        futureDate.hour = 10
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: futureDate, repeats: true)
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
       
        let content = UNMutableNotificationContent()
        content.title = "Title/Tag"
        content.body = "Category:SubCategory"
        content.sound = UNNotificationSound.default
        content.badge = 1
        let request = UNNotificationRequest(identifier: "Rent Cheque", content: content, trigger: trigger)
       
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("error: \(error)")
            }
        print("5 seconds from now")
}
    }
    
    class func updatePendingNotificationInfo() -> (count: Int, identifiers:[String]) {
        UNUserNotificationCenter.current().getPendingNotificationRequests {
            (requests) in
            pendingNotificationCount = requests.count
            for request in requests{
            noticationIdentifiers.append(request.identifier)
            }
        }
    return (pendingNotificationCount, noticationIdentifiers)
        //I don't think this will work.  Asychronous, takes some time to come back and the UI variables don't catch it...
        
    }
    
    class func clearAllPendingNotifications(){
        //testing purposes only?
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        pendingNotificationCount = 0
        noticationIdentifiers.removeAll()
    }
    
    class func clearSpecificNotifications(){
        //use this when a specific notification(reminder) is fullfilled...then remove
    UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: noticationIdentifiers)
    }
}
