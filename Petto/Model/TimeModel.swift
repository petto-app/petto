//
//  TimeModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 22/06/23.
//

import Foundation
import SwiftUI

struct TimeConfig: Codable {
    public var startTime: Date
    public var interval: Int  // In hour
}

class TimeModel {
    var minIntervalHour = 1;
    var maxIntervalHour = 3;
    
    init(minIntervalHour: Int = 1, maxIntervalHour: Int = 3) {
        self.minIntervalHour = minIntervalHour
        self.maxIntervalHour = maxIntervalHour
    }
}
