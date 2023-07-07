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

struct DailyTaskItem: Identifiable, Codable, Hashable {
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

    @AppStorage("lastAccessedDate")
    var lastAccessedDateData: Data = .init()
    
    var lastAccessedDate: Date? {
        get {
            if let decodedItems = try? JSONDecoder().decode(Date.self, from: lastAccessedDateData) {
                return decodedItems
            }
            return Date()
        }
        set {
            if let encodedItems = try? JSONEncoder().encode(newValue) {
                lastAccessedDateData = encodedItems
            }
        }
    }

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
        if dailyTasks != [] {
            let currentDate = Date()
            let lastAccessed = lastAccessedDate
            
            if !isSameDay(currentDate, lastAccessed!) {
                initNewDailyTasks()
                lastAccessedDate = Date()
            }
        } else {
            initNewDailyTasks()
            lastAccessedDate = Date()
        }
    }
    
    private func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    private func initNewDailyTasks() {
        let totalStepCount = HKModel.totalStepCount
        let totalStandTime = HKModel.totalStandTime
        
        // Initialize new daily tasks data
        dailyTasks = [
            DailyTaskItem(name: "Take 1000 steps", amount: Int(totalStepCount), maxAmount: 100, coin: 10, isDone: false, type: .stepCount),
            DailyTaskItem(name: "Take 5000 steps", amount: Int(totalStepCount), maxAmount: 150, coin: 50, isDone: false, type: .stepCount),
            DailyTaskItem(name: "Stand up for 10 minutes", amount: Int(totalStandTime), maxAmount: 1, coin: 10, isDone: false, type: .appleStandTime),
            DailyTaskItem(name: "Stand up for 30 minutes", amount: Int(totalStandTime), maxAmount: 31, coin: 50, isDone: false, type: .appleStandTime),
            DailyTaskItem(name: "Finish All Tasks", amount: 0, maxAmount: 4, coin: 100, isDone: false)
        ]
    }

    func updateDailyTasksData(totalStepCount: Int, totalStandTime: Int) -> [DailyTaskItem] {
        var updatedTasks: [DailyTaskItem] = []
        var changedTasks: [DailyTaskItem] = []

        for task in dailyTasks {
            var updatedTask = task

            if task.type == .stepCount {
                updatedTask.amount = totalStepCount
                if updatedTask.isDone != true { // if the task is not finished before
                    if totalStepCount >= task.maxAmount {
                        changedTasks.append(updatedTask)
                    }
                }
            } else if task.type == .appleStandTime {
                updatedTask.amount = totalStandTime
                if updatedTask.isDone != true { // if the task is not finished before
                    if totalStandTime >= task.maxAmount {
                        changedTasks.append(updatedTask)
                    }
                }
            }

            updatedTasks.append(updatedTask)
        }

        dailyTasks = updatedTasks
        return changedTasks
    }
}
