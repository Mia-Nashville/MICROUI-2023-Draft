//
//  LoginView.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject var viewmodel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("cyntech")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 160)
                     .padding()
                
                VStack(spacing: 12) {
                    TextField("Enter your email", text: $email)
                        .modifier(ThreadsTextFieldModifier())
                        .autocapitalization(.none)
                    
                    SecureField("Enter your password", text: $password)
                        .modifier(ThreadsTextFieldModifier())
                }
                
                NavigationLink(destination: {
                    ResetPasswordView()
                   // MARK: Add Forgot Password View Here
                }, label: {
                    Text("Forgot Password")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                .padding(.top)
                
                Button(action: {
                    // MARK: add the AuthViewModel loginUser
                    Task {
                        try await viewmodel.loginUser(email: email, password: password)
                    }
                }, label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .frame(width: 352, height: 45)
                        .background(.black)
                        .cornerRadius(12)
                        .padding(.vertical, 10)
                })
                Spacer()
                
                Divider()
                
                NavigationLink(destination: {
                    RegistrationView()
                }, label: {
                    HStack(spacing: 3) {
                        Text("Don't Have An Account:").font(.subheadline) + Text(" Sign Up").font(.headline).fontWeight(.bold)
                    }
                })
                .foregroundColor(Color.black)
                .font(.footnote)
            }
            .padding(.vertical, 16)
        }
    }
}

struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}



