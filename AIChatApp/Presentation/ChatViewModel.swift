//
//  ChatViewModel.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

import SwiftUI

@MainActor
class ChatViewModel: ObservableObject {
    
    @Published var messages: [ChatMessage] = []
    @Published var inputText: String = ""
    @Published var isLoading = false
    @Published var isStreaming = false
    
    private let service = AIService()
    
//    func sendMessage() async {
//        
//        guard !inputText.isEmpty else { return }
//        
//        let userMessage = ChatMessage(role: "user", content: inputText)
//        messages.append(userMessage)
//        inputText = ""
//        
//        let assistantMessage = ChatMessage(role: "assistant", content: "")
//        messages.append(assistantMessage)
//        
//        let index = messages.count - 1
//        
//        do {
//            try await service.streamMessage(messages: messages) { partialText in
//                DispatchQueue.main.async {
//                    self.messages[index] = ChatMessage(role: "assistant", content: partialText)
//                }
//            }
//        } catch {
//            print(error)
//        }
//    }
    func sendMessage() async {
        
        guard !inputText.isEmpty else { return }
        
        isStreaming = true
        
        let userMessage = ChatMessage(role: "user", content: inputText)
        messages.append(userMessage)
        inputText = ""
        
        let assistantMessage = ChatMessage(role: "assistant", content: "")
        messages.append(assistantMessage)
        
        let index = messages.count - 1
        
        await service.streamMockMessage(messages: messages) { partialText in
            self.messages[index].content = partialText   // ✅ FIX HERE
        }
        
        isStreaming = false
    }
    
    func clearChat() {
        messages.removeAll()
    }

    func deleteMessage(_ message: ChatMessage) {
        messages.removeAll { $0.id == message.id }
    }
}
