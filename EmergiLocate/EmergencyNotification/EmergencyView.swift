//
//  EmergencyView.swift
//  EmergiLocate
//
//  Created by Matthias Meierlohr on 21.03.24.
//

import SwiftUI

struct EmergencyView: View {
    @EnvironmentObject var webSocketManager : WebSocketManager
    @State private var nextViewActive = false
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                HStack {
                    Spacer()
                    VStack{
                        Text("Emergency Alert")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                        
                        Text("\(webSocketManager.receivedObject?.TYPE ?? "Emergency")")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        Spacer()
                        Image(nextViewActive ? "Roomplan" : "Roomplan2")
                            .resizable()
                            .scaledToFit()
                        Text(" \(webSocketManager.receivedObject?.FLOOR ?? "0"),  \(webSocketManager.receivedObject?.ROOM ?? "0")")
                            .font(.title)
                            .fontWeight(.semibold)
                        Spacer()
                        Text("You are the nearest Person to help!")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        Spacer()
                        
                        Button(action: {
                            print("Fire button pressed")
                            
                        }) {
                            HStack {
                                Image(systemName: "map")
                                    .foregroundColor(.red)
                                    .font(.system(size: geometry.size.width * 0.15))
                                
                                Text("Take me there")
                                    .foregroundStyle(.black)
                                    .fontWeight(.bold)
                                    .font(.largeTitle)
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: (geometry.size.width * 0.9) * 0.05)
                            )
                        }
                        .padding()
                        
                    }
                    Spacer()
                }
            }
            .onAppear {
                webSocketManager.scheduleNotification(type: webSocketManager.receivedObject?.TYPE ?? "Emergency", floor: webSocketManager.receivedObject?.FLOOR ?? "Room N/A", room: webSocketManager.receivedObject?.ROOM ?? "Emergency")
                // Start the countdown
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    nextViewActive = !nextViewActive
                }
            }
            
            .toolbar{
                Button {
                    webSocketManager.show = false
                } label: {
                    Text("Back")
                        .foregroundStyle(.black)
                }
            }
        }
        
    }
}

#Preview {
    EmergencyView()
}
