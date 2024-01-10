//
//  GroutModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct GroutModel: Identifiable, Codable {
    @DocumentID var id: String?
    var pileNumber: Int
    var groutDate: Date
    var groutForemen: String
    var groutSample: String
    var primarygroutVolume: Int
    var topOffVolume: Int?
    var specificGravity: String?
    let ownerUid: String
}
