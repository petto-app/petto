//
//  PrimeTimeHelper.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 24/06/23.
//

import Foundation
import UserNotifications

func scheduleLocal(startHour: Int, endHour: Int, intervalHour: Int) -> (Bool, Int) {
    if abs(startHour - endHour) < 4 || startHour > 23 || startHour < 0 || endHour > 23 || endHour < 0 {
        return (false, -1)
    }

    if intervalHour < 1 || intervalHour > 3 {
        return (false, -1)
    }

    let center = UNUserNotificationCenter.current()
    center.removeAllPendingNotificationRequests()

    let content = UNMutableNotificationContent()
    content.title = "It's Prime Time!"
    content.subtitle = "C'mon stretch your body"
    content.sound = UNNotificationSound.default

    let timeDiff = (endHour < startHour ? endHour + 24 : endHour) - startHour
    var notificationsCount = 0

    var startTemp = startHour + intervalHour
    for _ in 0 ..< Int(timeDiff / intervalHour) {
        var dateComponents = DateComponents()
        dateComponents.hour = startTemp % 24
        dateComponents.minute = 0
        print("Hour \(dateComponents)")

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request) { error in
            if error != nil {
                print(error!)
            }
        }
        startTemp += intervalHour
        startTemp %= 24
        notificationsCount += 1
    }

//    var dateComponents = DateComponents()
//    dateComponents.hour = 10
//    dateComponents.minute = 30
//    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//    center.add(request) { error in
//        if error != nil {
//            print(error!)
//        }
//    }
    return (true, notificationsCount)
}
