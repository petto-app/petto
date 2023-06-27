//
//  DailyTaskModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 23/06/23.
//

import Foundation

struct DailyTaskItem: Identifiable, Codable {
    public var id = UUID()
    public var name: String
    public var amount: Int // How much the user has to move
    public var maxAmount: Int
    public var coin: Int
    public var isDone: Bool
}

class DailyTaskModel: ObservableObject {
    public static var shared: DailyTaskModel = DailyTaskModel()
    @Published var dailyTasks: [DailyTaskItem]

    init() {
        self.dailyTasks = [
            DailyTaskItem(name: "Take 1000 steps", amount: 100, maxAmount: 1000, coin: 10, isDone: false),
            DailyTaskItem(name: "Take 5000 steps", amount: 100, maxAmount: 5000, coin: 50, isDone: false),
            DailyTaskItem(name: "Stand up for 10 minutes", amount: 5, maxAmount: 10, coin: 10, isDone: false),
            DailyTaskItem(name: "Stand up for 30 minutes", amount: 5, maxAmount: 10, coin: 50, isDone: false),
            DailyTaskItem(name: "Finish All Tasks", amount: 0, maxAmount: 5, coin: 100, isDone: false)
        ]
    }
}
