//
//  GameKitController.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 25/06/23.
//

import Foundation
import GameKit
import SwiftUI

class GameKitController: NSObject, GKLocalPlayerListener {
//    @ObservedObject var playerModel = PlayerModel()
    var playerModel = PlayerModel.shared

    func authenticateUser() {
        playerModel.localPlayer.authenticateHandler = { [self] _, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }

            GKAccessPoint.shared.isActive = false

            if playerModel.localPlayer.isAuthenticated {
                playerModel.localPlayer.register(self)
            }
        }
    }
}
