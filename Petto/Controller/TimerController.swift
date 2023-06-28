//
//  TimerController.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 25/06/23.
//

import Foundation
import SwiftUI

class TimerController: ObservableObject {
    @Published var timerSet: [String: Bool] = [:]

    func setTimer(key: String, withInterval interval: Double, andJob job: @escaping () -> Void) {
        if timerSet[key] != nil && timerSet[key]! {
            return
        }
        TimerModel.sharedTimer.startTimer(withInterval: interval, andJob: job)
        timerSet[key] = true
    }
}
