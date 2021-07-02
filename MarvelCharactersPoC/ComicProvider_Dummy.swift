//
//  ComicProvider_Dummy.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 02/07/21.
//

import Foundation

class ComicProvider_Dummy: ComicProvider {
    
    func getComics(searchTerm: String, completion: @escaping ComicProviderHandler) {
        let characters = [Comic(id: 0,
                                title: "Comic X",
                                description: "Comic Description",
                                thumbnail: .init(path: "", ext: ""))]
        
        let result = characters.filter { $0.title.lowercased().contains(searchTerm) }
        completion(.success(result))
    }
    
}
