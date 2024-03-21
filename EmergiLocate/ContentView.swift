//
//  ContentView.swift
//  EmergiLocate
//
//  Created by Matthias Meierlohr on 21.03.24.
//

import SwiftUI
import Starscream
import UserNotifications

struct ContentView: View  {
    //@StateObject private var webSocketManager = WebSocketManager(url: URL(string: "ws://10.51.3.3:8080")!)
    @EnvironmentObject var webSocketManager : WebSocketManager
    
    
    init(){
        UINavigationBar.setAnimationsEnabled(false)
        
    }
    var body: some View {
        /*VStack {
            
            Text("Received object: \(webSocketManager.receivedObject?.name ?? "None")")
                .foregroundStyle(.blue)
            Button("Disconnect") {
                
                // webSocketManager.disconnect()
                
            }
            
            Button("Send message") {
                webSocketManager.send(object: Information(TYPE: "emergency", IP: webSocketManager.getIPAddress() ?? "0.0.0.0"))
            }
        }*/
        
        NavigationStack {
            
            ZStack {
                //Color("AppBackground")
                //  .ignoresSafeArea()
                SOSView()
                
                /*Button("Send") {
                    webSocketManager.send(message: "Hello")
                }*/
                
            }.sheet(isPresented: $webSocketManager.show, content: {
                EmergencyView()
            })
            .onAppear {
                webSocketManager.send(message: "ping")
                
            }
        }
    }
    
    
}




#Preview {
    ContentView()
}
