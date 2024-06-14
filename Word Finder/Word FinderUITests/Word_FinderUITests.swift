//
//  Word_FinderUITests.swift
//  Word FinderUITests
//
//  Created by Mert Ozseven on 7.06.2024.
//

import XCTest

final class Word_FinderUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    // Test 1: Verify Splash Screen elements
    func test_splashScreenElements() {
        let welcomeLabel = app.staticTexts["Welcome to \nWord Finder"]
        XCTAssertTrue(welcomeLabel.exists)
        
        let textIcon = app.images["text.word.spacing"]
        XCTAssertTrue(textIcon.exists)
        
        let textTitleDescription = app.staticTexts["Your Pocket Dictionary"]
        XCTAssertTrue(textTitleDescription.exists)
        
        let continueButton = app.buttons["Continue"]
        XCTAssertTrue(continueButton.exists)
    }

    // Test 2: Tap Continue Button on Splash Screen
    func test_tapContinueButton() {
        let continueButton = app.buttons["Continue"]
        XCTAssertTrue(continueButton.exists)
        continueButton.tap()
        
        // Verify that we navigated to the Home screen
        let searchTextField = app.textFields["Enter a word here"]
        XCTAssertTrue(searchTextField.exists)
    }

    // Test 3: Verify Home Screen elements
    func test_homeScreenElements() {
        let continueButton = app.buttons["Continue"]
        continueButton.tap()
        
        let searchTextField = app.textFields["Enter a word here"]
        XCTAssertTrue(searchTextField.exists)
        
        let searchButton = app.buttons["Search"]
        XCTAssertTrue(searchButton.exists)
        
        let emptyStateLabel = app.staticTexts["The recent searches will appear here"]
        XCTAssertTrue(emptyStateLabel.exists)
    }

    // Test 4: Perform a search on Home Screen
    func test_searchWord() {
        let continueButton = app.buttons["Continue"]
        continueButton.tap()
        
        let searchTextField = app.textFields["Enter a word here"]
        XCTAssertTrue(searchTextField.exists)
        searchTextField.tap()
        searchTextField.typeText("Example\n")
        
        // Return to Home screen
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        backButton.tap()
        
        // Verify that search action was performed and Detail screen should appear
        let wordLabel = app.staticTexts["Example"]
        XCTAssertTrue(wordLabel.exists)
    }

    // Test 5: Verify Recent Searches appear after performing a search
    func test_recentSearchesAppear() {
        let continueButton = app.buttons["Continue"]
        continueButton.tap()
        
        let searchTextField = app.textFields["Enter a word here"]
        searchTextField.tap()
        searchTextField.typeText("example\n")
        
        // Return to Home screen
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        backButton.tap()
        
        // Verify that the recent search appears in the table view
        let recentTableView = app.tables.element(boundBy: 0)
        XCTAssertTrue(recentTableView.exists)
        
        let recentSearchCell = recentTableView.cells.staticTexts["example"]
        XCTAssertTrue(recentSearchCell.exists)
    }
}

