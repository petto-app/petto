//
//  BodyMovementTaskModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 23/06/23.
//

import Foundation

enum BodyMovementType: Codable {
    case turningHead
    case twistingBody
    case pullingBody
}

struct BodyMovementTaskItem: Identifiable, Codable {
    public var id = UUID()
    public var name: String
    public var coin: Int
    public var amount: Int  // How much the user has to move
    public var description: String
    public var image: String
    public var movementType: BodyMovementType?
}

class BodyMovementTaskModel {
    @Published var bodyMovementTasks: [BodyMovementTaskItem]?
    
    init(bodyMovementTasks: [BodyMovementTaskItem]? = nil) {
        self.bodyMovementTasks = bodyMovementTasks
    }
}

