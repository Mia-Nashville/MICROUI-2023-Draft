//
//  UserModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct UserModel: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let email: String
    let fullname: String
    var uid: String
    let username: String
    var profileImageUrl: String?
}


