//
//  ContentView.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ChatViewModel()
    @StateObject private var speechManager = SpeechManager()
    @StateObject private var ttsManager = TextToSpeechManager()
    @StateObject private var settings = AppSettings()
    
    @State private var isRecording = false
    @State private var showSettings = false
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {
                
                // MARK: - Chat Messages
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(viewModel.messages) { message in
                                ChatBubble(
                                    message: message,
                                    isStreaming: viewModel.isStreaming &&
                                    message.id == viewModel.messages.last?.id
                                )
                                .id(message.id)
                                .contextMenu {
                                    Button(role: .destructive) {
                                        viewModel.deleteMessage(message)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .padding(.top)
                    }
                    .onChange(of: viewModel.messages.last?.id) {
                        scrollToBottom(proxy: proxy)
                    }
                }
                
                // MARK: - Modern Input Area
                ChatInputBar(
                    messageText: $viewModel.inputText,
                    isRecording: $isRecording,
                    onSend: { Task { await viewModel.sendMessage() } }
                )
                .environmentObject(settings)
            }
            .navigationTitle("Pankaj Rana AI Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                // Settings Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                
                // Clear Chat Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(role: .destructive) {
                        viewModel.clearChat()
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .tint(settings.selectedTheme.accentColor)
        .preferredColorScheme(settings.isDarkMode ? .dark : .light)
        .background(settings.selectedTheme.chatBackground)
        .animation(.easeInOut(duration: 0.3), value: settings.selectedTheme)
        .environmentObject(settings)
        .sheet(isPresented: $showSettings) {
            SettingsView(viewModel: viewModel)
                .environmentObject(settings)
        }
        .onAppear {
            speechManager.requestPermission()
        }
        .onChange(of: viewModel.isStreaming) {
            if viewModel.isStreaming == false,
               settings.autoSpeak {
                speakLastAssistantMessage()
            }
        }
    }
}

// MARK: - Helper Methods
extension ContentView {
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        if let last = viewModel.messages.last {
            withAnimation(.easeOut(duration: 0.25)) {
                proxy.scrollTo(last.id, anchor: .bottom)
            }
        }
    }
    
    private func toggleRecording() {
        if isRecording {
            speechManager.stopRecording()
            isRecording = false
        } else {
            try? speechManager.startRecording()
            isRecording = true
        }
    }
    
    private func speakLastAssistantMessage() {
        guard let last = viewModel.messages.last,
              last.role == "assistant",
              !last.content.isEmpty else { return }
        
        ttsManager.speak(text: last.content)
    }
}


#Preview {
    ContentView()
}
