//
//  CharacterModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 23/06/23.
//

import Foundation
import SwiftUI

enum CharacterType: String, CaseIterable {
    case dog
    case cat
}

struct Character: Codable {
    public var type: String
}

class CharacterModel: ObservableObject {
    public static var shared: CharacterModel = .init()
    @Published var characters: [Character]?

    @AppStorage("character")
    var currentCharacter: String = "dog"

    init(characters: [Character]? = nil) {
        self.characters = characters
    }

    func setCharacter(character: String) {
        currentCharacter = character
    }
}
