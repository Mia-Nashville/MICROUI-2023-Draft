//
//  UserService.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift


typealias FirestoreCompletion = ((Error?) -> Void)?

class UserService {
    @Published var currentUser: UserModel?
    
    static let shared = UserService()
    
    init() {
        Task {
            try await fetchCurrentUser() // for displaying User data
        }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let currentuid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await COLLECTION_USER.document(currentuid).getDocument()
        let userdocument = try snapshot.data(as: UserModel.self)
        self.currentUser = userdocument
    }
    
    static func fetchAllUsers() async throws -> [UserModel] {
        guard let currentuid = Auth.auth().currentUser?.uid else { return [ ] }
        let snapshot = try await COLLECTION_USER.getDocuments()
        let users = snapshot.documents.compactMap { try? $0.data(as: UserModel.self)
        }
        return users.filter { $0.id != currentuid }
    }
    
    static func fetchUserUid(withUid uid: String) async throws -> UserModel {
        let snapshot = try await COLLECTION_USER.document(uid).getDocument()
        return try snapshot.data(as: UserModel.self)
    }
    
    func resetUser() {
        self.currentUser = nil // MARK: Used to reset currentUser
    }
    
    @MainActor
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        guard let currentuid = Auth.auth().currentUser?.uid else { return }
        try await COLLECTION_USER.document(currentuid).updateData(["profileImageUrl": imageUrl])
        self.currentUser?.profileImageUrl = imageUrl
    }
}
