//
//  CharacterProvider_Dummy.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 23/04/21.
//

class CharacterProvider_Dummy: CharacterProvider {
    
    func getCharacters(searchTerm: String, completion: @escaping CharacterProviderHandler) {
        let result = [Character(id: 0, name: "Random Name",
                                description: "Random Description",
                                thumbnail: .init(path: "", ext: ""))]
        completion(.success(result))
    }
    
}
