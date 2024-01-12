//
//  DrillingModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct DrillingModel: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var drilldate: Date
    var pileType: String
    var casingStickup: String
    var actualBondLength: String
    var totaldrilldepth: Int
    var drillersname: String
    var soilDepth1: Int
    var soilDepth2: Int
    var soilDepth3: Int
    var soilDepth4: Int
    var soilProfile1: String
    var soilProfile2: String
    var soilProfile3: String
    var soilProfile4: String
    var pileID: String?
    var imageUrlString: String?
    
    var projectsID: ProjectModel?
}
