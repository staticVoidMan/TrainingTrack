//
//  HomeVM.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 04/06/21.
//

import Foundation

class HomeVM {
    
    enum ContentType: Int {
        case characters
        case comics
    }
    
    private(set) var selectedContent: ContentType = .characters
    private let characterProvider: CharacterProvider
    private let comicProvider: ComicProvider
    
    var items: [HomeCellVM] {
        switch selectedContent {
        case .characters:
            return characters
        case .comics:
            return comics
        }
    }
    private var characters: [CharacterCellVM] = []
    private var comics: [ComicCellVM] = []
    
    init(selectedContent: ContentType = .characters,
         characterProvider: CharacterProvider,
         comicProvider: ComicProvider) {
        self.selectedContent = selectedContent
        self.characterProvider = characterProvider
        self.comicProvider = comicProvider
    }
    
    func segmentChanged(_ type: ContentType?) {
        guard let type = type else { return }
        selectedContent = type
    }
    
    func loadData(searchTerm: String, completion: @escaping ()->Void) {
        switch selectedContent {
        case .characters:
            characterProvider.getCharacters(searchTerm: searchTerm) { result in
                switch result {
                case .success(let characters):
                    self.characters = characters.map(CharacterCellVM.init)
                    
                    completion()
                case.failure(let error):
                    print(error)
                }
            }
        case .comics:
            comicProvider.getComics(searchTerm: searchTerm) { result in
                switch result {
                case .success(let comics):
                    self.comics = comics.map(ComicCellVM.init)
                    
                    completion()
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
    
}
