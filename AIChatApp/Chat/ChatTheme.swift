//
//  ChatTheme.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

import SwiftUI

struct ChatTheme {
    
    static func background(for scheme: ColorScheme) -> Color {
        scheme == .dark
        ? Color.black
        : Color(.systemGroupedBackground)
    }
    
    static func assistantBubble(for scheme: ColorScheme) -> Color {
        scheme == .dark
        ? Color(.systemGray5)
        : Color(.systemGray6)
    }
    
    static let userBubble = Color.accentColor
    
    static func assistantText(for scheme: ColorScheme) -> Color {
        scheme == .dark ? .white : .black
    }
    
    static let userText = Color.white
}
