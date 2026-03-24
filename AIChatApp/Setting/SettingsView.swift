//
//  SettingsView.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

// MARK: - SettingsView.swift
import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var settings: AppSettings
    @ObservedObject var viewModel: ChatViewModel
    
    var body: some View {
        NavigationView {
            List {
                
                // Preferences
                Section("Preferences") {
                    Toggle("Auto Speak Responses", isOn: $settings.autoSpeak)
                    Toggle("Dark Mode", isOn: $settings.isDarkMode)
                }
                
                // Chat actions
                Section("Chat") {
                    Button(role: .destructive) {
                        viewModel.messages.removeAll()
                    } label: {
                        Text("Clear Chat")
                    }
                }
                
                // Onboarding option
                Section("Onboarding") {
                    Toggle("Show Onboarding", isOn: $settings.showOnboardingEveryLaunch)
                        .tint(settings.selectedTheme.accentColor)
                }
                
                // Theme selection
                Section("Theme") {
                    ForEach(AppTheme.allCases) { theme in
                        HStack {
                            Circle()
                                .fill(theme.accentColor)
                                .frame(width: 20, height: 20)
                            
                            Text(theme.displayName)
                            
                            Spacer()
                            
                            if settings.selectedTheme == theme {
                                Image(systemName: "checkmark")
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            settings.selectedTheme = theme
                        }
                    }
                }
                
                // About
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
