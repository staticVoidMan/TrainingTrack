//
//  Character.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 16/04/21.
//

import Foundation

struct Character: Decodable {
    
    struct Thumbnail: Decodable {
        var path: String
        var ext: String
        
        var url: URL? { URL(string: "\(path).\(ext)") }
        
        enum CodingKeys: String, CodingKey {
            case path
            case ext = "extension"
        }
    }
    
    let id: Int
    let name: String
    let description: String
    
    let thumbnail: Thumbnail
    
}
