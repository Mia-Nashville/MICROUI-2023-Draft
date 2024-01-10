//
//  AuthViewModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

@MainActor
final class AuthViewModel: ObservableObject {
    
    func createUserRegistration(email: String, password: String, fullname: String, username: String) async throws {
        try await AuthService.shared.createNewUser(withEmail: email, password: password, fullname: fullname, username: username)
        
        print("Created new user")
    }
    
    func resetUserPassword(email: String) async throws {
        try await AuthService.shared.resetUserPassword(withEmail: email)
        
        print("Password resent link sent to user email \(email)")
    }
    
    func loginUser(email: String, password: String) async throws {
        try await AuthService.shared.loginUser(withEmail: email, password: password)
    }
}
