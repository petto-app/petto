//
//  TimerModel.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 28/06/23.
//

import Foundation

class TimerModel: ObservableObject {
    static let sharedTimer: TimerModel = {
        let timer = TimerModel()
        return timer
    }()

    var internalTimer: Timer?
    var jobs = [() -> Void]()

    func startTimer(withInterval interval: Double, andJob job: @escaping () -> Void) {
        if internalTimer != nil {
            internalTimer?.invalidate()
        }
        jobs.append(job)
        internalTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(doJob), userInfo: nil, repeats: true)
    }

    func pauseTimer() {
        guard internalTimer != nil else {
            print("No timer active, start the timer before you stop it.")
            return
        }
        internalTimer?.invalidate()
    }

    func stopTimer() {
        guard internalTimer != nil else {
            print("No timer active, start the timer before you stop it.")
            return
        }
        jobs = [() -> Void]()
        internalTimer?.invalidate()
    }

    @objc func doJob() {
        guard jobs.count > 0 else { return }
        for job in jobs {
            job()
        }
    }
}
