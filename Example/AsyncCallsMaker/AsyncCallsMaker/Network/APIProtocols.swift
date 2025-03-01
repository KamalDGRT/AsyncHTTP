//
//  APIProtocols.swift
//  AsyncCallsMaker
//
//  Created by Kamal Sharma on 02/03/25.
//

protocol UselessFactsAPI {
    func getRandomUselessFact() async throws -> UselessFact
    func getUselessFactOfTheDay() async throws -> UselessFact
}

protocol CorporateAPI {
    func getRandomCorporateSaying() async throws -> CorporateSaying
}
