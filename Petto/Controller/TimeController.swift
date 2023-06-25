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
}
