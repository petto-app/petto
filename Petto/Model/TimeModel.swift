//
//  TimeModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 22/06/23.
//

import Foundation
import SwiftUI

struct TimeConfig: Codable {
    var startHour: Int
    var finishHour: Int
    var interval: Int = 2 // In hour
}

class TimeModel: ObservableObject {
    private var _minIntervalHour = 1
    private var _maxIntervalHour = 3

    @AppStorage("timeConfig")
    var timeConfigData: Data?

    var timeConfig: TimeConfig? { // Wrapper
        get {
            if timeConfigData == nil {
                if let encodedItems = try? JSONEncoder().encode(TimeConfig(startHour: 9, finishHour: 17)) {
                    timeConfigData = encodedItems
                }
            }
            if let decodedItems = try? JSONDecoder().decode(TimeConfig.self, from: timeConfigData!) {
                return decodedItems
            }
            return nil
        }
        set {
            // Update the AppStorage value
            if let encodedItems = try? JSONEncoder().encode(newValue) {
                timeConfigData = encodedItems
            }
        }
    }

    init(minIntervalHour: Int = 1, maxIntervalHour: Int = 3) {
        _minIntervalHour = minIntervalHour
        _maxIntervalHour = maxIntervalHour
    }

    var minIntervalHour: Int {
        set {
            _minIntervalHour = newValue
        }
        get { return _minIntervalHour }
    }

    var maxIntervalHour: Int {
        set {
            _maxIntervalHour = newValue
        }
        get { return _maxIntervalHour }
    }

    var primeTimeHours: [Int] {
        return getPrimeTimeHours(startHour: timeConfig?.finishHour ?? 0, endHour: timeConfig?.finishHour ?? 0, intervalHour: timeConfig?.interval ?? 0)
    }
}
