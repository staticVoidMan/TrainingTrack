//
//  HomeVM.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 04/06/21.
//

import Foundation

class HomeVM {
    
    enum ContentType: String {
        case characters
        case comics
        case creators
    }
    
    private var selectedContent: ContentType = .characters
    private let characterProvider: CharacterProvider
    private let comicProvider: ComicProvider
    private let creatorProvider: CreatorProvider
    
    //HomecellVM is protocol
    var items: [HomeCellVM] {
        switch selectedContent {
        case .characters:
            return characters
        case .comics:
            return comics
        case .creators:
            return creators
        }
    }
    // characterCellVm implements homecellvmm but it has another variable will it affect the array type how inheritance plays role here
    private var characters: [CharacterCellVM] = []
    private var comics: [ComicCellVM] = []
    private var creators: [CreatorCellVM] = []
    
    init(selectedContent: ContentType = .characters,
         characterProvider: CharacterProvider,
         comicProvider: ComicProvider,
         creatorProvider: CreatorProvider) {
        self.selectedContent = selectedContent
        self.characterProvider = characterProvider
        self.comicProvider = comicProvider
        self.creatorProvider = creatorProvider
    }
    
    func segmentChanged(_ index: Int) {
        
        switch index {
        case 1:
            selectedContent = .comics
        case 2:
            selectedContent = .creators
        default:
            selectedContent = .characters
        }
       
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
        case .creators:
            creatorProvider.getCreators(searchTerm: searchTerm) { (result) in
                switch result {
                case .success(let creator):
                    self.creators = creator.map(CreatorCellVM.init)
                    completion()
                case.failure(let error):
                    print(error)
                
                }
            }
            
            break
        }
    }
    
}
