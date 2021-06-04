//
//  ComicProvider.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 07/05/21.
//

typealias ComicProviderHandler = (Result<[Comic],Error>)->Void

protocol ComicProvider {
    
    func getComics(searchTerm: String, completion: @escaping ComicProviderHandler)
    
}
