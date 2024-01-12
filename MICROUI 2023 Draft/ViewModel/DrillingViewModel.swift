//
//  DrillingViewModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

final class DrillingViewModel: ObservableObject {
    @Published var drillingVM = [DrillingModel]()
    var projects: ProjectModel
    
    init(projects: ProjectModel) {
        self.projects = projects
        
        fetchDrillLog()
    }
    func createDrillLog(pileID: Int, drillDate: Date, pileType: String, casingStickup: String, actualBondLength: String, totalDrillDepth: Int, drillerName: String, soilDepth1: Int, soilDepth2: Int, soilDepth3: Int, soilDepth4: Int, soilProfile1: String, soilProfile2: String, soilProfile3: String, soilProfile4: String, image: UIImage?) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        guard let projectID = projects.id else {return}
        
        guard let image = image else { return }
        
        ProjectImageUpload.uploadImage(image: image, type: .drilling) { imageUrl in
            let storedData: [String: Any] = ["pileID": "Pile \(pileID)",
                                             "drillDate" : drillDate,
                                             "pileType": pileType,
                                             "casingStickup": casingStickup,
                                             "actualBondLength": actualBondLength,
                                             "totaldrillDepth": totalDrillDepth,
                                             "drillersname": drillerName,
                                             "soilDepth1": soilDepth1,
                                             "soilDepth2": soilDepth2,
                                             "soilDepth3": soilDepth3,
                                             "soilDepth4": soilDepth4,
                                             "soilProfile1" : soilProfile1,
                                             "soilProfile2": soilProfile2,
                                             "soilProfile3" : soilProfile3,
                                             "soilProfile4" : soilProfile4,
                                             "ownerUid": userID,
                                             "imageUrlString": imageUrl,
                                             "timestamp": Timestamp()]
            
            COLLECTION_PROJECTS.document(projectID).collection("drilling").addDocument(data: storedData) { error in
                if let error = error {
                    print("Debug \(error.localizedDescription)")
                } else {
                    print("Successfully created drill log")
                }
            }
        }
    }
    
    func fetchDrillLog() {
        guard let projectID = projects.id else { return }
        
        COLLECTION_PROJECTS.document(projectID).collection("drilling").getDocuments { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else { return }
            self.drillingVM = documents.compactMap({ try? $0.data(as: DrillingModel.self)
            })
        }
        
    }
}

    

