//
//  ChatBubble.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

import SwiftUI
import AVFoundation

struct ChatBubble: View {
    
    let message: ChatMessage
    var isStreaming: Bool = false
    @EnvironmentObject var settings: AppSettings
    @Environment(\.colorScheme) private var colorScheme
    @State private var showCursor = true
    @State private var synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {

            if message.role == "assistant" {
                AssistantAvatarView()
                bubble
                Spacer(minLength: 40)
                
            } else {
                Spacer(minLength: 40)
                bubble
            }
        }
        .transition(.move(edge: .leading).combined(with: .opacity))
        .animation(.easeOut(duration: 0.25), value: message.id)
        .padding(.horizontal)
        .onChange(of: isStreaming) {
            if isStreaming {
                startCursorAnimation()
            }
        }
    }
    
    private var bubble: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            // ✅ CASE 1: Streaming started but no text yet
            if message.role == "assistant",
               isStreaming,
               message.content.isEmpty {
                
                TypingIndicatorView()
            }
            
            // ✅ CASE 2: Normal or streaming with text
            else {
                Text(.init(displayText))
                    .font(.body)
                    .textSelection(.enabled)
            }
            
            // Action buttons only after full response
            if message.role == "assistant",
               !message.content.isEmpty,
               !isStreaming {
                actionButtons
            }
        }
        .padding(12)
        .background(bubbleBackground)
        .foregroundColor(textColor)
        .cornerRadius(18)
        .shadow(
            color: colorScheme == .dark
            ? .black.opacity(0.3)
            : .black.opacity(0.08),
            radius: 4,
            x: 0,
            y: 2
        )
    }
    
    private var bubbleBackground: some View {
        Group {
            if message.role == "assistant" {
                
                // Glass style assistant bubble
                RoundedRectangle(cornerRadius: 18)
                    .fill(.ultraThinMaterial)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(
                                colorScheme == .dark
                                ? Color.white.opacity(0.05)
                                : Color.black.opacity(0.03)
                            )
                    )
                
            } else {
                
                // Gradient user bubble
                RoundedRectangle(cornerRadius: 18)
                    .fill(settings.selectedTheme.gradient)
            }
        }
    }
    
    private var displayText: String {
        if isStreaming && message.role == "assistant" {
            return message.content + (showCursor ? "▌" : "")
        }
        return message.content
    }
    
    private var bubbleColor: Color {
        message.role == "assistant"
        ? (colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6))
        : settings.selectedTheme.accentColor
    }
    
    private var textColor: Color {
        message.role == "assistant"
        ? .primary
        : .white
    }
    
    private var actionButtons: some View {
        HStack(spacing: 16) {
            
            Button {
                UIPasteboard.general.string = message.content
            } label: {
                Image(systemName: "doc.on.doc")
            }
            
            Button {
                speak(message.content)
            } label: {
                Image(systemName: "speaker.wave.2")
            }
        }
        .font(.caption)
        .foregroundColor(.secondary)
    }
    
    private func startCursorAnimation() {
        withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
            showCursor.toggle()
        }
    }
    
    private func speak(_ text: String) {
        synthesizer.stopSpeaking(at: .immediate)
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        synthesizer.speak(utterance)
    }
}
