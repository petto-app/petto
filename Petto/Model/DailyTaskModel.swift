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
    public var coin: Int
    public var amount: Int // How much the user has to move
    public var description: String
}

class DailyTaskModel {
    public static var shared: DailyTaskModel = .init()
    @Published var dailyTasks: [DailyTaskItem]?

    init(dailyTasks: [DailyTaskItem]? = nil) {
        self.dailyTasks = dailyTasks
    }
}
