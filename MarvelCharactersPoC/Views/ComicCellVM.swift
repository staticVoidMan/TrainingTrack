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
    
}
