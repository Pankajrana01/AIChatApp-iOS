//
//  AppSettings.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

import SwiftUI

class AppSettings: ObservableObject {
    
    @AppStorage("autoSpeak") var autoSpeak: Bool = true
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("selectedTheme") private var selectedThemeRaw: String = AppTheme.ocean.rawValue
    
    // ✅ Persisted onboarding flags
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @AppStorage("showOnboardingEveryLaunch") var showOnboardingEveryLaunch: Bool = false
    
    var selectedTheme: AppTheme {
        get { AppTheme(rawValue: selectedThemeRaw) ?? .ocean }
        set { selectedThemeRaw = newValue.rawValue }
    }
}
