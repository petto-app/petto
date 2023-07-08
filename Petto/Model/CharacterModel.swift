//
//  CharacterModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 23/06/23.
//

import Foundation

enum CharacterType: String, CaseIterable {
    case dog
    case cat
}

struct Character: Codable {
    public var type: String
    public var image: String
}

class CharacterModel {
    @Published var characters: [Character]?
//    @Published var currentCharacter: Character
    // TODO: Using one character only

    init(characters: [Character]? = nil) {
        self.characters = characters
    }
}
