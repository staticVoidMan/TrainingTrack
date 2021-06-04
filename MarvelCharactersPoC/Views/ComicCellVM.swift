//
//  ComicCellVM.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 04/06/21.
//

import UIKit

class ComicCellVM {
    
    private let comic: Comic
    
    init(comic: Comic) {
        self.comic = comic
    }
    
}

extension ComicCellVM: HomeCellVM {
    
    var name: String { comic.title }
    
    var description: String { comic.description ?? "" }
    
    var imageURL: URL? { comic.thumbnail.url }
    
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
