//
//  NetworkManager.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 18/06/21.
//

import Foundation

enum APIError: Error {
    case noData
    case urlInvalid(url: String)
    case parsingFailed(_ error: Error)
    case requestError(_ error: Error)
}

class NetworkManager<Model: Decodable> {
    
    typealias NetworkManagerCompletion = (Result<Model,APIError>)->Void
    
    enum MethodType {
        case get(query: [URLQueryItem]?)
        case post(payload: Data?)
        
        var query: [URLQueryItem]? {
            switch self {
            case .get(let query) : return query
            case .post           : return nil
            }
        }
        
        var payload: Data? {
            switch self {
            case .get               : return nil
            case .post(let payload) : return payload
            }
        }
    }
    
    private struct SecurityParameters {
        let publicKey: String
        let hash: String
        let timeStamp: String
    }
    
    private static func getSecurityParameters() -> SecurityParameters {
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
        
        return .init(publicKey: publicKey, hash: hash, timeStamp: ts)
    }
    
    private static func getSecureRequest(for urlString: String, method: MethodType) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: urlString)
        else { throw APIError.urlInvalid(url: urlString) }
        
        urlComponents.queryItems = {
            let security = getSecurityParameters()
            let queryItems: [URLQueryItem] = method.query ?? []
            let securityQueryItems = [URLQueryItem(name: "ts", value: security.timeStamp),
                                      URLQueryItem(name: "apikey", value: security.publicKey),
                                      URLQueryItem(name: "hash", value: security.hash)]
            return queryItems + securityQueryItems
        }()
        
        guard let finalURL = urlComponents.url
        else { throw APIError.urlInvalid(url: urlComponents.string ?? urlString) }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = {
            switch method {
            case .get  : return "GET"
            case .post : return "POST"
            }
        }()
        request.httpBody = method.payload
        
        return request
    }
    
    struct BaseResponse: Decodable {
        struct Data: Decodable {
            let results: Model
        }
        
        let data: Data
    }
    
    static func execute(url urlString: String, method: MethodType, completion: @escaping NetworkManagerCompletion) {
        do {
            let request = try getSecureRequest(for: urlString, method: method)
            
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(BaseResponse.self, from: data)
                        let model = result.data.results
                        completion(.success(model))
                    } catch {
                        completion(.failure(.parsingFailed(error)))
                    }
                } else if let error = error {
                    completion(.failure(.requestError(error)))
                } else {
                    completion(.failure(.noData))
                }
            }.resume()
        } catch {
            if let error = error as? APIError {
                completion(.failure(error))
            } else {
                fatalError(error.localizedDescription)
            }
        }
    }
    
}
