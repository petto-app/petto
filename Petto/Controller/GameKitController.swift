//
//  GameKitController.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 25/06/23.
//

import Foundation
import GameKit
import SwiftUI

class GameKitController: NSObject, GKLocalPlayerListener, ObservableObject {
    @ObservedObject var playerModel = PlayerModel.shared
    @ObservedObject var statModel = StatModel.shared

    let LEADERBOARD_ID = "com.pettoteam.pettolife.highscore"

    override init() {
        super.init()

        authenticateUser { [self] success in
            if success {
                self.reportScore(totalCoin: statModel.totalCoin!)
            }
        }
    }

    func authenticateUser(completion: @escaping (Bool) -> Void) {
        playerModel.localPlayer.authenticateHandler = { [self] _, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                completion(false)
                return
            }

            // Turn off Game Kit Active Indicator
            GKAccessPoint.shared.isActive = false

            if playerModel.localPlayer.isAuthenticated {
                playerModel.localPlayer.register(self)
                completion(true)
            }
        }
    }

    func reportScore(totalCoin: Int) {
        if playerModel.localPlayer.isAuthenticated {
            GKLeaderboard.submitScore(
                totalCoin,
                context: 0,
                player: playerModel.localPlayer,
                leaderboardIDs: [LEADERBOARD_ID]
            ) { error in
                print("Leaderboard Submit Score Error:")
                print(error)
            }
            print("Score submitted: \(totalCoin)")
        }
    }
}
