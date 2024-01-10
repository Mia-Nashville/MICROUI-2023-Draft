//
//  AuthService.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

@MainActor
final class AuthService {
    @Published var userSession: FirebaseAuth.User?
    @Published var didsendPasswordReset: Bool = false
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func loginUser(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            
            // add the fetchCurrentUser her
            try await UserService.shared.fetchCurrentUser()
            
        } catch {
            print("Debog failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func createNewUser(withEmail email: String, password: String, fullname: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            self.userSession = result.user // Sign in as User
            
            try await uploadUserData(withEmail: email, uid: result.user.uid, fullname: fullname, username: username) // setup after user authentication to make sure tht the documentID corresponds to userID
            
            
            print("Debug: Create user \(result.user.uid)")
            
        } catch {
            print("Debug: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut() // signs us out on backend
        self.userSession = nil // this removes the session locally and updates routing
        
        UserService.shared.resetUser() //reset user. sets current user object to nil
        
    }
    
    func resetUserPassword(withEmail email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            self.didsendPasswordReset = true
            
        } catch {
            print("Debug: Failed to reset user password \(error.localizedDescription)")
        }
    }
    
    @MainActor
    private func uploadUserData(withEmail email: String, uid: String, fullname: String, username: String) async throws {
        let user = UserModel(email: email, fullname: fullname, uid: uid, username: username)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await COLLECTION_USER.document(uid).setData(userData)
        
    }
}

    

