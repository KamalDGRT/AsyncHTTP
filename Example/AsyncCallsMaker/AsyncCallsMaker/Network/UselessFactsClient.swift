//
//  UselessFactsClient.swift
//  AsyncCallsMaker
//
//  Created by Kamal Sharma on 01/03/25.
//

import Foundation
import AsyncHTTP

final class UselessFactsClient: HTTPClient {
    static var shared: UselessFactsClient {
        let urlSessionConfig = URLSessionConfiguration.ephemeral
        urlSessionConfig.tlsMinimumSupportedProtocolVersion = .TLSv13
        let urlSession = URLSession(configuration: urlSessionConfig)
        return UselessFactsClient(
            baseUrl: "https://uselessfacts.jsph.pl/api/v2/facts",
            defaultHeaders: getDefaultHeaders(),
            session: urlSession
        )
    }
}

// MARK: Helpers
private extension UselessFactsClient {
    class func getDefaultHeaders() -> [HTTPHeader] {
        return [
            .accept("application/json"),
            .acceptEncoding("*"),
            .contentType("application/json")
        ]
    }
}
