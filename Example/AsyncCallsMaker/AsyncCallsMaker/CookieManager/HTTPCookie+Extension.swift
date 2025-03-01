//
//  HTTPCookie.swift
//  AsyncCallsMaker
//
//  Created by Kamal Sharma on 01/03/25.
//

import Foundation

extension HTTPCookie {
    var cookieData: CookieData {
        CookieData(
            name: name,
            value: value,
            domain: domain,
            path: path,
            expires: expiresDate
        )
    }
}
