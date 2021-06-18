//
//  CharacterProvider_API.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 23/04/21.
//

import Foundation

struct CharacterProvider_API: CharacterProvider {
    
    func getCharacters(searchTerm: String, completion: @escaping CharacterProviderHandler) {
        let query = [URLQueryItem(name: "nameStartsWith", value: searchTerm)]
        
        NetworkManager<[Character]>.execute(url: APIEndpoint.character,
                                            method: .get(query: query)) { (result) in
            switch result {
            case .success(let items):
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
