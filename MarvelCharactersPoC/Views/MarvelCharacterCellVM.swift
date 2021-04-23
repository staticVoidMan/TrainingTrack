//
//  MarvelCharacterCellVM.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 23/04/21.
//

import UIKit

class MarvelCharacterCellVM {
    
    private let character: Character
    
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
    
    init(character: Character) {
        self.character = character
    }
    
}
