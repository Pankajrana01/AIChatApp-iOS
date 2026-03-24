//
//  AppTheme.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case ocean
    case sunset
    case forest
    case midnight
    case candy
    
    var id: String { rawValue }
    
    var displayName: String { rawValue.capitalized }
    
    // Accent color
    public var accentColor: Color {
        switch self {
        case .ocean: return .blue
        case .sunset: return .orange
        case .forest: return .green
        case .midnight: return .purple
        case .candy: return .pink
        }
    }
    
    // Gradient for user bubble
    public var gradient: LinearGradient {    // <- make public
        switch self {
        case .ocean:
            return LinearGradient(
                colors: [.blue, .cyan],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .sunset:
            return LinearGradient(
                colors: [.orange, .red],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .forest:
            return LinearGradient(
                colors: [.green, .mint],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .midnight:
            return LinearGradient(
                colors: [.purple, .indigo],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .candy:
            return LinearGradient(
                colors: [.pink, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
    
    // Chat background
    public var chatBackground: LinearGradient {   // <- make public
        switch self {
        case .ocean:
            return LinearGradient(
                colors: [.blue.opacity(0.1), .cyan.opacity(0.1)],
                startPoint: .top,
                endPoint: .bottom
            )
        case .sunset:
            return LinearGradient(
                colors: [.orange.opacity(0.1), .red.opacity(0.1)],
                startPoint: .top,
                endPoint: .bottom
            )
        case .forest:
            return LinearGradient(
                colors: [.green.opacity(0.1), .mint.opacity(0.1)],
                startPoint: .top,
                endPoint: .bottom
            )
        case .midnight:
            return LinearGradient(
                colors: [.purple.opacity(0.15), .indigo.opacity(0.15)],
                startPoint: .top,
                endPoint: .bottom
            )
        case .candy:
            return LinearGradient(
                colors: [.pink.opacity(0.1), .purple.opacity(0.1)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}
