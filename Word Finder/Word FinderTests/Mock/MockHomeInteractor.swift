//
//  MockHomeInteractor.swift
//  Word FinderTests
//
//  Created by Mert Ozseven on 14.06.2024.
//

import Foundation
@testable import Word_Finder

final class MockHomeInteractor: HomeInteractorProtocol {
    
    var isInvokedFetchRecentSearches = false
    var invokedFetchRecentSearchesCount = 0
    
    func fetchRecentSearches() {
        isInvokedFetchRecentSearches = true
        invokedFetchRecentSearchesCount += 1
    }
    
    var isInvokedSearchWord = false
    var invokedSearchWordCount = 0
    var invokedSearchWordValue: String?
    
    func searchWord(_ word: String) {
        isInvokedSearchWord = true
        invokedSearchWordCount += 1
        invokedSearchWordValue = word
    }
    
    var isInvokedDeleteRecentSearch = false
    var invokedDeleteRecentSearchCount = 0
    var invokedDeleteRecentSearchIndex: Int?
    
    func deleteRecentSearch(at index: Int) {
        isInvokedDeleteRecentSearch = true
        invokedDeleteRecentSearchCount += 1
        invokedDeleteRecentSearchIndex = index
    }
}
