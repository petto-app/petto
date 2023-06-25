//
//  PlayerModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 25/06/23.
//

import SwiftUI
import GameKit

struct Player {
    public let id: String
    public let displayName: String
    public let photo: Image?
    public let leaderboard: Leaderboard

    public struct Leaderboard {
        public let rank: Int
        public let score: Int // TODO: Total coin
    }
}

class PlayerModel: ObservableObject {
    @Published var localPlayer = GKLocalPlayer.local
    
    // Create as a Singleton to avoid more than one instance.
    public static var shared: PlayerModel = PlayerModel()
    
    lazy private (set) var isAuthenticated: Bool = {
        return localPlayer.isAuthenticated
    }()
}
