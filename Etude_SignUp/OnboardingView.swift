//
//  OnboardingView.swift
//  Etude_SignUp
//
//  Created by xujia on 8/9/24.
//

import SwiftUI

struct OnboardingView: View {
    /*
     onboarding state
     1: welcome screen sign up
     2: Name screen
     3: Age screen
     4: Gender screen
     5: profile sreen
     */
    
    // Sign up inputs
    @State var onboardingState: Int = 0
    @State var username: String = ""
    @State var userAge: Double = 18
    @State var userGender: String = ""
    let genderOptions: [String] = ["Male", "Female", "Non-Binary"]
    
    // Sign up effects and alerts
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    // App storage
    @AppStorage("name") var currentUsername: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            // Content
            ZStack {
                switch onboardingState {
                case 0:
                    welcomeScreen
                        .transition(transition)
                case 1:
                    nameScreen
                        .transition(transition)
                case 2:
                    ageScreen
                        .transition(transition)
                case 3:
                    genderScreen
                        .transition(transition)
                default:
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(.green)
                }
            }
            
            // Button
            VStack {
                Spacer()
                
                bottomButton // View doesn't require ()
            }
            .padding(30)
        }
        .alert(isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
        })
    }
}

#Preview {
    OnboardingView()
        .background(Color.purple)
}

// MARK: SCREENS
extension OnboardingView {
    private var bottomButton: some View {
        Button(
                onboardingState == 0 ? "SIGN UP" :
                onboardingState == 3 ? "SUBMIT" :
                "NEXT",
            action: {
                handleNextButtonPressed()
            })
        .font(.headline)
        .foregroundColor(.purple)
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var welcomeScreen: some View {
        VStack (spacing: 40) {
            Spacer()
            
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text("Find your date now!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .overlay(
                    Capsule(style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .frame(height: 3)
                        .offset(y: 5)
                    , alignment: .bottom
                )
            
            Text("Join the number one date application online with over 1 million active users!")
                .font(.headline)
            
            Spacer()
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.horizontal, 30)
    }
    
    private var nameScreen: some View {
        VStack (spacing: 40) {
            Spacer()
            
            Text("What's your name?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            TextField("Enter your name...", text: $username)
                .font(.headline)
                .frame(height: 50)
                .padding(.horizontal, 10)
                .background(Color.white)
                .cornerRadius(10)
            
            Spacer()
            Spacer()
        }
        .padding(.horizontal, 30)
    }
    
    private var ageScreen: some View {
        VStack (spacing: 40) {
            Spacer()
            
            Text("What's your age?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            let formattedUserAge: String = String(format: "%.0f", userAge)
            Text(formattedUserAge)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Slider(value: $userAge, in: 18...100, step: 1)
                .accentColor(.white)
            
            Spacer()
            Spacer()
        }
        .padding(.horizontal, 30)
    }
    
    private var genderScreen: some View {
        VStack (spacing: 20) {
            Spacer()
            
            Text("What's your gender?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            VStack {
                Text(userGender.count > 0 ? "\(userGender)" : "Select a gender")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Picker(
                    selection: $userGender,
                    content: {
                        ForEach(genderOptions, id: \.self) { option in
                            Text(option).tag(option)
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    },
                    label: {Text("Select a gender")})
                .pickerStyle(.wheel)
            }
            
            Spacer()
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}

// MARK: LOGIC
extension OnboardingView {
    func handleNextButtonPressed() {
        // Check inputs
        switch onboardingState {
        case 1:
            guard isUsernameValid(username: username) else {
                showAlert(title: "A valid name is required!")
                return
            }
        case 3:
            guard isGenderValid(gender: userGender) else {
                showAlert(title: "Select a gender!")
                return
            }
            break
        default:
            break
        }
        
        func isUsernameValid(username: String) -> Bool {
            let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
            let regex = "^[A-Za-z]{2,20}$"
            let usernameTest = NSPredicate(format: "SELF MATCHES %@", regex)
            return usernameTest.evaluate(with: trimmedUsername)
        }
        
        func isGenderValid(gender: String) -> Bool {
            return gender.count > 0
        }
        
        // Go to next screen
        if (onboardingState == 3) {
            submit()
        } else {
            withAnimation(.spring()) {
                onboardingState += 1
            }
        }
    }
    
    // Assign all variables to app storage
    func submit() {
        currentUsername = username
        currentUserAge = Int(userAge)
        currentUserGender = userGender
        withAnimation(.spring()) {
            currentUserSignedIn = true
        }
    }
    
    func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
}
