//
//  SOSView.swift
//  EmergiLocate
//
//  Created by Matthias Meierlohr on 21.03.24.
//

import SwiftUI

struct SOSView: View {
    
    var body: some View {
        NavigationLink {
            WaitView()
        } label: {
            GeometryReader {geometry in
                VStack {
                    Text("Emergency call in")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                    Spacer()
                    HStack {
                        Spacer()
                       
                            Text("SOS")
                                .font(.system(size: geometry.size.width * 0.30))
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
                    }
                    Spacer()
                    Button(action: {
                        // Cancel action here
                        print("Cancel Emergency Call")
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: geometry.size.width*0.25))
                            .foregroundColor(.white)
                            .overlay(
                                Circle()
                                    .stroke(.white, lineWidth: (geometry.size.width * 0.9) * 0.04)
                            )
                        
                    }
                }
            }
        }
        
    }
}

#Preview {
    SOSView()
}
