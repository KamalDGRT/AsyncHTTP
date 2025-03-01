//
//  CorporateClient.swift
//  AsyncCallsMaker
//
//  Created by Kamal Sharma on 01/03/25.
//

import Foundation
import AsyncHTTP

final class CorporateClient: HTTPClient {
    static var shared: CorporateClient {
        let urlSessionConfig = URLSessionConfiguration.ephemeral
        urlSessionConfig.tlsMinimumSupportedProtocolVersion = .TLSv13
        let urlSession = URLSession(configuration: urlSessionConfig)
        return CorporateClient(
            baseUrl: "https://corporatebs-generator.sameerkumar.website",
            defaultHeaders: defaultHeaders,
            session: urlSession
        )
    }
    
    private static var defaultHeaders: [HTTPHeader] {
        return [
            .accept("application/json"),
            .acceptEncoding("*"),
            .contentType("application/json")
        ]
    }
    
    private let jsonDecoder = JSONDecoder()
}

// MARK: GET
extension CorporateClient {
    func get<D: Decodable>(
        _ endPoint: String,
        queryItems: [URLQueryParam] = []
    ) async throws -> D {
        let (data, _) = try await get(endPoint, queryItems: queryItems)
        return try decodeData(data)
    }
    
    func get(
        _ endPoint: String,
        queryItems: [URLQueryParam] = []
    ) async throws -> (Data, URLResponse) {
        let headers = CorporateClient.defaultHeaders.merge(cookieHeaders)
        let (data, response) = try await super.get(
            endPoint,
            queryItems: queryItems,
            requestHeaders: headers
        )
        saveCookiesFromResponse(response)
        return (data, response)
    }
}

// MARK: Cookies
/// If your API is sending/setting cookies, you can handle it with this piece of code and you can set it to subsequent requests
///  like in the above implementation in line number 55.
private extension CorporateClient {
    func saveCookiesFromResponse(_ response: URLResponse) {
        guard let url = response.url,
              let httpURLResponse = response as? HTTPURLResponse,
              let headerFields = httpURLResponse.allHeaderFields as? [String: String]
        else { return }
        
        let cookiesFromResponse = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url)
        CookieManager.shared.saveCookies(cookiesFromResponse, for: domain)
    }
    
    var cookieHeaders: [HTTPHeader] {
        CookieManager.shared.getCookieHeaders(for: domain)
    }
}
