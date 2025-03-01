//
//  NetworkLibrary.swift
//  AsyncCallsMaker
//
//  Created by Kamal Sharma on 01/03/25.
//

final class NetworkLibrary {
    let corporateClient = CorporateClient.shared
    let uselessFactsClient = UselessFactsClient.shared
}

extension NetworkLibrary: CorporateAPI {
    func getRandomCorporateSaying() async throws -> CorporateSaying {
        try await corporateClient.get("")
    }
}

extension NetworkLibrary: UselessFactsAPI {
    func getRandomUselessFact() async throws -> UselessFact {
        try await uselessFactsClient.get("/random")
    }
    
    func getUselessFactOfTheDay() async throws -> UselessFact {
        try await uselessFactsClient.get("/today")
    }
}
