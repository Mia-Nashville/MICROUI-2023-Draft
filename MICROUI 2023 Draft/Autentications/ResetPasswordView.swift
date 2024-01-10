//
//  ResetPasswordView.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

struct ResetPasswordView: View {
    @Environment (\.dismiss) var dismiss
    @State var email: String = ""
    @StateObject var viewmodel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
                VStack(spacing: 5) {
                    Image("cyntech")
                  //  Image(systemName: "character.phonetic")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 160)
                        .padding(.top)
                    
                    // email field
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .modifier(ThreadsTextFieldModifier())
                        .padding(.vertical, 10)
                    
                    Button(action: {
                        // MARK: Add viewmodel here
                        Task {
                            try await viewmodel.resetUserPassword(email: email)
                        }
                        
                    }, label: {
                        Text("Send Reset Password Link")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .frame(width: 320, height: 50)
                            .background(Color.black).opacity(0.9)
                            .clipShape(Capsule())
                            .padding()
                    })
                
                   Spacer()
                    
                    Divider()
                    
                    Text("Note: Check junk email box for link")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.vertical, 5)
                      
                    Button(action: {
                        dismiss()
                    }, label: {
                        HStack {
                            Text("Don't have an account:")
                                .font(.system(size: 16))
                            Text("Sign Up")
                                .font(.system(size: 16, weight: .bold))
                                .underline()
                        }
                        .foregroundStyle(Color.black)
                    })
                    .navigationBarBackButtonHidden(true)
                }
            
        }
    }
}
#Preview {
    ResetPasswordView()
}



