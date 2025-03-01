//
//  UselessFact.swift
//  AsyncCallsMaker
//
//  Created by Kamal Sharma on 02/03/25.
//

struct UselessFact: Codable {
    let id, text, source: String
    let sourceURL: String
    let language: String
    let permalink: String

    enum CodingKeys: String, CodingKey {
        case id, text, source
        case sourceURL = "source_url"
        case language, permalink
    }
}
