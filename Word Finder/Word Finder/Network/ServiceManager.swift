//
//  ServiceManager.swift
//  Word Finder
//
//  Created by Mert Ozseven on 7.06.2024.
//

import Foundation

// MARK: - DictionaryServiceProtocol
protocol DictionaryServiceProtocol {
    func searchWord(word: String, completion: @escaping(Result<[WordEntity], NetworkError>) -> Void)
}

// MARK: - API Extension
extension API: DictionaryServiceProtocol {
    
    func searchWord(word: String, completion: @escaping (Result<[WordEntity], NetworkError>) -> Void) {
        executeRequestFor(router: .search(word: word), completion: completion)
    }
}
