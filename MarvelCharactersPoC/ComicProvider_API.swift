//
//  ComicProvider_API.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 07/05/21.
//

import Foundation

struct ComicProvider_API: ComicProvider {
    
    func getComics(searchTerm: String, completion: @escaping ComicProviderHandler) {
        let urlString = "http://gateway.marvel.com/v1/public/comics?titleStartsWith=\(searchTerm)"
        
        let (publicKey, privateKey): (String, String) = {
            guard let filePath = Bundle.main.path(forResource: "Marvel-Info", ofType: "plist"),
                  let dict = NSDictionary(contentsOfFile: filePath)
            else { fatalError("'Marvel-Info.plist' file missing") }
            
            guard let publicKey = dict["publicKey"] as? String,
                  let privateKey = dict["privateKey"] as? String,
                  publicKey.starts(with: "_") == false,
                  privateKey.starts(with: "_") == false
            else {
                fatalError("Please generate API keys. See: https://developer.marvel.com/documentation/getting_started")
            }
            return (publicKey, privateKey)
        }()
        
        let ts = String(Date.timeIntervalSinceReferenceDate)
        let hash = (ts + privateKey + publicKey).md5

        let finalURLString = "\(urlString)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        print("Comic API: \(finalURLString)")
        let url = URL(string: finalURLString)!
        
        struct QuickResponse: Decodable {
            struct Data: Decodable {
                let results: [Comic]
            }
            
            let data: Data
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(QuickResponse.self, from: data)
                    let items = result.data.results
                    completion(.success(items))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            } else {
                let error = error ?? NSError()
                completion(.failure(error))
            }
        }.resume()
    }
    
}
