//
//  Creator.swift
//  MarvelCharactersPoC
//
//  Created by codewalla on 10/06/21.
//

import Foundation

struct Creator: Decodable {
    let id: Int
    let fullName: String
    let modified: String?
    
    let thumbnail: Thumbnail
}
