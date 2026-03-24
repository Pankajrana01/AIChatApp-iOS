//
//  AIService.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

import Foundation

//class AIService {
//    
//    private let apiKey = "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"
//    
//    func sendMessage(messages: [ChatMessage]) async throws -> String {
//        
//        let urlString = "https://api.openai.com/v1/responses"
//        
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return "URL Error"
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let combinedText = messages.map { "\($0.role): \($0.content)" }
//            .joined(separator: "\n")
//        
//        let body: [String: Any] = [
//            "model": "gpt-4.1-mini",
//            "input": combinedText
//        ]
//        
//        request.httpBody = try JSONSerialization.data(withJSONObject: body)
//        
//        let (data, response) = try await URLSession.shared.data(for: request)
//        
//        print("Status:", (response as? HTTPURLResponse)?.statusCode ?? 0)
//        print(String(data: data, encoding: .utf8) ?? "")
//        
//        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
//        
//        if let output = json?["output"] as? [[String: Any]],
//           let contentArray = output.first?["content"] as? [[String: Any]],
//           let text = contentArray.first?["text"] as? String {
//            return text
//        }
//        
//        return "No response"
//    }
//}


class AIService {
    
    private let apiKey = "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"
    private let useMock = true   // 👈 toggle here
    
    func sendMessage(messages: [ChatMessage]) async throws -> String {
        
        if useMock {
            try await Task.sleep(nanoseconds: 1_000_000_000) // 1 sec delay
            
            let lastMessage = messages.last?.content ?? ""
            
            return "Mock AI reply to: \(lastMessage)"
        }
        
        // Real API Call Below
        
        let urlString = "https://api.openai.com/v1/responses"
        guard let url = URL(string: urlString) else {
            return "Invalid URL"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let combinedText = messages.map { "\($0.role): \($0.content)" }
            .joined(separator: "\n")
        
        let body: [String: Any] = [
            "model": "gpt-4.1-mini",
            "input": combinedText
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return "Invalid response"
        }
        
        if httpResponse.statusCode == 429 {
            return "⚠️ Quota exceeded. Please check billing."
        }
        
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        if let output = json?["output"] as? [[String: Any]],
           let contentArray = output.first?["content"] as? [[String: Any]],
           let text = contentArray.first?["text"] as? String {
            return text
        }
        
        return "No response"
    }
    
//    func streamMessage(
//        messages: [ChatMessage],
//        onUpdate: @escaping (String) -> Void) async throws {
//        
//        let url = URL(string: "https://api.openai.com/v1/responses")!
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let combinedText = messages.map { "\($0.role): \($0.content)" }
//            .joined(separator: "\n")
//        
//        let body: [String: Any] = [
//            "model": "gpt-4.1-mini",
//            "input": combinedText,
//            "stream": true
//        ]
//        
//        request.httpBody = try JSONSerialization.data(withJSONObject: body)
//        
//        let (bytes, _) = try await URLSession.shared.bytes(for: request)
//        
//        var fullText = ""
//        
//        for try await line in bytes.lines {
//            if line.contains("data:") {
//                let cleaned = line.replacingOccurrences(of: "data: ", with: "")
//                
//                if cleaned == "[DONE]" { break }
//                
//                if let data = cleaned.data(using: .utf8),
//                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
//                   let delta = json["output"] as? [[String: Any]],
//                   let content = delta.first?["content"] as? [[String: Any]],
//                   let text = content.first?["text"] as? String {
//                    
//                    fullText += text
//                    onUpdate(fullText)
//                }
//            }
//        }
//    }
    
    func streamMockMessage(
        messages: [ChatMessage],
        onUpdate: @escaping (String) -> Void
    ) async {
        
        let lastMessage = messages.last?.content ?? ""
        
        let mockResponse = """
        This is a simulated AI streaming reply for: \(lastMessage).
        We are testing typing effect like ChatGPT.
        """
        
        var currentText = ""
        
        for char in mockResponse {
            currentText.append(char)
            
            await MainActor.run {
                onUpdate(currentText)
            }
            
            try? await Task.sleep(nanoseconds: 30_000_000) // typing speed
        }
    }
}
