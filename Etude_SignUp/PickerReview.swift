//
//  PickerReview.swift
//  Etude_SignUp
//
//  Created by xujia on 8/9/24.
//

import SwiftUI

struct PickerReview: View {
    @State var selection: Int = 0
    @State var selectedOption: String = "Most Recent"
    @State var filterOptions: [String] = [
        "Most Recent",
        "Most Popular",
        "Most Liked"
    ]
    
    var body: some View {
        
        VStack {
            Text(selection > 0 ? "Age: \(selection)" : "Select your age")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
            
            Picker("Picker",
                   selection: $selection,
                   content: {
                ForEach(18...25, id: \.self) { age in
                    Text("\(age)").tag(age)
                        .foregroundColor(.red)
                }
            })
            .pickerStyle(WheelPickerStyle())
        }
        .padding(30)
        
        // Since iOS16, put in a List
        List {
            Picker(selection: $selection) {
                ForEach(18...25, id: \.self) { age in
                    Text("\(age)").tag(age)
                        .foregroundColor(.red)
                }
            } label: {
                Text("Picker")
            }
            .pickerStyle(.menu)
        }
        
        Picker("Options", selection: $selectedOption, content: {
            ForEach(filterOptions, id: \.self) { option in
                Text(option)
            }
        })
    }
}

#Preview {
    PickerReview()
}
