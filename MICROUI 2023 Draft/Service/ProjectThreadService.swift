//
//  ProjectThreadService.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ProjectThreadService {
    static func uploadProjectThreads(_ threads: ProjectThreadModel) async throws {
        guard let threadData = try? Firestore.Encoder().encode(threads) else { return }
        try await Firestore.firestore().collection("projectThreads").addDocument(data: threadData)
    }
    
    static func fetchProjectThreads() async throws -> [ProjectThreadModel] {
        let snapshot = try await Firestore.firestore().collection("projectThreads").order(by: "timestamp", descending: true).getDocuments()
        
        return snapshot.documents.compactMap { try? $0.data(as: ProjectThreadModel.self)
        }
    }
    
    static func fetchOwnerThreads(uid: String) async throws -> [ProjectThreadModel] {
        let querySnapshot = try await Firestore.firestore().collection("projectThreads").whereField("ownerUid", isEqualTo: uid).getDocuments()
        
        let threads = querySnapshot.documents.compactMap { try? $0.data(as: ProjectThreadModel.self)
        }
        
        return threads.sorted { $0.timestamp.dateValue() > $1.timestamp.dateValue() }
    }
}
