//
//  ContentView.swift
//  Etude_SignUp
//
//  Created by xujia on 8/9/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.pink, Color.purple]),
                center: .topLeading,
                startRadius: 5,
                endRadius: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            if currentUserSignedIn {
                ProfileView()
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
            } else {
                OnboardingView()
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
            }
        }
        .animation(.easeInOut, value: currentUserSignedIn) // Add animation here
    }
}

#Preview {
    ContentView()
}
