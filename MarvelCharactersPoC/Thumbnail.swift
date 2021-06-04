//
//  Thumbnail.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 07/05/21.
//

import Foundation

struct Thumbnail: Decodable {
    var path: String
    var ext: String
    
    var url: URL? { URL(string: "\(path).\(ext)") }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
