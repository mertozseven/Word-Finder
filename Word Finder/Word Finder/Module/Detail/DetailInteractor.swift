//
//  DetailInteractor.swift
//  Word Finder
//
//  Created by Mert Ozseven on 12.06.2024.
//

import Foundation

protocol DetailInteractorProtocol {
    func getWordDetail() -> WordEntity?
}

final class DetailInteractor {
    private let word: WordEntity?
    
    init(word: WordEntity?) {
        self.word = word
    }
}

extension DetailInteractor: DetailInteractorProtocol {
    func getWordDetail() -> WordEntity? {
        return word
    }
}
