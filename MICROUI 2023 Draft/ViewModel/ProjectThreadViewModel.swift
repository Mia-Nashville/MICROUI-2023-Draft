//
//  ProjectThreadViewModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Firebase
import SwiftUI

@MainActor
final class ProjectThreadViewModel: ObservableObject {
    @Published var threadsVM = [ProjectThreadModel]()
    
    init() {
        Task {
            try await fetchUsersThread()
        }
    }
    
    func uploadProjectThreads(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let threadData = ProjectThreadModel(ownerUid: uid, caption: caption, timestamp: Timestamp(), likes: 1)
     try await ProjectThreadService.uploadProjectThreads(threadData)
        
        print("Thread was created")
    }
    
    func fetchUsersThread() async throws {
        self.threadsVM = try await ProjectThreadService.fetchProjectThreads()
        
        try await fetchUserInfofromThreads()
    }
    
    private func fetchUserInfofromThreads() async throws {
        for i in 0 ..< threadsVM.count {
            let threads = threadsVM[i]
            let ownerUid = threads.ownerUid
            let threadUser = try await UserService.fetchUserUid(withUid: ownerUid)
            
            threadsVM[i].user = threadUser
        }
    }
    
}
