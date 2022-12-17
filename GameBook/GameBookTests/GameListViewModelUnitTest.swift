//
//  GameListViewModelUnitTest.swift
//  GameBookTests
//
//  Created by Hasan Uysal on 17.12.2022.
//

import XCTest

class GameListViewModelUnitTest: XCTestCase {

    var viewModel: GameListViewModel!
    var fetchExpectation : XCTestExpectation!
    var model: GameModel?
    var genresModel: [GameGenresModel]!
    
    override func setUpWithError() throws {
        viewModel = GameListViewModel()
        viewModel.delegate = self
        fetchExpectation = expectation(description: "loadGames")
        genresModel = [GameGenresModel(name: "Action"), GameGenresModel(name: "Adventure"), GameGenresModel(name: "RPG")]
        model = GameModel(id: 3328, name: "The Witcher 3: Wild Hunt", released: "2015-05-18", image: "https://media.rawg.io/media/games/618/618c2031a07bbff6b4f611f10b6bcdbc.jpg", rating: 4.67, genres: genresModel)
    }

    func testGetGame() throws {
        //Given
        XCTAssertEqual(viewModel.getGame(at: 1), nil)
        
        //When
        viewModel.fetchGames(pageNum: 1)
        waitForExpectations(timeout: 10, handler: nil)
        
        //Then
        XCTAssertEqual(viewModel.getGame(at: 1), model)
    }
    
    func testGetGameId() throws {
        //Given
        XCTAssertEqual(viewModel.getGameId(at: 1), nil)
        
        //When
        viewModel.fetchGames(pageNum: 1)
        waitForExpectations(timeout: 10, handler: nil)
        
        //Then
        XCTAssertEqual(viewModel.getGameId(at: 1), 3328)
    }
    
    func testGetGamesCount() throws {
        //Given
        XCTAssertEqual(viewModel.getGamesCount(), 0)
        
        //When
        viewModel.fetchGames(pageNum: 1)
        waitForExpectations(timeout: 10, handler: nil)
        
        //Then
        XCTAssertEqual(viewModel.getGamesCount(), 20)
    }
    
}

extension GameListViewModelUnitTest: GameListViewModelDelegate {
    func gamesLoaded() {
        fetchExpectation.fulfill()
    }
    
    func gamesFailed(error: Error) {
        
    }
    
    
}
