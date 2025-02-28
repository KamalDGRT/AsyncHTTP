//
// HTTPClient.swift
// AsyncHTTP
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
    
    func getDecodedResponse<D: Decodable, E: Encodable>(
        for path: String,
        method: HTTPMethod,
        body: E,
        requestHeaders: [HTTPHeader],
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> D {
        let request = try urlRequest(
            for: path,
            method: method,
            body: body,
            requestHeaders: requestHeaders
        )
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(D.self, from: data)
    }
}

// MARK: Preparing URLRequest
public extension HTTPClient {
    func urlRequest(
        for endPoint: String,
        method: HTTPMethod = .GET,
        queryItems: [URLQueryParam]? = nil,
        requestHeaders: [HTTPHeader] = []
    ) throws -> URLRequest {
        var request = URLRequest(url: try url(for: endPoint, queryItems: queryItems))
        let allHeaders = defaultHeaders.merge(requestHeaders)
        if method != .GET && allHeaders.isFormUrlEncoded {
            request.httpBody = queryItems?.urlEncodedString.data(using: .utf8)
        }
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = allHeaders.dictionary
        return request
    }
    
    func urlRequest<E: Encodable>(
        for endPoint: String,
        method: HTTPMethod = .POST,
        body: E? = nil,
        requestHeaders: [HTTPHeader] = []
    ) throws -> URLRequest {
        var request = URLRequest(url: try url(for: endPoint))
        request.httpMethod = method.rawValue
        request.httpBody = try JSONEncoder().encode(body)
        request.allHTTPHeaderFields = defaultHeaders.merge(requestHeaders).dictionary
        return request
    }
}

// MARK: Form Data
public extension HTTPClient {
    func form<D: Decodable>(
        _ endPoint: String,
        method: HTTPMethod = .POST,
        queryItems: [URLQueryParam] = [],
        requestHeaders: [HTTPHeader] = [
            .contentType("application/x-www-form-urlencoded")
        ],
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> D {
        let request = try urlRequest(
            for: endPoint,
            method: method,
            queryItems: queryItems,
            requestHeaders: requestHeaders
        )
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(D.self, from: data)
    }
    
    func form(
        _ endPoint: String,
        method: HTTPMethod = .POST,
        queryItems: [URLQueryParam] = [],
        requestHeaders: [HTTPHeader] = [
            .contentType("application/x-www-form-urlencoded")
        ]
    ) async throws -> (Data, URLResponse) {
        let request = try urlRequest(
            for: endPoint,
            method: method,
            queryItems: queryItems,
            requestHeaders: requestHeaders
        )
        return try await session.data(for: request)
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
        queryItems: [URLQueryParam] = [],
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
        body: E,
        requestHeaders: [HTTPHeader] = [],
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> D {
        return try await getDecodedResponse(
            for: endPoint,
            method: .POST,
            body: body,
            requestHeaders: requestHeaders,
            decoder: decoder
        )
    }
    
    func post<E: Encodable>(
        _ endPoint: String,
        body: E,
        requestHeaders: [HTTPHeader] = []
    ) async throws -> (Data, URLResponse) {
        let request = try urlRequest(
            for: endPoint,
            method: .POST,
            body: body,
            requestHeaders: requestHeaders
        )
        return try await session.data(for: request)
    }
}

// MARK: DELETE
public extension HTTPClient {
    func delete<D: Decodable, E: Encodable>(
        _ path: String,
        body: E,
        headers: [HTTPHeader] = [],
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> D {
        return try await getDecodedResponse(
            for: path,
            method: .DELETE,
            body: body,
            requestHeaders: headers,
            decoder: decoder
        )
    }
    
    func delete<E: Encodable>(
        _ endPoint: String,
        body: E,
        requestHeaders: [HTTPHeader] = []
    ) async throws -> (Data, URLResponse) {
        let request = try urlRequest(
            for: endPoint,
            method: .DELETE,
            body: body,
            requestHeaders: requestHeaders
        )
        return try await session.data(for: request)
    }
}

// MARK: PUT
public extension HTTPClient {
    func put<D: Decodable, E: Encodable>(
        _ path: String,
        body: E,
        headers: [HTTPHeader] = [],
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> D {
        return try await getDecodedResponse(
            for: path,
            method: .PUT,
            body: body,
            requestHeaders: headers,
            decoder: decoder
        )
    }
    
    func put<E: Encodable>(
        _ endPoint: String,
        body: E,
        requestHeaders: [HTTPHeader] = []
    ) async throws -> (Data, URLResponse) {
        let request = try urlRequest(
            for: endPoint,
            method: .PUT,
            body: body,
            requestHeaders: requestHeaders
        )
        return try await session.data(for: request)
    }
}

// MARK: UPDATE
public extension HTTPClient {
    func update<D: Decodable, E: Encodable>(
        _ path: String,
        body: E,
        headers: [HTTPHeader] = [],
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> D {
        return try await getDecodedResponse(
            for: path,
            method: .UPDATE,
            body: body,
            requestHeaders: headers,
            decoder: decoder
        )
    }
    
    func update<E: Encodable>(
        _ endPoint: String,
        body: E,
        requestHeaders: [HTTPHeader] = []
    ) async throws -> (Data, URLResponse) {
        let request = try urlRequest(
            for: endPoint,
            method: .UPDATE,
            body: body,
            requestHeaders: requestHeaders
        )
        return try await session.data(for: request)
    }
}

// MARK: PATCH
public extension HTTPClient {
    func patch<D: Decodable, E: Encodable>(
        _ path: String,
        body: E,
        headers: [HTTPHeader] = [],
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> D {
        return try await getDecodedResponse(
            for: path,
            method: .PATCH,
            body: body,
            requestHeaders: headers,
            decoder: decoder
        )
    }
    
    func patch<E: Encodable>(
        _ endPoint: String,
        body: E,
        requestHeaders: [HTTPHeader] = []
    ) async throws -> (Data, URLResponse) {
        let request = try urlRequest(
            for: endPoint,
            method: .PATCH,
            body: body,
            requestHeaders: requestHeaders
        )
        return try await session.data(for: request)
    }
}
