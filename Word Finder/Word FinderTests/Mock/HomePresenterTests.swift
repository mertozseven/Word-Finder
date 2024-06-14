//
//  HomePresenterTests.swift
//  Word FinderTests
//
//  Created by Mert Ozseven on 14.06.2024.
//

import XCTest
@testable import Word_Finder

final class HomePresenterTests: XCTestCase {
    
    var presenter: HomePresenter!
    var view: MockHomeViewController!
    var interactor: MockHomeInteractor!
    var router: MockHomeRouter!

    override func setUp() {
        super.setUp()
        
        view = .init()
        interactor = .init()
        router = .init()
        
        presenter = .init(
            view: view,
            router: router,
            interactor: interactor
        )
    }

    override func tearDown() {
        super.tearDown()
        
        view = nil
        interactor = nil
        router = nil
        presenter = nil
    }
    
    func testViewDidLoadInvokesRequiredViewMethods() {
        XCTAssertFalse(view.isInvokedSetupTableView)
        XCTAssertFalse(view.isInvokedSetupTextField)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.isInvokedSetupTableView)
        XCTAssertTrue(view.isInvokedSetupTextField)
    }
    
    func testSearchWord() {
        XCTAssertFalse(interactor.isInvokedSearchWord)
        XCTAssertNil(interactor.invokedSearchWordValue)
        
        presenter.searchWord("test")
        
        XCTAssertTrue(interactor.isInvokedSearchWord)
        XCTAssertEqual(interactor.invokedSearchWordValue, "test")
    }
    
    func testDeleteRecentSearch() {
        XCTAssertFalse(interactor.isInvokedDeleteRecentSearch)
        XCTAssertNil(interactor.invokedDeleteRecentSearchIndex)
        
        presenter.deleteRecentSearch(at: 0)
        
        XCTAssertTrue(interactor.isInvokedDeleteRecentSearch)
        XCTAssertEqual(interactor.invokedDeleteRecentSearchIndex, 0)
    }
    
    func testFetchRecentSearchesOutput() {
        XCTAssertFalse(view.isInvokedReloadData)
        
        presenter.fetchRecentSearchesOutput(["test1", "test2"])
        
        XCTAssertTrue(view.isInvokedReloadData)
        XCTAssertEqual(presenter.numberOfItems(), 2)
        XCTAssertEqual(presenter.recentSearch(at: IndexPath(row: 0, section: 0)), "test1")
    }
    
    func testDidSelectRowAt() {
        XCTAssertFalse(router.isInvokedNavigate)
        XCTAssertNil(router.invokedNavigateRoute)
        
        presenter.fetchRecentSearchesOutput(["test1", "test2"])
        presenter.didSelectRowAt(IndexPath(row: 1, section: 0))
        
        XCTAssertTrue(router.isInvokedNavigate)
        if case .detail(let word) = router.invokedNavigateRoute {
            XCTAssertEqual(word, "test2")
        } else {
            XCTFail("Expected .detail route with the word 'test2'")
        }
    }

}
