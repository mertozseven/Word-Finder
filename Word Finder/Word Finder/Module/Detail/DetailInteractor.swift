//
//  DetailInteractor.swift
//  Word Finder
//
//  Created by Mert Ozseven on 12.06.2024.
//

import Foundation

fileprivate var dictionaryService: DictionaryServiceProtocol = API()

typealias DictionaryResult = Result<[WordEntity], NetworkError>
typealias SynonymResult = Result<[SynonymEntity], NetworkError>

// MARK: - DetailInteractorProtocol
protocol DetailInteractorProtocol {
    func fetchWordDetail()
    func fetchSynonyms(for word: String)
}

// MARK: - DetailInteractorOutputProtocol
protocol DetailInteractorOutputProtocol: AnyObject {
    func fetchWordDetailOutput(_ result: DictionaryResult)
    func fetchSynonymsOutput(_ result: SynonymResult)
}

// MARK: - DetailInteractor
final class DetailInteractor {
    weak var output: DetailInteractorOutputProtocol?
    private let word: String
    private var dictionaryService: DictionaryServiceProtocol = API()
    
    init(word: String) {
        self.word = word
    }
}

// MARK: - DetailInteractorProtocol Methods
extension DetailInteractor: DetailInteractorProtocol {
    func fetchWordDetail() {
        dictionaryService.searchWord(word: word) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchWordDetailOutput(result)
            if case .success(_) = result {
                self.fetchSynonyms(for: self.word)
            }
        }
    }
    
    func fetchSynonyms(for word: String) {
        dictionaryService.fetchSynonyms(word: word) { [weak self] result in
            self?.output?.fetchSynonymsOutput(result)
        }
    }
}
