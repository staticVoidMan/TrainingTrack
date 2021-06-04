//
//  CharacterCellVM.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 04/06/21.
//

import UIKit

class CharacterCellVM {
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
}

extension CharacterCellVM: HomeCellVM {
    
    var name: String { character.name }
    
    var description: String { character.description }
    
    var imageURL: URL? { character.thumbnail.url }
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = imageURL else { completion(nil); return }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                completion(image)
            } catch {
                print(error)
                completion(nil)
            }
        }
    }
    
}
