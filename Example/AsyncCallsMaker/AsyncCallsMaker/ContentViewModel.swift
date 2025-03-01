//
//  ContentViewModel.swift
//  AsyncCallsMaker
//
//  Created by Kamal Sharma on 02/03/25.
//

import Foundation

enum CurrentView {
    case randomUselessFact
    case uselessFactOfToday
    case corporateJargon
    case none
}

final class ContentViewModel: ObservableObject {
    private let apiLibrary: NetworkLibrary
    
    private var uselessFact: UselessFact?
    private var corporateJargon: CorporateSaying?
    
    @Published var isLoading: Bool
    @Published var currentView: CurrentView
    
    init(
        apiLibrary: NetworkLibrary = NetworkLibrary(),
        currentView: CurrentView = .none,
        isLoading: Bool = false
    ) {
        self.apiLibrary = apiLibrary
        self.currentView = currentView
        self.isLoading = isLoading
    }
}

// MARK: API Cals
extension ContentViewModel {
    func fetchUselessFactOfToday() {
        isLoading = true
        
        Task {
            do {
                uselessFact = try await apiLibrary.getUselessFactOfTheDay()
                isLoading = false
                currentView = .uselessFactOfToday
            } catch {
                isLoading = false
                print("ERROR: Failed to fetch Useful Fact of the day")
            }
        }
    }
    
    func fetchRandomUselessFact() {
        isLoading = true
        
        Task {
            do {
                uselessFact = try await apiLibrary.getRandomUselessFact()
                isLoading = false
                currentView = .randomUselessFact
            } catch {
                isLoading = false
                print("ERROR: Failed to fetch Useful Fact of the day")
            }
        }
    }
    
    func fetchCorporateJargon() {
        isLoading = true
        
        Task {
            do {
                corporateJargon = try await apiLibrary.getRandomCorporateSaying()
                isLoading = false
                currentView = .corporateJargon
            } catch {
                isLoading = false
                print("ERROR: Failed to fetch Corporate Jargon")
            }
        }
    }
}

// MARK: Content & Data
extension ContentViewModel {
    var title: String {
        switch currentView {
        case .uselessFactOfToday:
            return "Useless Fact Of the Day"
        case .randomUselessFact:
            return "Random Useless Fact"
        case .corporateJargon:
            return "Corporate Jargon"
        case .none:
            return ""
        }
    }
    
    var content: String {
        switch currentView {
        case .randomUselessFact, .uselessFactOfToday:
            uselessFact?.text ?? ""
        case .corporateJargon:
            corporateJargon?.phrase ?? ""
        case .none:
            ""
        }
    }
}
