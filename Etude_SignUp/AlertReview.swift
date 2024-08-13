//
//  AlertReview.swift
//  Etude_SignUp
//
//  Created by xujia on 8/9/24.
//

import SwiftUI

struct AlertReview: View {
    @State var showAlert: Bool = false
    @State var message: String = ""
    
    var body: some View {
        Text("\(message)")
        
        Button(action: {
            showAlert = true
        }, label: {
            Text("Button")
        })
        .alert(isPresented: $showAlert, content: {
            getAlert()
        })
    }
    
    func getAlert() -> Alert {
        Alert(
            title: Text("This is the title"),
            message: Text("We will describe the error"),
            primaryButton: .destructive(
                Text("Delete"),
                action: {
                    message = "You just clicked DELETE!"
            }),
            secondaryButton: .cancel(
                Text("Cancel"),
                action: {
                    message = "You just clicked CANCEL!"
                }))
    }		
}

#Preview {
    AlertReview()
}
