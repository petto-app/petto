//
//  PlayerModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 25/06/23.
//

import GameKit
import SwiftUI

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
    public static var shared: PlayerModel = .init()

    private(set) lazy var isAuthenticated: Bool = localPlayer.isAuthenticated
}
