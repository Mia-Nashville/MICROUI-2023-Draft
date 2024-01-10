//
//  ProjectThreadModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct ProjectThreadModel: Identifiable, Codable {
    @DocumentID var threadId: String?
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    
    var user: UserModel?
    
    var id: String {
        return threadId ?? NSUUID().uuidString
    }
}
