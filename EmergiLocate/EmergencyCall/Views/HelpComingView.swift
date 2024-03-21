//
//  HelpComingView.swift
//  EmergiLocate
//
//  Created by Matthias Meierlohr on 21.03.24.
//

import SwiftUI
import UserNotifications


struct HelpComingView: View {
    @State private var jumpBack = false
    var body: some View {
        GeometryReader { geometry in
            HStack {
                
                Spacer()
                VStack {
                    Text("Help is on the way")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                    Spacer()
                    Image("Image")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                    HStack {
                        NavigationLink(destination: ContentView(),
                                       isActive: $jumpBack,
                                       label: {EmptyView()})
                        
                        Button(action: {
                            print("Solution resolved")
                            let content = UNMutableNotificationContent()
                            content.title = "Emergency Alert"
                            content.body = "Emergency situation reported at Location X."

                            // Configure trigger for a delay of 5 seconds (you can customize as needed)
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                            // Create request
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                            // Schedule the notification
                            UNUserNotificationCenter.current().add(request)
                            jumpBack = true
                        }) {
                            HStack {
                                Image(systemName: "cross.case.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: geometry.size.width * 0.25))
                                
                                Text("Situation resolved?")
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
                }
                Spacer()
            }
        }
        
    }
}

#Preview {
    HelpComingView()
}
