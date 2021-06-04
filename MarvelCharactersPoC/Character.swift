//
//  Character.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 16/04/21.
//

import Foundation

struct Character: Decodable {
    
    let id: Int
    let name: String
    let description: String
    
    let thumbnail: Thumbnail
    
}
