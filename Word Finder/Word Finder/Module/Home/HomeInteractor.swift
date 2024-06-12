//
//  HomeInteractor.swift
//  Word Finder
//
//  Created by Mert Ozseven on 7.06.2024.
//

import Foundation

fileprivate var dictionaryService: DictionaryServiceProtocol = API()

typealias DictionaryResult = Result<[WordEntity], NetworkError>

protocol HomeInteractorProtocol {
    func fetchRecentSearches()
    func searchWord(_ word: String)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func fetchRecentSearchesOutput(_ searches: [String])
    func searchWordOutput(_ result: DictionaryResult)
}

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
    private var recentSearches: [String] = []
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func fetchRecentSearches() {
        output?.fetchRecentSearchesOutput(recentSearches)
    }
    
    func searchWord(_ word: String) {
        dictionaryService.searchWord(word: word) { [weak self] result in
            guard let self else { return }
            self.output?.searchWordOutput(result)
        }
    }
}

