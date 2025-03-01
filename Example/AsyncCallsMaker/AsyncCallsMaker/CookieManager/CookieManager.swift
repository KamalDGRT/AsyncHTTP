//
//  CookieManager.swift
//  AsyncCallsMaker
//
//  Created by Kamal Sharma on 01/03/25.
//

import Foundation
import SwiftData

final class CookieManager {
    static let shared = CookieManager()
    var container: ModelContainer?
    var context: ModelContext?
    
    private init() {
        do {
            let schema = Schema([
                CookieData.self
            ])
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false
            )
            container = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
            
            if let container {
                context = ModelContext(container)
            }
            
        } catch {
            print(error)
        }
    }
    
    /// Retrieves all cookies stored for a specific domain
    func getCookies(for domain: String) -> [HTTPCookie] {
        guard let context else { return [] }
        
        let descriptor = FetchDescriptor<CookieData>(
            predicate: #Predicate { $0.domain == domain }
        )
        
        do {
            let storedCookies = try context.fetch(descriptor)
            return storedCookies.compactMap { entity in
                HTTPCookie(properties: entity.httpCookieProperties)
            }
        } catch {
            print("Failed to fetch cookies: \(error)")
            return []
        }
    }
    
    /// Saves an array of cookies for a specific domain
    func saveCookies(_ cookies: [HTTPCookie], for domain: String) {
        guard let context
        else {
            print("SAVE: Failed to get context")
            return
        }
        
        for cookie in cookies {
            let descriptor = FetchDescriptor<CookieData>(
                predicate: #Predicate { $0.name == cookie.name && $0.domain == domain }
            )
            
            do {
                if let existingCookie = try context.fetch(descriptor).first {
                    // Update existing cookie
                    existingCookie.value = cookie.value
                    existingCookie.path = cookie.path
                    existingCookie.expires = cookie.expiresDate
                } else {
                    context.insert(cookie.cookieData)
                }
                
                try context.save()
            } catch {
                print("Failed to save cookies: \(error)")
            }
        }
    }
    
    func deleteCookies(for domain: String) {
        guard let context
        else {
            print("DELETE: Failed to get context")
            return
        }
        
        let descriptor = FetchDescriptor<CookieData>(
            predicate: #Predicate { $0.domain == domain }
        )
        do {
            let cookiesToDelete = try context.fetch(descriptor)
            
            for cookie in cookiesToDelete {
                context.delete(cookie)
            }
            
            try context.save()
        } catch {
            print("Failed to delete cookies for domain \(domain): \(error)")
        }
    }
    
    func deleteExpiredCookies() {
        guard let context
        else {
            print("DELETE: Failed to get context")
            return
        }
        
        let descriptor = FetchDescriptor<CookieData>(
            predicate: #Predicate { $0.isExpired }
        )
        
        do {
            let expiredCookies = try context.fetch(descriptor)
            
            for cookie in expiredCookies {
                context.delete(cookie)
            }
            
            try context.save()
        } catch {
            print("Failed to delete expired cookies: \(error)")
        }
    }
}
