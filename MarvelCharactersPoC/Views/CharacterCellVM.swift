//
//  CharacterCellVM.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 04/06/21.
//

import UIKit

class CharacterCellVM {
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
}

extension CharacterCellVM: HomeCellVM {
    
    var name: String { character.name }
    
    var description: String { character.description }
    
    var imageURL: URL? { character.thumbnail.url }
    
}
