//
//  AsyncCallsMakerApp.swift
//  AsyncCallsMaker
//
//  Created by Kamal Sharma on 28/02/25.
//

import SwiftUI

@main
struct AsyncCallsMakerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
