//
//  RootView.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

import SwiftUI

struct RootView: View {

    @StateObject var settings = AppSettings()
    @StateObject var viewModel = ChatViewModel()

    @State private var showOnboarding: Bool = false

    var body: some View {
        Group {
            if showOnboarding {
                OnboardingView {
                    settings.hasSeenOnboarding = true
                    showOnboarding = false // Immediately move to chat
                }
                .environmentObject(settings)
            } else {
                ContentView()
                    .environmentObject(settings)
                    .environmentObject(viewModel)
            }
        }
        .onAppear {
            showOnboarding = !settings.hasSeenOnboarding || settings.showOnboardingEveryLaunch
        }
    }
}
