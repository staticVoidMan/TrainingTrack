//
//  CreatorProvider_API.swift
//  MarvelCharactersPoC
//
//  Created by codewalla on 11/06/21.
//

import Foundation

struct QuickResponseNew <T: Decodable> : Decodable {
    struct Data: Decodable {
        let results: [T]
    }
    ///Error comes like "Type 'QuickResponseNew.Data' does not conform to protocol 'Decodable'"
    let data: Data
}


struct CreatorProvider_API: CreatorProvider {
    func getCreators(searchTerm: String, completion: @escaping CreatorProviderHandler) {
        let urlString = "http://gateway.marvel.com/v1/public/creators?nameStartsWith=\(searchTerm)"
        
        print("urlString: \(urlString)")
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
        print("creator API: \(finalURLString)")
        let url = URL(string: finalURLString)!
        
        //This struct used thrice usually what will be the generic way

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(QuickResponseNew<Creator>.self, from: data)
                    let creators = result.data.results
                    completion(.success(creators))
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
