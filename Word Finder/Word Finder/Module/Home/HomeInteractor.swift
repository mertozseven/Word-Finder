//
//  HomeInteractor.swift
//  Word Finder
//
//  Created by Mert Ozseven on 7.06.2024.
//

import Foundation

// MARK: - HomeInteractorProtocol
protocol HomeInteractorProtocol {
    func fetchRecentSearches()
    func searchWord(_ word: String)
    func deleteRecentSearch(at index: Int)
}

// MARK: - HomeInteractorOutputProtocol
protocol HomeInteractorOutputProtocol: AnyObject {
    func fetchRecentSearchesOutput(_ searches: [String])
    func searchWordOutput(_ word: String)
}

// MARK: - HomeInteractor
final class HomeInteractor {
    weak var output: HomeInteractorOutputProtocol?
    private var recentSearches: [String] {
        get {
            UserDefaults.standard.stringArray(forKey: "recentSearches") ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "recentSearches")
        }
    }
}

// MARK: - HomeInteractorProtocol Methods
extension HomeInteractor: HomeInteractorProtocol {
    
    func fetchRecentSearches() {
        output?.fetchRecentSearchesOutput(recentSearches)
    }
    
    func searchWord(_ word: String) {
        if recentSearches.contains(word) {
            recentSearches.removeAll { $0 == word }
        }
        
        recentSearches.insert(word, at: 0)
        
        if recentSearches.count > 5 {
            recentSearches.removeLast()
        }
        
        output?.fetchRecentSearchesOutput(recentSearches)
        output?.searchWordOutput(word)
    }
    
    func deleteRecentSearch(at index: Int) {
        recentSearches.remove(at: index)
        output?.fetchRecentSearchesOutput(recentSearches)
    }
}
