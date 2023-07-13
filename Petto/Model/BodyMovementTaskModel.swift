//
//  BodyMovementTaskModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 23/06/23.
//

import Foundation
import SwiftUI

enum BodyMovementType: Codable {
    case turningHead
    case twistingBody
    case pullingBody
}

struct BodyMovementTaskItem: Identifiable, Codable {
    public var id = UUID()
    public var movementType: BodyMovementType?
    public var amount: Int // How much the user has to move
    public var coin: Int
    public var images: [String]
}

class BodyMovementTaskModel: ObservableObject {
    public static var shared: BodyMovementTaskModel = .init()
    
    @Published var coinPerPrimeTime: Int = 0
    
    @ObservedObject var timeModel = TimeModel()
    
    @AppStorage("bodyMovementTasks")
    var bodyMovementTasksData: Data = .init()

    var bodyMovementTasks: [BodyMovementTaskItem] {
        get {
            if let decodedItems = try? JSONDecoder().decode([BodyMovementTaskItem].self, from: bodyMovementTasksData) {
                return decodedItems
            }
            return []
        }
        set {
            if let encodedItems = try? JSONEncoder().encode(newValue) {
                bodyMovementTasksData = encodedItems
            }
        }
    }

    init() {
        countCoinPerPrimeTime()
        
        // TODO: Insert images for each task
        bodyMovementTasks = [
            BodyMovementTaskItem(movementType: .turningHead, amount: 3, coin: coinPerPrimeTime, images: ["shiba-1", "shiba-2", "shiba-3"]),
            BodyMovementTaskItem(movementType: .twistingBody, amount: 3, coin: coinPerPrimeTime, images: ["shiba-1", "shiba-2", "shiba-3"]),
            BodyMovementTaskItem(movementType: .pullingBody, amount: 3, coin: coinPerPrimeTime, images: ["shiba-1", "shiba-2", "shiba-3"]),
        ]
    }
    
    private func countCoinPerPrimeTime() {
        // Count coin for each prime time based on how much prime time
        let totalPrimeTime = getPrimeTimeHours(startHour: timeModel.timeConfig?.startHour ?? 9, endHour: timeModel.timeConfig?.finishHour ?? 17, intervalHour: timeModel.timeConfig?.interval ?? 2).count
        
        coinPerPrimeTime = Int(1000/totalPrimeTime)
    }
    func getRandomTask() -> BodyMovementTaskItem? {
        guard !bodyMovementTasks.isEmpty else {
            return nil
        }
        let randomIndex = Int.random(in: 0 ..< bodyMovementTasks.count)
        return bodyMovementTasks[randomIndex]
    }

    func getStringType(item: BodyMovementTaskItem) -> String {
        switch item.movementType {
        case .pullingBody:
            return "Pulling Body"
        case .turningHead:
            return "Turning Head"
        case .twistingBody:
            return "Twisting Body"
        case .none:
            return ""
        }
    }
    
    func getFirstDialogMessage(item: BodyMovementTaskItem) -> String {
        switch item.movementType {
            case .pullingBody:
                return "Let's pulling your body now!"
            case .turningHead:
                return "Let's Turning your head now!"
            case .twistingBody:
                return "Let's twisting your body now!"
            case .none:
                return ""
        }
    }
}
