//
//  NoteCreateUpdateViewModelUnitTest.swift
//  GameBookTests
//
//  Created by Hasan Uysal on 18.12.2022.
//

import XCTest

class NoteCreateUpdateViewModelUnitTest: XCTestCase {

    var viewModel: NoteCreateUpdateViewModel!
    var fetchExpectation : XCTestExpectation!
    var model: SearchedGameModel?
    
    override func setUpWithError() throws {
        viewModel = NoteCreateUpdateViewModel()
        viewModel.noteGameNameDelegate = self
        fetchExpectation = expectation(description: "loadGames")
    }

    func testeGetGameName() throws {
        //Given
        XCTAssertEqual(viewModel.getGameName(name: "Need For"), nil)
        
        //When
        waitForExpectations(timeout: 10, handler: nil)
        
        //Then
        XCTAssertEqual(viewModel.getGameName(name: "Need For")?[0].name, "Need for Speed: Shift")
    }
}

extension NoteCreateUpdateViewModelUnitTest: NoteGameNameDelegate {
    func gameLoaded() {
        fetchExpectation.fulfill()
    }
    
    func gameFailed() {
        //
    }
    
    
}
