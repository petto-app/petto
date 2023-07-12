//
//  GameCenter.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 25/06/23.
//

import Foundation
import GameKit
import SwiftUI

public struct GameCenterView: UIViewControllerRepresentable {
    let viewController: GKGameCenterViewController

    public init(viewState: GKGameCenterViewControllerState = .default) {
        viewController = GKGameCenterViewController(state: viewState)
    }

    public func makeCoordinator() -> GameCenterCoordinator {
        return GameCenterCoordinator(self)
    }

    public func makeUIViewController(context: Context) -> GKGameCenterViewController {
        let gameCenterViewController = viewController
        gameCenterViewController.gameCenterDelegate = context.coordinator
        return gameCenterViewController
    }

    public func updateUIViewController(_: GKGameCenterViewController, context _: Context) {}
}

public class GameCenterCoordinator: NSObject, GKGameCenterControllerDelegate {
    let view: GameCenterView

    init(_ view: GameCenterView) {
        self.view = view
    }

    public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
    }
}

struct GameCenterView_Previews: PreviewProvider {
    static var previews: some View {
        GameCenterView()
            .ignoresSafeArea()
    }
}
