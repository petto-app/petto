//
//  TimeController.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 25/06/23.
//

import Foundation
import SwiftUI

class TimeController: ObservableObject {
    @ObservedObject var timeModel = TimeModel()

    func setPrimeTime(start: Int = 9, finish: Int = 17, interval: Int = 2) -> Bool {
        let (result, _) = scheduleLocal(startHour: start, endHour: finish, intervalHour: interval)
        if result {
            timeModel.timeConfig = TimeConfig(startHour: start, finishHour: finish, interval: interval)
        }
        return result
    }

    func isPrimeTime() -> Bool {
        return Petto.isPrimeTime(hours: getPrimeTimeHours(startHour: timeModel.timeConfig?.startHour ?? 0, endHour: timeModel.timeConfig?.finishHour ?? 0, intervalHour: timeModel.timeConfig?.interval ?? 0))
    }

    func getPrimeTime() -> TimeConfig? {
        return timeModel.timeConfig
    }

    func getSecondsRemaining() -> Int {
        var primeTimeHours = getPrimeTimeHours(startHour: timeModel.timeConfig?.startHour ?? 9, endHour: timeModel.timeConfig?.finishHour ?? 17, intervalHour: timeModel.timeConfig?.interval ?? 2)
        let startDate = Date()
        let calendar = Calendar.current

        let currentHour = calendar.component(.hour, from: startDate)
        let currentMinutes = calendar.component(.minute, from: startDate)
        let currentSeconds = calendar.component(.second, from: startDate)

        var isNextDay = primeTimeHours.allSatisfy { $0 < currentHour }

        for i in 0 ..< primeTimeHours.count {
            if i > 0 && primeTimeHours[i - 1] > primeTimeHours[i] {
                isNextDay = true
            }
            if isNextDay {
                primeTimeHours[i] += 24
            }
        }

        var primeTimeHour = currentHour
        var flag = false
        for h in primeTimeHours {
            if h > primeTimeHour {
                primeTimeHour = h
                flag = true
                break
            }
        }

        if !flag {
            primeTimeHour = primeTimeHours[0] + 24
        }

        let differenceInSeconds = primeTimeHour * 3600 - (currentHour * 3600 + currentMinutes * 60 + currentSeconds)
        return differenceInSeconds
    }
}
