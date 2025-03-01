//
//  ContentView.swift
//  AsyncCallsMaker
//
//  Created by Kamal Sharma on 28/02/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: .zero) {
                    APIView(
                        title: "Random Corporate Jargon",
                        backgroundColor: .pink
                    ) {
                        viewModel.fetchCorporateJargon()
                    }
                    
                    APIView(
                        title: "Random Useless Fact",
                        backgroundColor: .blue
                    ) {
                        viewModel.fetchRandomUselessFact()
                    }
                    
                    APIView(
                        title: "Random Fact for Today",
                        backgroundColor: .indigo
                    ) {
                        viewModel.fetchUselessFactOfToday()
                    }
                    
                    ProgressView()
                        .scaleEffect(1.5)
                        .opacity(viewModel.isLoading ? 1 : 0)
                        .padding(.bottom, 16)
                    
                    if viewModel.currentView != .none {
                        APIResultView(
                            title: viewModel.title,
                            content: viewModel.content
                        )
                    }
                }
            }
            .background(Color.mint.opacity(0.4))
            .navigationTitle("Asynchronous API Calls")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.mint, for: .navigationBar)
        }
    }
}

struct APIResultView: View {
    let title: String
    let content: String
    
    var body: some View {
        ZStack {
            Color.white
            VStack(spacing: .zero) {
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.red)
                    .padding(.vertical, 24)
                
                Text(content)
                    .fontDesign(.monospaced)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 24)
                    .padding(.horizontal, 16)
                    .foregroundStyle(Color.black)
            }
        }
        .clipShape(.rect(cornerRadius: 20))
        .padding(.horizontal, 10)
        
    }
}

struct APIView: View {
    let title: String
    let backgroundColor: Color
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack {
                Rectangle()
                    .fill(backgroundColor)
                    .frame(height: 50)
                    .clipShape(.rect(cornerSize: .init(width: 11, height: 25)))
                Text(title)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
            .padding(16)
        }
    }
}
#Preview {
    ContentView(viewModel: ContentViewModel())
}
