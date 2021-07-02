//
//  HomeVMTests.swift
//  MarvelCharactersPoCTests
//
//  Created by Amin Siddiqui on 02/07/21.
//

import XCTest
@testable import MarvelCharactersPoC

class HomeVMTests: XCTestCase {
    
    var viewModel: HomeVM!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeVM(characterProvider : CharacterProvider_Dummy(),
                           comicProvider     : ComicProvider_Dummy())
    }
    
    func testCanChangeSearchableContent() {
        XCTAssertEqual(viewModel.selectedContent, .characters)
        viewModel.segmentChanged(.comics)
        XCTAssertEqual(viewModel.selectedContent, .comics)
    }
    
    func testCanHandleEmptySearchTerm() {
        let searchTerm = ""
        
        viewModel.loadData(searchTerm: searchTerm) {}
        let character = viewModel.items.first
        XCTAssertNil(character)
        
        viewModel.segmentChanged(.comics)
        viewModel.loadData(searchTerm: searchTerm) {}
        let comic = viewModel.items.first
        XCTAssertNil(comic)
    }
    
    func testCanHandleSearchWithNoResults() {
        viewModel.segmentChanged(.characters)
        
        let searchTerm = "TILT"
        viewModel.loadData(searchTerm: searchTerm) { }
        
        let character = viewModel.items.first
        XCTAssertNil(character, "Empty search should have no items")
    }

    func testCanSearchCharacters() {
        viewModel.segmentChanged(.characters)
        
        let searchTerm = "cha"
        viewModel.loadData(searchTerm: searchTerm) { }
        
        let character = viewModel.items.first
        XCTAssertEqual(character?.name, "Character X")
        XCTAssertEqual(character?.description, "Character Description")
    }
    
    func testCanSearchComics() {
        viewModel.segmentChanged(.comics)
        
        let searchTerm = "com"
        viewModel.loadData(searchTerm: searchTerm) { }
        
        let comic = viewModel.items.first
        XCTAssertEqual(comic?.name, "Comic X")
        XCTAssertEqual(comic?.description, "Comic Description")
    }

}
