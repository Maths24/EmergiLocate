//
//  EmergiLocateApp.swift
//  EmergiLocate
//
//  Created by Matthias Meierlohr on 21.03.24.
//

import SwiftUI

@main
struct EmergiLocateApp: App {
    var webSocketManager: WebSocketManager = WebSocketManager()
    var showEmergencyAlert = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(webSocketManager)
                //.environmentObject(showEmergencyAlert)
        }
    }
}
