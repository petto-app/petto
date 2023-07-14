//
//  BodyMovementTaskModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 23/06/23.
//

import Foundation
import SpriteKit
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

    @AppStorage("character")
    var currentCharacter: String?

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
        update()
    }
    
    private func update() {
        countCoinPerPrimeTime()

        var idleFrameAtlas = SKTextureAtlas(named: currentCharacter == "dog" ? "DawgHeadTilt" : "CatHeadTilt")
        let turningHead = idleFrameAtlas.textureNames.sorted()

        idleFrameAtlas = SKTextureAtlas(named: currentCharacter == "dog" ? "DawgBodyTilt" : "CatBodyTilt")
        let twistingBody = idleFrameAtlas.textureNames.sorted()

        idleFrameAtlas = SKTextureAtlas(named: currentCharacter == "dog" ? "DawgStretch" : "CatStretch")
        let pullingBody = idleFrameAtlas.textureNames.sorted()
        // TODO: Insert images for each task
        bodyMovementTasks = [
            BodyMovementTaskItem(movementType: .turningHead, amount: 3, coin: coinPerPrimeTime, images: turningHead),
            BodyMovementTaskItem(movementType: .twistingBody, amount: 3, coin: coinPerPrimeTime, images: twistingBody),
            BodyMovementTaskItem(movementType: .pullingBody, amount: 3, coin: coinPerPrimeTime, images: pullingBody)
        ]
    }

    private func countCoinPerPrimeTime() {
        // Count coin for each prime time based on how much prime time
        let totalPrimeTime = getPrimeTimeHours(startHour: timeModel.timeConfig?.startHour ?? 9, endHour: timeModel.timeConfig?.finishHour ?? 17, intervalHour: timeModel.timeConfig?.interval ?? 2).count

        coinPerPrimeTime = Int(1000 / totalPrimeTime)
    }

    func getRandomTask() -> BodyMovementTaskItem? {
        update()
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
            return "Let's pulling your body \(item.amount) times now!"
        case .turningHead:
            return "Let's Turning your head \(item.amount) times now!"
        case .twistingBody:
            return "Let's twisting your body \(item.amount) times now!"
        case .none:
            return ""
        }
    }
}
