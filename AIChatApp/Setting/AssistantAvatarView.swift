//
//  AssistantAvatarView.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

import SwiftUI

struct AssistantAvatarView: View {
    
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        ZStack {
            
            // Gradient glow ring
            Circle()
                .stroke(settings.selectedTheme.gradient, lineWidth: 2)
                .frame(width: 36, height: 36)
            
            // Glass background
            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 32, height: 32)
            
            // AI icon
            Image(systemName: "sparkles")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(settings.selectedTheme.gradient)
        }
    }
}
