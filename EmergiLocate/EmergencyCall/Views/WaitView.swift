//
//  WaitView.swift
//  EmergiLocate
//
//  Created by Matthias Meierlohr on 21.03.24.
//

import SwiftUI

struct WaitView: View {
    @EnvironmentObject var webSocketManager : WebSocketManager
    @State private var countdown = 3
    @State private var jumpBack = false
    @State private var nextViewActive = false
    var body: some View {
        GeometryReader { geometry in
            
            HStack {
                NavigationLink(destination: ContentView(),
                               isActive: $jumpBack,
                               label: {EmptyView()})
                Spacer()
                VStack{
                    NavigationLink(destination: DetailView(),
                                   isActive: $nextViewActive,
                                   label: {EmptyView()})
                    Text("Emergency call in")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                    Spacer()
                    Text("\(countdown)")
                        .font(.system(size: geometry.size.width * 0.45))
                        .fontWeight(.bold)
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.9, alignment: .center)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(geometry.size.width * 0.45)
                        .overlay(
                            Circle()
                                .stroke(Color("SOSRed"), lineWidth: (geometry.size.width * 0.9) * 0.05)
                        )
                    Spacer()
                    Button(action: {
                        // Cancel action here
                        print("Cancel Emergency Call")
                        jumpBack = true
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: geometry.size.width*0.25))
                            .foregroundColor(.gray)
                            .overlay(
                                Circle()
                                    .stroke(Color("BorderCancel"), lineWidth: (geometry.size.width * 0.9) * 0.04)
                            )
                        
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            // Start the countdown
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                if self.countdown > 1 {
                    self.countdown -= 1
                } else {
                    timer.invalidate()
                    // Perform the emergency call action
                    print("Initiate Emergency Call")
                    nextViewActive = true
                }
            }
        }
        .onDisappear() {
            webSocketManager.send(object: Information(TYPE: "EMERGENCY", IP: webSocketManager.getIPAddress() ?? "0.0.0.0"))
        }
    }
}

#Preview {
    WaitView()
}
