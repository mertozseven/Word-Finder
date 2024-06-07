//
//  DictionaryResponse.swift
//  Word Finder
//
//  Created by Mert Ozseven on 7.06.2024.
//

import Foundation

// MARK: - DictionaryResponse
struct DictionaryResponse: Decodable {
    let word: String?
    let phonetic: String?
    let phonetics: [Phonetic]?
    let meanings: [Meaning]?
    let sourceUrls: [String]?

    enum CodingKeys: String, CodingKey {
        case word, phonetic, phonetics, meanings
        case sourceUrls = "sourceUrls"
    }
}

// MARK: - Meaning
struct Meaning: Decodable {
    let partOfSpeech: String?
    let definitions: [Definition]?
    let synonyms: [String]?
    let antonyms: [String]?

    enum CodingKeys: String, CodingKey {
        case partOfSpeech, definitions, synonyms, antonyms
    }
}

// MARK: - Definition
struct Definition: Decodable {
    let definition: String?
    let synonyms: [String]?
    let antonyms: [String]?
    let example: String?

    enum CodingKeys: String, CodingKey {
        case definition, synonyms, antonyms, example
    }
}

// MARK: - Phonetic
struct Phonetic: Decodable {
    let text: String?
    let audio: String?
    let sourceUrl: String?

    enum CodingKeys: String, CodingKey {
        case text, audio
        case sourceUrl = "sourceUrl"
    }
}
