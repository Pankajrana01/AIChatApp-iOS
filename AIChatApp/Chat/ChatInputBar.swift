//
//  ChatInputBar.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

// MARK: - Modern Input Area
import SwiftUI

struct ChatInputBar: View {
    
    @Binding var messageText: String
    @Binding var isRecording: Bool
    var onSend: () -> Void
    
    @FocusState private var isFocused: Bool
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        HStack(spacing: 12) {
            
            // Mic Button
            Button {
                toggleRecording()
            } label: {
                Image(systemName: isRecording ? "mic.fill" : "mic")
                    .font(.system(size: 20))
                    .foregroundColor(isRecording ? .red : .blue)
                    .frame(width: 42, height: 42)
                    .background(.ultraThinMaterial, in: Circle())
            }
            
            // Expanding TextField
            ZStack(alignment: .leading) {
                if messageText.isEmpty {
                    Text("Type your message...")
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 14)
                }
                TextField("", text: $messageText, axis: .vertical)
                    .focused($isFocused)
                    .lineLimit(1...5)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
            }
            .background(
                RoundedRectangle(cornerRadius: 22)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(
                                isFocused
                                ? settings.selectedTheme.gradient
                                : LinearGradient(colors: [.clear, .clear], startPoint: .top, endPoint: .bottom),
                                lineWidth: 1.2
                            )
                    )
            )
            
            // Send Button
            Button {
                if !messageText.trimmingCharacters(in: .whitespaces).isEmpty {
                    onSend()
                }
            } label: {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 42, height: 42)
                    .background(
                        Circle()
                            .fill(
                                messageText.isEmpty
                                ? LinearGradient(colors: [Color.gray.opacity(0.4), Color.gray.opacity(0.4)], startPoint: .top, endPoint: .bottom)
                                : settings.selectedTheme.gradient
                            )
                    )
            }
            .disabled(messageText.isEmpty)
        }
        .padding(12)
        .background(
            BlurBackground()
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: -4)
        )
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
    
    private func toggleRecording() {
        if isRecording {
            isRecording = false
            // call stop recording if you have SpeechManager
        } else {
            isRecording = true
            // call start recording
        }
    }
}

struct BlurBackground: View {
    var body: some View {
        Rectangle()
            .fill(.ultraThinMaterial)
    }
}
