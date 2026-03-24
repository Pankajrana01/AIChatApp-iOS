//
//  AIChatAppApp.swift
//  AIChatApp
//
//  Created by Pankaj Rannaa on 23/02/26.
//

import SwiftUI

@main
struct AIChatApp: App {
    
    @StateObject var settings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(settings)
        }
    }
}
