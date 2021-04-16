//
//  CharacterListVM.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 16/04/21.
//

import Foundation

class CharacterListVM {
    
    typealias Model = Character
    typealias LoadDataHandler = (Result<[Model], Error>)->Void
    
    var characters = [Model]()
    
    init() {}
    
    func loadData(with searchTerm: String, completion: @escaping LoadDataHandler) {
        let urlString = "http://gateway.marvel.com/v1/public/characters?nameStartsWith=\(searchTerm)"
        
        let ts = String(Date.timeIntervalSinceReferenceDate)
        let publicKey = "2ab0c2839993abfa954d65637b1ae3f0"
        let hash: String = {
            let privateKey = "fb582aca902a4d9ea427137cc1dc63462b28b147"
            return (ts + privateKey + publicKey).md5
        }()

        let finalURLString = "\(urlString)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        let url = URL(string: finalURLString)!
        
        struct QuickResponse: Decodable {
            struct Data: Decodable {
                let results: [Model]
            }
            
            let data: Data
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(QuickResponse.self, from: data)
                    let characters = result.data.results
                    self.characters = characters
                    completion(.success(characters))
                } catch {
                    completion(.failure(error))
                }
            } else {
                let error = error ?? NSError()
                completion(.failure(error))
            }
        }.resume()
    }
    
}
