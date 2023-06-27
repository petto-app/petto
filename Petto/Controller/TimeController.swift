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

    func setPrimeTime(start: Int = 9, finish: Int = 17, interval: Int = 2) {
        timeModel.timeConfig = TimeConfig(startHour: start, finishHour: finish, interval: interval)
        _ = scheduleLocal(startHour: timeModel.timeConfig!.startHour, endHour: timeModel.timeConfig!.finishHour, intervalHour: timeModel.timeConfig!.interval)
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
        for h in primeTimeHours {
            if h > primeTimeHour {
                primeTimeHour = h
                break
            }
        }

        let differenceInSeconds = primeTimeHour * 3600 - (currentHour * 3600 + currentMinutes * 60 + currentSeconds)
        return differenceInSeconds
    }
}
