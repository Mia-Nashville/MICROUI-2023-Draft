//
//  RegistrationView.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

struct RegistrationView: View {
    // @ObservedObject var viewModel = RegistrationViewModel()
    @ObservedObject var viewmodel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @State private var username = ""
    @State private var signUp: Bool = false
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 10) {
            
            Image("cyntech")
            //  Image(systemName: "character.phonetic")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 160)
                .padding()
            
            VStack(spacing: 12) {
                TextField("Enter your email", text: $email)
                    .autocapitalization(.none)
                    .modifier(ThreadsTextFieldModifier())
                
                SecureField("Enter your password", text: $password)
                    .modifier(ThreadsTextFieldModifier())
                
                TextField("Enter your full name", text: $fullname)
                    .modifier(ThreadsTextFieldModifier())
                
                TextField("Enter your username", text: $username)
                    .modifier(ThreadsTextFieldModifier())
                    .autocapitalization(.none)
                
                Button(action: {
                    Task {
                        try await viewmodel.createUserRegistration(email: email,
                                                                   password: password,
                                                                   fullname: fullname , username: username)
                        //MARK: for any async await function, you must wrap up in Task try await
                    }
                    // print("Sign up User")
                }, label: {
                    Text("Sign Up")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .frame(width: 352, height: 50)
                        .background(.black)
                        .cornerRadius(12)
                })
                .padding()
                Spacer()
                
                Divider()
                
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account:").font(.subheadline) + Text(" Sign In").font(.headline).fontWeight(.bold)
                    }
                }
                .foregroundColor(Color.black)
                .font(.footnote)
            }
            .padding(.vertical, 16)
        }
        .navigationBarBackButtonHidden(true)
    }    
}

struct RegistrationView_Preview: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}


