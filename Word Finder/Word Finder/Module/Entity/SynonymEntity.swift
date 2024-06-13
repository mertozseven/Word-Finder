//
//  SynonymEntity.swift
//  Word Finder
//
//  Created by Mert Ozseven on 13.06.2024.
//

import Foundation

// MARK: - Synonym
struct SynonymEntity: Decodable {
    let word: String?
    let score: Int?
}
