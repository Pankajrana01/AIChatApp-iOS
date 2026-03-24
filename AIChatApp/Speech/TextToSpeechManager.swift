//
//  TextToSpeechManager.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

import Foundation
import AVFoundation

class TextToSpeechManager: ObservableObject {
    
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(text: String) {
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        
        synthesizer.speak(utterance)
    }
    
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
