//
//  Models.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

import Foundation

struct ChatMessage: Identifiable, Codable {
    var id = UUID()
    let role: String
    var content: String
}

struct OpenAIResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: AssistantMessage
}

struct AssistantMessage: Codable {
    let role: String
    let content: String
}
