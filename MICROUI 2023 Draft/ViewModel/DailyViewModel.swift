//
//  DailyViewModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

final class DailyViewModel: ObservableObject {
    @Published var dailyVM = [DailySiteModel]()
    var projects: ProjectModel
    
    init(projects: ProjectModel) {
        self.projects = projects
        
        fetchDailyReport()
    }
    
    func createDailyReport(reportDate: Date, siteActivity: String, materialDelivered: String, delaysEncountered: String, image: UIImage?, conversation: String) {
        guard let user = Auth.auth().currentUser else { return }
        guard let projectID = projects.id else {return}
        guard let image = image else { return }
        
        ProjectImageUpload.uploadImage(image: image, type: .dailyReport) { imageUrl in
            let storedData : [String: Any] = ["reportDate": reportDate, "siteActivity": siteActivity, "materialDelivered": materialDelivered, "delaysEncountered" : delaysEncountered, "ownerUid": user.uid, "imageUrlString": imageUrl, "conversation": conversation]
            
            COLLECTION_PROJECTS.document(projectID).collection("dailyReport").addDocument(data: storedData)
          //  Firestore.firestore().collection("dailyReport").addDocument(data: storedData)
            
            print("Successfully upload Daily Report")
        }
    }
    
    func fetchDailyReport() {
        guard let user = Auth.auth().currentUser else { return }
        
        Firestore.firestore().collection("dailyReport").getDocuments { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else { return }
            self.dailyVM = documents.map({ queryDocumentSnapshot -> DailySiteModel in
                let data = queryDocumentSnapshot.data()
                let reportDate = data["reportDate"] as? Date ?? Date()
                let siteActivity = data["siteActivity"] as? String ?? ""
                let materialDelivered = data["materialDelivered"] as? String ?? ""
                let delaysEncountered = data["delaysEncountered"] as? String ?? ""
                let ownerUid = data["ownerUid"] as? String ?? ""
                let imageUrlString = data["imageUrlString"] as? String ?? ""
                let uid = data["uid"] as? String ?? ""
                let conversation = data["conversation"] as? String ?? ""
                
                return DailySiteModel(uid: uid, reportDate: reportDate, siteActivity: siteActivity, materialDelivered: materialDelivered, delayEncountered: delaysEncountered, ownerUid: uid, imageUrlString: imageUrlString, conversation: conversation)
            })
        }
    }
}


