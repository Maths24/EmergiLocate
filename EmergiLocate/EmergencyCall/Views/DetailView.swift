//
//  DetailView.swift
//  EmergiLocate
//
//  Created by Matthias Meierlohr on 21.03.24.
//

import SwiftUI

struct DetailView: View {
    @State private var jumpBack = false
    @State private var jumpForward = false
    var body: some View {
        GeometryReader { geometry in
            
            HStack {
                NavigationLink(destination: ContentView(),
                               isActive: $jumpBack,
                               label: {EmptyView()})
                NavigationLink(destination: HelpComingView(),
                               isActive: $jumpForward,
                               label: {EmptyView()})
                Spacer()
                VStack {
                    Text("What is the emergency?")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                    Spacer()
                // Fire
                Button(action: {
                    print("Fire button pressed")
                    jumpForward = true;
                }) {
                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.red)
                            .font(.system(size: geometry.size.width * 0.23))
                        
                        Text("Fire")
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
                    // Med
                    Button(action: {
                        print("Fire button pressed")
                        jumpForward = true
                    }) {
                        HStack {
                            Image(systemName: "cross.case.fill")
                                .foregroundColor(.red)
                                .font(.system(size: geometry.size.width * 0.25))
                            
                            Text("Medical condition")
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
                    
                    // Hazard
                    Button(action: {
                        print("Fire button pressed")
                        jumpForward = true;
                    }) {
                        HStack {
                            Image(systemName: "hazardsign.fill")
                                .foregroundColor(.red)
                                .font(.system(size: geometry.size.width * 0.25))
                            
                            Text("Hazard")
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
    }
}

#Preview {
    DetailView()
}
