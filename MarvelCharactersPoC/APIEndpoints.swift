//
//  APIEndpoints.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 18/06/21.
//

import Foundation

enum APIEndpoint {
    static var baseURL = "http://gateway.marvel.com/v1/public"
    
    static var character = "\(baseURL)/characters"
    static var comics = "\(baseURL)/comics"
}
