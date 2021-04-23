//
//  CharacterListVM.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 16/04/21.
//

import Foundation

class CharacterListVM {
    
    typealias Model = MarvelCharacterCellVM
    typealias LoadDataHandler = (Error?)->Void
    
    var characters = [Model]()
    
    let provider: CharacterProvider
    
    init(provider: CharacterProvider) {
        self.provider = provider
    }
    
    func loadData(with searchTerm: String, completion: @escaping LoadDataHandler) {
        provider.getCharacter(searchTerm: searchTerm) { [weak self] (result) in
            guard let _weakSelf = self else { return }
            
            switch result {
            case .success(let characters):
                let characters = characters.map(MarvelCharacterCellVM.init)
                _weakSelf.characters = characters
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
}
