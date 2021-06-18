//
//  ComicProvider_API.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 07/05/21.
//

import Foundation

struct ComicProvider_API: ComicProvider {
    
    func getComics(searchTerm: String, completion: @escaping ComicProviderHandler) {
        let query = [URLQueryItem(name: "titleStartsWith", value: searchTerm)]
        
        NetworkManager<[Comic]>.execute(url: APIEndpoint.comics,
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
