//
//  CharacterProvider.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 23/04/21.
//

typealias CharacterProviderHandler = (Result<[Character],Error>)->Void

protocol CharacterProvider {
    
    func getCharacters(searchTerm: String, completion: @escaping CharacterProviderHandler)
    
}
