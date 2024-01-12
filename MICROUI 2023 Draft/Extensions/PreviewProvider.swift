//
//  PreviewProvider.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI
import Firebase

extension PreviewProvider {
    static var devPreview: DeveloperPreview {
        return DeveloperPreview.shared
    }
}


class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let mockUser = UserModel(email: "mia@gmail.com", fullname: "Mia Mitsumori", uid: NSUUID().uuidString, username: "mia")
    
    let mockProjects = ProjectModel(location: "Nashville, TN", projectManager: "Lanier Hutchingson", projectNumber: "1228883", projectName: "MDHA Mixed Use Development", projectDescription: " 5 story apartment", superintendent: "Cody Weitzel", ownerUid: NSUUID().uuidString, timeStamp: Timestamp())
    
    let mockSafety = InsiteSafetyModel(title: "LNOS", description: "Microfine and Fracture grouting for LA tunnel", controlMeasure: "Tieback suits", controlMeasure2: "Proper PPE", jobphoto: "image 1")
    
    let mockThreads = ProjectThreadModel(ownerUid: "1234", caption: "This is a thread", timestamp: Timestamp(), likes: 1)
    
    let mockDrilling = DrillingModel(drilldate: Date(), pileType: "Type B", casingStickup: "1 ft", actualBondLength: "30 ft", totaldrilldepth: 50, drillersname: "Chris Taylor", soilDepth1: 10, soilDepth2: 20, soilDepth3: 30, soilDepth4: 40, soilProfile1: "Fill", soilProfile2: "Clay", soilProfile3: "Sandy-Silt", soilProfile4: "Rock", pileID: "Pile 10")
}
