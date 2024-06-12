//
//  WordEntity.swift
//  Word Finder
//
//  Created by Mert Ozseven on 7.06.2024.
//

import Foundation

// MARK: - WordEntity
struct WordEntity: Decodable {
    let word: String
    let phonetic: String?
    let phonetics: [Phonetic]?
    let meanings: [Meaning]?
    let sourceUrls: [String]?
}

// MARK: - Meaning
struct Meaning: Decodable {
    let partOfSpeech: String?
    let definitions: [Definition]?
    let synonyms: [String]?
}

// MARK: - Definition
struct Definition: Decodable {
    let definition: String?
    let synonyms: [String]?
    let example: String?
}

// MARK: - Phonetic
struct Phonetic: Decodable {
    let text: String?
    let audio: String?
    let sourceUrl: String?

    enum CodingKeys: String, CodingKey {
        case text, audio
        case sourceUrl = "sourceURL"
    }
}
