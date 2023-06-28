//
//  TimerController.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 25/06/23.
//

import Foundation
import SwiftUI

class TimerController: ObservableObject {
    var timerSet = false

    func setTimer(withInterval interval: Double, andJob job: @escaping () -> Void) {
        if timerSet {
            return
        }
        TimerModel.sharedTimer.startTimer(withInterval: interval, andJob: job)
        timerSet = true
    }
}
