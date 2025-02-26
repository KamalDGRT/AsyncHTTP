//
// URLQueryParam.swift
// swift-async-http
//

import Foundation

/// A structure representing a URL query parameter.
///
/// This struct helps in constructing query parameters for a URL.
///
/// Example Usage:
/// ```swift
/// let param = URLQueryParam("search", "swift")
/// print(param.description)  // Output: "search=swift"
/// ```
public struct URLQueryParam {
    /// The name (key) of the query parameter.
    public let name: String
    
    /// The value of the query parameter.
    public let value: String
    
    /// Initializes a `URLQueryParam` with the given name and value.
    /// - Parameters:
    ///   - name: The name of the query parameter.
    ///   - value: The value of the query parameter.
    public init(_ name: String, _ value: String) {
        self.name = name
        self.value = value
    }
    
    /// Converts the query parameter into a `URLQueryItem` for use with `URLComponents`.
    ///
    /// Example:
    /// ```swift
    /// let param = URLQueryParam("page", "1")
    /// let queryItem = param.queryItem  // URLQueryItem(name: "page", value: "1")
    /// ```
    public var queryItem: URLQueryItem {
        URLQueryItem(name: name, value: value)
    }
}

extension URLQueryParam: CustomStringConvertible {
    /// A string representation of the query parameter in `name=value` format.
    ///
    /// Example:
    /// ```swift
    /// let param = URLQueryParam("lang", "en")
    /// print(param) // "lang=en"
    /// ```
    public var description: String {
        "\(name)=\(value)"
    }
}

public extension Array where Element == URLQueryParam {
    /// Returns a URL-encoded query string from the array of `URLQueryParam`.
    ///
    /// If the array is empty, it returns `nil`.
    ///
    /// Example:
    /// ```swift
    /// let params = [URLQueryParam("search", "swift"), URLQueryParam("page", "1")]
    /// print(params.urlEncodedString ?? "") // Output: "search=swift&page=1"
    /// ```
    var urlEncodedString: String {
        var urlComponents = URLComponents(string: "")
        urlComponents?.queryItems = self.map { $0.queryItem }
        return urlComponents?.query ?? ""
    }
    
    /// Returns a dictionary for an array of `URLQueryParam` objects.
    var dictionary: [String: String] {
        reduce(into: [String: String]()) { result, header in
            result[header.name] = header.value
        }
    }
}
