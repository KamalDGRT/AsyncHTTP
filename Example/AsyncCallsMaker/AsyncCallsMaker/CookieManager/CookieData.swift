//
//  CookieData.swift
//  AsyncCallsMaker
//
//  Created by Kamal Sharma on 01/03/25.
//

import Foundation
import SwiftData

@Model
class CookieData {
    var name: String
    var value: String
    var domain: String
    var path: String
    var expires: Date?
    
    init(
        name: String,
        value: String,
        domain: String,
        path: String,
        expires: Date? = nil
    ) {
        self.name = name
        self.value = value
        self.domain = domain
        self.path = path
        self.expires = expires
    }
}

extension CookieData {
    var isExpired: Bool {
        guard let expires else { return false }
        return expires < Date()
    }
    
    var httpCookieProperties: [HTTPCookiePropertyKey: Any] {
        var properties: [HTTPCookiePropertyKey: Any] = [
            .name: name,
            .value: value,
            .domain: domain,
            .path: path
        ]
        if let expires = expires {
            properties[.expires] = expires
        }
        return properties
    }
}
