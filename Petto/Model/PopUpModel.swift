//
//  PopUpModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 06/07/23.
//

import Foundation
import SwiftUI

enum PopUpItemType: Equatable, Codable {
    case dailyTask
    case bodyMovementTask
}

enum PopUpState: Equatable, Codable {
    case hidden
    case showing(totalCoin: Int)
}

struct PopUpItem: Codable, Equatable {
    static func == (lhs: PopUpItem, rhs: PopUpItem) -> Bool {
        return lhs.id == rhs.id
    }

    var id = UUID()
    var type: PopUpItemType
    var dailyTask: DailyTaskItem?
    var bodyMovementTask: BodyMovementTaskItem?
    var state: PopUpState
}

class PopUpModel: ObservableObject {
    public static var shared: PopUpModel = .init()

    @ObservedObject var dailyTaskModel = DailyTaskModel.shared

    @AppStorage("popUpItems")
    var popUpData: Data = .init()

    var popUpItems: [PopUpItem] {
        get {
            if let decodedItems = try? JSONDecoder().decode([PopUpItem].self, from: popUpData) {
                return decodedItems
            }
            return []
        }
        set {
            if let encodedItems = try? JSONEncoder().encode(newValue) {
                popUpData = encodedItems
            }
        }
    }

    func showDailyTaskPopUps(_ dailyTasks: [DailyTaskItem]) {
        var newPopUpItems: [PopUpItem] = []

        for task in dailyTasks {
            let popUpItem = PopUpItem(type: .dailyTask, dailyTask: task, state: .showing(totalCoin: task.coin))
            newPopUpItems.append(popUpItem)
        }

        DispatchQueue.main.async {
            self.popUpItems = newPopUpItems
        }
    }

    func isExists() -> Bool {
        return !popUpItems.isEmpty
    }

    func addItem(_ item: PopUpItem) {
        var updatedItems = popUpItems
        updatedItems.append(item)
        popUpItems = updatedItems
    }
}
