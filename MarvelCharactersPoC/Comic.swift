//
//  Comic.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 07/05/21.
//

import Foundation

struct Comic: Decodable {
    let id: Int
    let title: String
    let description: String?
    
    let thumbnail: Thumbnail
}
