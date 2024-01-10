//
//  DailySiteModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct DailySiteModel: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var uid: String
    var reportDate: Date
    var siteActivity: String
    var materialDelivered: String
    var delayEncountered: String
    var ownerUid: String
    var imageUrlString: String?
    var conversation: String
}
