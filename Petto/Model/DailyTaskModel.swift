//
//  DailyTaskModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 23/06/23.
//

import Foundation
import SwiftUI

enum DailyTaskType: Codable {
    case stepCount
    case appleStandTime
}

struct DailyTaskItem: Identifiable, Codable {
    public var id = UUID()
    public var name: String
    public var amount: Int? // How much the user has to move
    public var maxAmount: Int
    public var coin: Int
    public var isDone: Bool
    public var type: DailyTaskType?
}

class DailyTaskModel: ObservableObject {
    public static var shared: DailyTaskModel = .init()
    var HKModel = HealthKitModel.shared

    @AppStorage("dailyTasks")
    var dailyTasksData: Data = .init()

    var dailyTasks: [DailyTaskItem] {
        get {
            if let decodedItems = try? JSONDecoder().decode([DailyTaskItem].self, from: dailyTasksData) {
                return decodedItems
            }
            return []
        }
        set {
            if let encodedItems = try? JSONEncoder().encode(newValue) {
                dailyTasksData = encodedItems
            }
        }
    }

    init() {
        let totalStepCount = HKModel.totalStepCount
        let totalStandTime = HKModel.totalStandTime

        dailyTasks = [
            DailyTaskItem(name: "Take 1000 steps", amount: Int(totalStepCount), maxAmount: 1000, coin: 10, isDone: false, type: .stepCount),
            DailyTaskItem(name: "Take 5000 steps", amount: Int(totalStepCount), maxAmount: 5000, coin: 50, isDone: false, type: .stepCount),
            DailyTaskItem(name: "Stand up for 10 minutes", amount: Int(totalStandTime), maxAmount: 10, coin: 10, isDone: false, type: .appleStandTime),
            DailyTaskItem(name: "Stand up for 30 minutes", amount: Int(totalStandTime), maxAmount: 10, coin: 50, isDone: false, type: .appleStandTime),
            DailyTaskItem(name: "Finish All Tasks", amount: 0, maxAmount: 5, coin: 100, isDone: false),
        ]
    }
}
