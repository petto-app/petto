//
//  CharacterModel.swift
//  Petto
//
//  Created by Carissa Farry Hilmi Az Zahra on 23/06/23.
//

import Foundation

struct Character: Codable {
    public var name: String
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
