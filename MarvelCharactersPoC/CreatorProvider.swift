//
//  CreatorProvider.swift
//  MarvelCharactersPoC
//
//  Created by codewalla on 10/06/21.
//

import Foundation

typealias CreatorProviderHandler = (Result<[Creator],Error>) -> Void

protocol CreatorProvider {
    
    func getCreators(searchTerm: String, completion: @escaping CreatorProviderHandler)
}
