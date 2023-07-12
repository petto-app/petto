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
    public var image: String
}

class BodyMovementTaskModel: ObservableObject  {
    public static var shared: BodyMovementTaskModel = .init()
    
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
        bodyMovementTasks = [
            BodyMovementTaskItem(movementType: .turningHead, amount: 3, coin: 100, image: "shiba-1"),
            BodyMovementTaskItem(movementType: .twistingBody, amount: 3, coin: 100, image: "shiba-1"),
            BodyMovementTaskItem(movementType: .pullingBody, amount: 3, coin: 100, image: "shiba-1"),
        ]
    }
    
    func getRandomTask() -> BodyMovementTaskItem? {
        guard !bodyMovementTasks.isEmpty else {
            return nil
        }
        let randomIndex = Int.random(in: 0..<bodyMovementTasks.count)
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
}
