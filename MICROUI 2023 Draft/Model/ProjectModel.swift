//
//  ProjectModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI

struct ProjectModel: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var clientName: String?
    var location: String
    var imageUrlString: String?
    var projectManager: String
    var projectNumber: String
    var projectName: String
    var projectDescription: String?
    var superintendent: String
    let ownerUid: String
    let timeStamp: Timestamp
    
    var user: UserModel?
    
}
