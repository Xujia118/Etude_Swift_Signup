//
//  ProfileView.swift
//  Etude_SignUp
//
//  Created by xujia on 8/9/24.
//

import SwiftUI

struct ProfileView: View {
    // App storage
    @AppStorage("name") var currentUsername: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text(currentUsername ?? "Unknown")
            Text("\(currentUserAge ?? 0)")
            Text(currentUserGender ?? "Unknown")
            
            Button(action: {
                signout()
            }, label: {
                Text("SIGN OUT")
                    .foregroundColor(.white)
                    .padding()
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
            })
        }
        .font(.headline)
        .foregroundColor(.purple)
        .padding()
        .padding(.vertical, 40)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
    
    func signout() {
        currentUsername = nil
        currentUserAge = nil
        currentUserGender = nil
        currentUserSignedIn = false
    }
}

#Preview {
    ProfileView()
}
