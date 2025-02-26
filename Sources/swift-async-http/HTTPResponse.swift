//
// HTTPResponse.swift
// swift-async-http
//

import Foundation

public struct HTTPResponse<T: Codable> {
    /// The decoded response body of type `T`.
    public let data: T
    
    /// The HTTP status code returned by the server.
    public let statusCode: HTTPStatusCode
}
