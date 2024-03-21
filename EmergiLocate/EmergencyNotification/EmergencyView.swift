//
//  EmergencyView.swift
//  EmergiLocate
//
//  Created by Matthias Meierlohr on 21.03.24.
//

import SwiftUI

struct EmergencyView: View {
    @EnvironmentObject var webSocketManager : WebSocketManager
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                VStack{
                    Text("Emergency Alert")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.red)
                        
                    Text("Medical Condition")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Spacer()
                    Image("Roomplan")
                        .resizable()
                        .scaledToFit()
                    Text("Floor 3, Room 3.5")
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
    }
}

#Preview {
    EmergencyView()
}
