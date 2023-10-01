//
//  PrimeTimeHelper.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 24/06/23.
//

import Foundation
import UserNotifications

func getPrimeTimeHours(startHour: Int, endHour: Int, intervalHour: Int) -> [Int] {
    if abs(startHour - endHour) < 4 || startHour > 23 || startHour < 0 || endHour > 23 || endHour < 0 {
        return []
    }

    if intervalHour < 1 || intervalHour > 3 {
        return []
    }

    let timeDiff = (endHour < startHour ? endHour + 24 : endHour) - startHour

    var result: [Int] = []

    var startTemp = startHour + intervalHour
    for _ in 0 ..< Int(timeDiff / intervalHour) {
        result.append(startTemp)
        startTemp += intervalHour
        startTemp %= 24
    }

    return result
}

func isPrimeTime(hours: [Int]) -> Bool {
    // *** Create date ***
    let date = Date()

    // *** create calendar object ***
    let calendar = Calendar.current

    let currentHour = calendar.component(.hour, from: date)
    let currentMinutes = calendar.component(.minute, from: date)

    for hour in hours {
        if currentHour == hour && currentMinutes <= 10 {
            return true
        }
    }

    return false
}

func scheduleLocal(startHour: Int, endHour: Int, intervalHour: Int, enableNotification: Bool = true) -> (Bool, Int) {
    if abs(startHour - endHour) < 4 || startHour > 23 || startHour < 0 || endHour > 23 || endHour < 0 {
        return (false, -1)
    }

    if intervalHour < 1 || intervalHour > 3 {
        return (false, -1)
    }

    let center = UNUserNotificationCenter.current()
    center.removeAllPendingNotificationRequests()

    if !enableNotification {
        return (true, 0)
    }

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

    #if targetEnvironment(simulator)
        var dateComponents = DateComponents()
        let date = Date()

        // *** create calendar object ***
        let calendar = Calendar.current

        let currentHour = calendar.component(.hour, from: date)
        let currentMinutes = calendar.component(.minute, from: date)
        dateComponents.hour = currentHour
        dateComponents.minute = currentMinutes + 1

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request) { error in
            if error != nil {
                print(error!)
            }
        }
    #endif

    return (true, notificationsCount)
}
