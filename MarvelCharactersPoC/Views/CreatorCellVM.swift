//
//  CreatorCellVM.swift
//  MarvelCharactersPoC
//
//  Created by codewalla on 11/06/21.
//

import Foundation

class CreatorCellVM {
    
    private let creator: Creator
    
    init(creator: Creator) {
        self.creator = creator
    }
}


extension CreatorCellVM: HomeCellVM {
    var name: String { creator.fullName }
    
    var description: String { creator.modified ?? "" }
    
    var imageURL: URL? { creator.thumbnail.url }
    
}
