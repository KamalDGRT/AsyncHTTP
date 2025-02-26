//
// HTTPClient.swift
// swift-async-http
//

import Foundation

open class HTTPClient {
    private var scheme: String
    private var host: String
    private var port: Int?
    private var path: String
    
    let session: URLSession
    let defaultHeaders: [HTTPHeader]
    
    public init(
        baseUrl: String,
        defaultHeaders: [HTTPHeader] = [],
        session: URLSession = .shared
    ) {
        let components = URLComponents(string: baseUrl)
        self.scheme = components?.scheme ?? "https"
        self.host = components?.host  ?? ""
        self.port = components?.port
        self.path = components?.path ?? ""
        self.defaultHeaders = defaultHeaders
        self.session = session
    }
    
    public init(
        scheme: String,
        host: String,
        port: Int?,
        path: String?,
        defaultHeaders: [HTTPHeader] = [],
        session: URLSession = .shared
    ) {
        self.scheme = scheme
        self.host = host
        self.port = port
        self.path = path ?? ""
        self.defaultHeaders = defaultHeaders
        self.session = session
    }
    
    public func setBaseUrl(_ url: String) {
        let components = URLComponents(string: url)
        self.scheme = components?.scheme ?? "https"
        self.host = components?.host  ?? ""
        self.port = components?.port
        self.path = components?.path ?? ""
    }
}

private extension HTTPClient {
    func url(
        for endPoint: String,
        queryItems: [URLQueryParam]? = nil
    ) throws -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = self.path.appending(endPoint)
        components.queryItems = queryItems?.compactMap({ $0.queryItem })
        
        guard let url = components.url
        else { throw HTTPError.malformedUrl }
        
        return url
    }
    
    func decodeResponse<D: Decodable, E: Encodable>(
        for path: String,
        method: HTTPMethod,
        queryItems: [URLQueryParam] = [],
        body: E? = nil,
        requestHeaders: [HTTPHeader],
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> D {
        let request = try urlRequest(
            for: path,
            method: method,
            queryItems: queryItems,
            body: body,
            requestHeaders: requestHeaders
        )
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(D.self, from: data)
    }
}


// MARK: Preparing URLRequest
public extension HTTPClient {
    /// Used only in GET calls.
    func urlRequest(
        for endPoint: String,
        queryItems: [URLQueryParam]? = nil,
        requestHeaders: [HTTPHeader] = []
    ) throws -> URLRequest {
        let allHeaders = defaultHeaders.merge(requestHeaders)
        var request = URLRequest(
            url: try url(for: endPoint, queryItems: queryItems),
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 60
        )
        request.allHTTPHeaderFields = allHeaders.dictionary
        return request
    }
    
    func urlRequest<E: Encodable>(
        for endPoint: String,
        method: HTTPMethod = .POST,
        queryItems: [URLQueryParam]? = nil,
        body: E? = nil,
        requestHeaders: [HTTPHeader] = []
    ) throws -> URLRequest {
        let allHeaders = defaultHeaders.merge(requestHeaders)
        
        var request = URLRequest(
            url: try url(for: endPoint, queryItems: queryItems),
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 60
        )
        request.httpMethod = method.rawValue
        
        if allHeaders.isFormUrlEncoded {
            request.httpBody = queryItems?.urlEncodedString.data(using: .utf8)
        } else {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        request.allHTTPHeaderFields = allHeaders.dictionary
        return request
    }
}

// MARK: GET
public extension HTTPClient {
    func get<D: Decodable>(
        _ endPoint: String,
        queryItems: [URLQueryParam] = [],
        requestHeaders: [HTTPHeader] = [],
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> D {
        let request = try urlRequest(
            for: endPoint,
            queryItems: queryItems,
            requestHeaders: requestHeaders
        )
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(D.self, from: data)
    }
    
    func get(
        _ endPoint: String,
        queryItems: [URLQueryParam]? = nil,
        requestHeaders: [HTTPHeader] = []
    ) async throws -> (Data, URLResponse) {
        let request = try urlRequest(
            for: endPoint,
            queryItems: queryItems,
            requestHeaders: requestHeaders
        )
        return try await session.data(for: request)
    }
}

// MARK: POST
public extension HTTPClient {
    func post<D: Decodable, E: Encodable>(
        _ endPoint: String,
        body: E?,
        queryItems: [URLQueryParam] = [],
        requestHeaders: [HTTPHeader] = [],
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> D {
        return try await decodeResponse(
            for: endPoint,
            method: .POST,
            queryItems: queryItems,
            body: body,
            requestHeaders: requestHeaders,
            decoder: decoder
        )
    }
    
    func post<E: Encodable>(
        _ endPoint: String,
        queryItems: [URLQueryParam] = [],
        body: E?,
        requestHeaders: [HTTPHeader] = []
    ) async throws -> (Data, URLResponse) {
        let request = try urlRequest(
            for: endPoint,
            method: .POST,
            queryItems: queryItems,
            body: body,
            requestHeaders: requestHeaders
        )
        return try await session.data(for: request)
    }
}

// MARK: DELETE
public extension HTTPClient {
    func delete<D: Decodable, E: Encodable>(
        _ endPoint: String,
        queryItems: [URLQueryParam] = [],
        body: E?,
        requestHeaders: [HTTPHeader] = [],
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> D {
        return try await decodeResponse(
            for: endPoint,
            method: .DELETE,
            queryItems: queryItems,
            body: body,
            requestHeaders: requestHeaders,
            decoder: decoder
        )
    }
    
    func delete<E: Encodable>(
        _ endPoint: String,
        body: E?,
        queryItems: [URLQueryParam] = [],
        requestHeaders: [HTTPHeader] = []
    ) async throws -> (Data, URLResponse) {
        let request = try urlRequest(
            for: endPoint,
            method: .DELETE,
            queryItems: queryItems,
            body: body,
            requestHeaders: requestHeaders
        )
        return try await session.data(for: request)
    }
}
