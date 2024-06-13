//
//  HomeInteractor.swift
//  Word Finder
//
//  Created by Mert Ozseven on 7.06.2024.
//

import Foundation

protocol HomeInteractorProtocol {
    func fetchRecentSearches()
    func searchWord(_ word: String)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func fetchRecentSearchesOutput(_ searches: [String])
    func searchWordOutput(_ word: String)
}

final class HomeInteractor {
    weak var output: HomeInteractorOutputProtocol?
    private var recentSearches: [String] = []
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func fetchRecentSearches() {
        output?.fetchRecentSearchesOutput(recentSearches)
    }
    
    func searchWord(_ word: String) {
        recentSearches.append(word)
        output?.fetchRecentSearchesOutput(recentSearches)
        output?.searchWordOutput(word)
    }
}
