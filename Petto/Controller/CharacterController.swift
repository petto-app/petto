//
//  CharacterController.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 13/07/23.
//

import Foundation
import SwiftUI

class CharacterController: ObservableObject {
    @ObservedObject var characterModel = CharacterModel.shared

    func getCharacter() -> String {
        return characterModel.currentCharacter ?? "dog"
    }

    func setCharacter(character: CharacterType) {
        characterModel.setCharacter(character: character.rawValue)
    }
}
