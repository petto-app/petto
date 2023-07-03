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
    var statModel = StatModel.shared

    @Published var lastAccessedDate: Date?

    private let userDefaults = UserDefaults.standard
    private let calendar = Calendar.current

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
            DailyTaskItem(name: "Stand up for 30 minutes", amount: Int(totalStandTime), maxAmount: 30, coin: 50, isDone: false, type: .appleStandTime),
            DailyTaskItem(name: "Finish All Tasks", amount: 0, maxAmount: 5, coin: 100, isDone: false),
        ]

        resetTaskStatusIfNeeded()
        updateLastAccessedDate()
    }

    func updateDailyTasksData(totalStepCount: Int, totalStandTime: Int) -> Int {
        var updatedTasks: [DailyTaskItem] = []
        var coinAddition = 0

        for task in dailyTasks {
            var updatedTask = task

            if task.type == .stepCount {
                updatedTask.amount = totalStepCount
                if updatedTask.isDone != true { // if the task is not finished before
                    if totalStepCount >= task.maxAmount {
                        updatedTask.isDone = true
                        coinAddition += task.coin
                    }
                }
            } else if task.type == .appleStandTime {
                updatedTask.amount = totalStandTime
                if updatedTask.isDone != true { // if the task is not finished before
                    if totalStandTime >= task.maxAmount {
                        updatedTask.isDone = true
                        coinAddition += task.coin
                    }
                }
            }

            updatedTasks.append(updatedTask)
        }

        // Check total finished task as last daily task
        let completedTasks = updatedTasks.filter { $0.isDone }
        updatedTasks[dailyTasks.count - 1].amount = completedTasks.count
        if completedTasks.count >= updatedTasks[dailyTasks.count - 1].maxAmount {
            updatedTasks[dailyTasks.count - 1].isDone = true
        }

        dailyTasks = updatedTasks
        return coinAddition
    }

    var shouldRewardCoins: Bool {
        guard let lastAccessedDate = lastAccessedDate else {
            return false // First-time access, no reward yet
        }

        let currentDate = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: lastAccessedDate)
        let lastAccessedDay = calendar.date(from: components)!
        let currentDay = calendar.date(from: calendar.dateComponents([.year, .month, .day], from: currentDate))!

        return currentDay > lastAccessedDay
    }

    private func updateLastAccessedDate() {
        lastAccessedDate = Date()
        userDefaults.set(lastAccessedDate, forKey: "LastAccessedDate")
    }

    private func resetTaskStatusIfNeeded() {
        guard shouldRewardCoins else {
            return
        }

        var updatedTasks: [DailyTaskItem] = []
        for task in dailyTasks {
            var updatedTask = task
            updatedTask.isDone = false
            updatedTasks.append(updatedTask)
        }
    }
}
