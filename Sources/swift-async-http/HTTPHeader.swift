//
// HTTPHeader.swift
// swift-async-http
//

import Foundation

/// A structure representing an HTTP header.
public struct HTTPHeader: CustomStringConvertible {
    let name: String
    let value: String
    
    /// A textual representation of the HTTP header.
    public var description: String {
        "\(name): \(value)"
    }
}

public extension HTTPHeader {
    
    /// Creates an `Accept` header.
    ///
    /// - Parameter value: The MIME type that the client can accept.
    /// - Returns: An `HTTPHeader` with the name `Accept`.
    static func accept(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Accept", value: value)
    }
    
    /// Creates an `Accept-Encoding` header.
    ///
    /// - Parameter value: The encoding type(s) the client supports, such as `gzip` or `deflate`.
    /// - Returns: An `HTTPHeader` with the name `Accept-Encoding`.
    static func acceptEncoding(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Accept-Encoding", value: value)
    }
    
    /// Creates an `Authorization` header.
    ///
    /// - Parameter value: The authorization token or credentials.
    /// - Returns: An `HTTPHeader` with the name `Authorization`.
    static func authorization(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Authorization", value: value)
    }
    
    /// Creates a `Bearer` token `Authorization` header.
    ///
    /// - Parameter bearerToken: The bearer token string.
    /// - Returns: An `HTTPHeader` with a `Bearer` authorization token.
    static func authorization(bearerToken: String) -> HTTPHeader {
        authorization("Bearer \(bearerToken)")
    }
    
    /// Creates a `Basic` authorization header using a username and password.
    ///
    /// - Parameters:
    ///   - username: The username for authentication.
    ///   - password: The password for authentication.
    /// - Returns: An `HTTPHeader` with a `Basic` authorization credential.
    static func basicAuthorization(username: String, password: String) -> HTTPHeader {
        let credential = Data("\(username):\(password)".utf8).base64EncodedString()
        return authorization("Basic \(credential)")
    }
    
    /// Creates a `Content-Disposition` header.
    ///
    /// - Parameter value: The content disposition directive, such as `attachment; filename="file.txt"`.
    /// - Returns: An `HTTPHeader` with the name `Content-Disposition`.
    static func contentDisposition(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Content-Disposition", value: value)
    }
    
    /// Creates a `Content-Type` header.
    ///
    /// - Parameter value: The media type of the resource, such as `application/json`.
    /// - Returns: An `HTTPHeader` with the name `Content-Type`.
    static func contentType(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Content-Type", value: value)
    }
    
    /// Creates a `Content-Length` header.
    ///
    /// - Parameter value: The length of the request body in bytes.
    /// - Returns: An `HTTPHeader` with the name `Content-Length`.
    static func contentLength(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Content-Length", value: value)
    }
    
    /// Creates a `User-Agent` header.
    ///
    /// - Parameter value: The user agent string representing the client application.
    /// - Returns: An `HTTPHeader` with the name `User-Agent`.
    static func userAgent(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "User-Agent", value: value)
    }
    
    /// Creates a custom HTTP header.
    ///
    /// - Parameters:
    ///   - name: The name of the custom header.
    ///   - value: The value of the custom header.
    /// - Returns: An `HTTPHeader` with the given name and value.
    static func custom(name: String, value: String) -> HTTPHeader {
        HTTPHeader(name: name, value: value)
    }
}
