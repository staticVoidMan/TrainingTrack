//
//  CharacterProvider_Dummy.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 23/04/21.
//

class CharacterProvider_Dummy: CharacterProvider {
    
    func getCharacters(searchTerm: String, completion: @escaping CharacterProviderHandler) {
        let characters = [Character(id: 0,
                                    name: "Character X",
                                    description: "Character Description",
                                    thumbnail: .init(path: "", ext: ""))]
        
        let result = characters.filter { $0.name.lowercased().contains(searchTerm) }
        completion(.success(result))
    }
    
}
