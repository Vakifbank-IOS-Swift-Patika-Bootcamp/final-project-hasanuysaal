//
//  GameDetailViewModelUnitTest.swift
//  GameBookTests
//
//  Created by Hasan Uysal on 17.12.2022.
//

import XCTest
import CoreData

class GameDetailViewModelUnitTest: XCTestCase {

    var viewModel: GameDetailViewModel!
    var fetchExpectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        viewModel = GameDetailViewModel()
        viewModel.delegate = self
        fetchExpectation = expectation(description: "loadGameDetail")
        
    }

    func testGetGameImageCount() throws {
        //Given
        XCTAssertEqual(viewModel.getGameImageCount(), 0)
        
        //When
        viewModel.getGameDetail(id: 3328)
        waitForExpectations(timeout: 10, handler: nil)
        
        //Then
        XCTAssertEqual(viewModel.getGameImageCount(), 2)
    }
    
    func testGetPlatformNames() throws {
        //Given
        XCTAssertEqual(viewModel.getPlatformNames(), nil)
        
        //When
        viewModel.getGameDetail(id: 3328)
        waitForExpectations(timeout: 10, handler: nil)
        
        //Then
        XCTAssertEqual(viewModel.getPlatformNames(), "PC, PlayStation, Xbox, Nintendo")
    }
    
    func testGetGameMetacritic() throws {
        //Given
        XCTAssertEqual(viewModel.getGameMetacritic(), 0)
        
        //When
        viewModel.getGameDetail(id: 3328)
        waitForExpectations(timeout: 10, handler: nil)
        
        //Then
        XCTAssertEqual(viewModel.getGameMetacritic(), 92)
    }
    
    func testGetGamePlaytime() throws {
        //Given
        XCTAssertEqual(viewModel.getGamePlaytime(), 0)
        
        //When
        viewModel.getGameDetail(id: 3328)
        waitForExpectations(timeout: 10, handler: nil)
        
        //Then
        XCTAssertEqual(viewModel.getGamePlaytime(), 46)
    }
    
    func testGetGamePlaytimeas() throws {
        //Given
        XCTAssertEqual(viewModel.getGamePlaytime(), 0)
        
        //When
        viewModel.getGameDetail(id: 3328)
        waitForExpectations(timeout: 10, handler: nil)
        
        //Then
        XCTAssertEqual(viewModel.getGamePlaytime(), 46)
    }
}

extension GameDetailViewModelUnitTest: GameDetailViewModelDelegate {
    func gameLoaded() {
        fetchExpectation.fulfill()
    }
    
    func gameFailed(error: Error) {
        
    }
}


