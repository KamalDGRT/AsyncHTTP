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
    /// Creates a custom HTTP header.
    ///
    /// - Parameters:
    ///   - name: The name of the custom header.
    ///   - value: The value of the custom header.
    /// - Returns: An `HTTPHeader` with the given name and value.
    static func custom(_ name: String, _ value: String) -> HTTPHeader {
        HTTPHeader(name: name, value: value)
    }
}

// MARK: Request Headers (Specific to Requests)
public extension HTTPHeader {
    
    /// Creates an `Accept` header.
    ///
    /// - Parameter value: The MIME type that the client can accept.
    /// - Returns: An `HTTPHeader` with the name `Accept`.
    static func accept(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Accept", value: value)
    }
    
    /// Specifies the character sets acceptable by the client.
    static func acceptCharset(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Accept-Charset", value: value)
    }
    
    /// Creates an `Accept-Encoding` header.
    ///
    /// - Parameter value: The encoding type(s) the client supports, such as `gzip` or `deflate`.
    /// - Returns: An `HTTPHeader` with the name `Accept-Encoding`.
    static func acceptEncoding(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Accept-Encoding", value: value)
    }
    
    /// Specifies preferred languages (e.g., en-US, fr).
    static func acceptLanguage(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Accept-Language", value: value)
    }
    
    /// Indicates expected server behavior (e.g., `100-continue`).
    static func expect(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Expect", value: value)
    }
    
    /// Specifies the target host and port (e.g., `example.com`).
    static func host(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Host", value: value)
    }
    
    /// Makes request conditional (checks ETag match)
    static func ifMatch(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "If-Match", value: value)
    }
    
    /// Requests a resource only if it has been modified since the given date.
    static func ifModifiedSince(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "If-Modified-Since", value: value)
    }
    
    /// Requests a resource only if its ETag does not match the provided value.
    static func ifNoneMatch(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "If-None-Match", value: value)
    }
    
    /// Requests only parts of a resource if it is still valid.
    static func ifRange(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "If-Range", value: value)
    }
    
    /// Requests resource only if NOT modified since the given date.
    static func ifUnmodifiedSince(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "If-Unmodified-Since", value: value)
    }
    
    /// Specifies a limit on the number of forwards for a TRACE request.
    static func maxForwards(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Max-Forwards", value: value)
    }
    
    /// Indicates the previous page URL.
    static func referer(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Referer", value: value)
    }
    
    /// Specifies transfer encodings the client supports.
    static func TE(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "TE", value: value)
    }
    
    /// Creates a `User-Agent` header.
    ///
    /// - Parameter value: The user agent string representing the client application.
    /// - Returns: An `HTTPHeader` with the name `User-Agent`.
    static func userAgent(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "User-Agent", value: value)
    }
}

// MARK: Payload (Entity) Headers (For Request Bodies)
public extension HTTPHeader {
    
    /// Creates a `Content-Length` header.
    ///
    /// - Parameter value: The length of the request body in bytes.
    /// - Returns: An `HTTPHeader` with the name `Content-Length`.
    static func contentLength(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Content-Length", value: value)
    }
    
    /// Creates a `Content-Type` header.
    ///
    /// - Parameter value: The media type of the resource, such as `application/json`.
    /// - Returns: An `HTTPHeader` with the name `Content-Type`.
    static func contentType(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Content-Type", value: value)
    }
    
    /// Creates a `Content-Disposition` header.
    ///
    /// - Parameter value: The content disposition directive, such as `attachment; filename="file.txt"`.
    /// - Returns: An `HTTPHeader` with the name `Content-Disposition`.
    static func contentDisposition(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Content-Disposition", value: value)
    }
    
    /// Specifies encoding of the request body (e.g., gzip, br).
    static func contentEncoding(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Content-Encoding", value: value)
    }
    
    /// Specifies the language of the request body content.
    static func contentLanguage(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Content-Language", value: value)
    }
    
    /// Specifies an alternate URI for the resource.
    static func contentLocation(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Content-Location", value: value)
    }
}

// MARK: General Headers (Applicable to both request & response)
public extension HTTPHeader {
    /// Specifies control directives for caching mechanisms.
    static func cacheControl(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Cache-Control", value: value)
    }
    
    /// Specifies connection behavior (`keep-alive`, `close`).
    static func connection(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Connection", value: value)
    }
    
    /// Specifies the date and time when the request was sent.
    static func date(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Date", value: value)
    }
    
    /// A deprecated header similar to `Cache-Control`.
    static func pragma(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Pragma", value: value)
    }
    
    /// Lists headers that will be sent after the message body.
    static func trailer(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Trailer", value: value)
    }
    
    /// Specifies encoding used to transfer the response.
    static func transferEncoding(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Transfer-Encoding", value: value)
    }
    
    /// Requests an upgrade to another protocol (e.g., `h2`).
    static func upgrade(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Upgrade", value: value)
    }
    
    /// Indicates intermediate proxies used in the request.
    static func via(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Via", value: value)
    }
    /// Provides additional information about the request status.
    static func warning(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Warning", value: value)
    }
}

// MARK: CORS Headers (For Cross-Origin Requests)
public extension HTTPHeader {
    /// Indicates the origin of the request (e.g., `https://example.com`).
    static func origin(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Origin", value: value)
    }
    
    /// Indicates the HTTP method in a preflight request.
    static func accessControlRequestMethod(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Access-Control-Request-Method", value: value)
    }
    
    /// Lists headers that will be used in the request.
    static func accessControlRequestHeaders(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Access-Control-Request-Headers", value: value)
    }
}

// MARK: Security & Authentication Headers
public extension HTTPHeader {
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
    
    /// Sends credentials to a proxy.
    static func proxyAuthorization(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Proxy-Authorization", value: value)
    }
    
    /// Sends cookies with the request.
    static func cookie(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Cookie", value: value)
    }
    
    /// Sets a cookie on the client.
    static func setCookie(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "Set-Cookie", value: value)
    }
}

// MARK: Custom Headers (Prefix x-)
public extension HTTPHeader {
    /// Common in AJAX requests `(XMLHttpRequest)`
    static func xRequestedWith(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "X-Requested-With", value: value)
    }
    
    /// Identifies the original IP behind a proxy.
    static func xForwardedFor(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "X-Forwarded-For", value: value)
    }
    
    /// Indicates protocol used (`http` or `https`)
    static func xForwardedProto(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "X-Forwarded-Proto", value: value)
    }
    
    /// Controls if the page can be embedded in `<iframe>`.
    static func xFrameOptions(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "X-Frame-Options", value: value)
    }
    
    /// Prevents MIME-type sniffing (`nosniff`).
    static func xContentTypeOptions(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "X-Content-Type-Options", value: value)
    }
    
    /// Enables Cross-Site Scripting (XSS) protection.
    static func xXSSProtection(_ value: String) -> HTTPHeader {
        HTTPHeader(name: "X-XSS-Protection", value: value)
    }
}

public extension Array where Element == HTTPHeader {
    /// Checks if the request is `application/x-www-form-urlencoded` by looking at the `Content-Type` header.
    ///
    /// - Returns: `true` if `Content-Type` is `application/x-www-form-urlencoded`, otherwise `false`.
    ///
    /// Example:
    /// ```swift
    /// let headers: [HTTPHeader] = [
    ///     .contentType("application/x-www-form-urlencoded"),
    ///     .authorization(bearerToken: "abc123")
    /// ]
    /// print(headers.isFormUrlEncoded) // Output: true
    /// ```
    var isFormUrlEncoded: Bool {
        self.contains {
            $0.name.lowercased() == "content-type" &&
            $0.value.lowercased() == "application/x-www-form-urlencoded"
        }
    }
    
    /// Returns a dictionary for an array of `HTTPHeader` objects.
    var dictionary: [String: String] {
        reduce(into: [String: String]()) { result, header in
            result[header.name] = header.value
        }
    }
    
    /// Merges `defaultHeaders` with `requestHeaders`, ensuring that requestHeaders override default ones.
    ///
    /// - Parameter requestHeaders: The headers for a specific API request.
    /// - Returns: A merged list of `HTTPHeader`, ensuring uniqueness.
    ///
    /// Example:
    /// ```swift
    /// let defaultHeaders = [HTTPHeader.contentType("application/json")]
    /// let requestHeaders = [HTTPHeader.contentType("text/plain")]
    ///
    /// let mergedHeaders = defaultHeaders.merging(with: requestHeaders)
    /// print(mergedHeaders) // [Content-Type: text/plain]
    /// ```
    func merge(_ requestHeaders: [HTTPHeader]) -> [HTTPHeader] {
        let mergedDictionary = (self + requestHeaders)
            .reduce(into: [String: HTTPHeader]()) { result, header in
                result[header.name.lowercased()] = header
            }
        
        return Array(mergedDictionary.values)
    }
}
