//
//  GroutViewModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

final class GroutViewModel: ObservableObject {
    @Published var groutVM = [GroutModel]()
    var projects: ProjectModel
    
    init(projects: ProjectModel) {
        self.projects = projects
        
        fetchGroutLog()
    }
    
    func createGroutLog(pileNumber: Int, groutDate: Date, groutForemen: String, groutSample: String, primarygroutVolume: Int, topOffVolume: Int, specificGravity: String) {
        guard let user = Auth.auth().currentUser else { return }
        //   guard let projectID = projects.id else { return }
        guard let projectID = projects.id else {return}
        
        let storedData: [String: Any] = ["pileNumber": pileNumber, "groutDate": groutDate, "groutForeman": groutForemen, "groutSample": groutSample, "primarygroutVolume": primarygroutVolume, "topOffVolume": topOffVolume, "specificGravity": specificGravity, "ownerUid": user.uid]
        
        COLLECTION_PROJECTS.document(projectID).collection("grouting").addDocument(data: storedData)
        //    Firestore.firestore().collection("grouting").addDocument(data: storedData)
        //  COLLECTION_PROJECTS.document(projectID).collection("Grouting").addDocument(data: storedData) { _ in
        
        print("Successfully updated grout log")
    }
    
    func fetchGroutLog() {
        
        Firestore.firestore().collection("grouting").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Debug error found \(error.localizedDescription)")
            } else {
                guard let documents = querySnapshot?.documents else { return }
                self.groutVM = documents.map({ queryDocumentSnapshot -> GroutModel in
                    let data = queryDocumentSnapshot.data()
                    let pileNumber = data["pileNumber"] as? Int ?? 0
                    let dateValue = (data["groutDate"] as AnyObject).dateValue()
                    let date = dateValue.formatDates()
                    let groutForemen = data["groutForemen"] as? String ?? ""
                    let groutSample = data["groutSample"] as? String ?? ""
                    let primarygroutVolume = data["primarygroutVolume"] as? Int ?? 0
                    let topOffVolume = data["topOffVolume"] as? Int ?? 0
                    let specificGravity = data["specificGravity"] as? String ?? ""
                    let ownerUid = data["ownerUid"] as? String ?? ""
                    
                    return GroutModel(pileNumber: pileNumber, groutDate: dateValue, groutForemen: groutForemen, groutSample: groutSample, primarygroutVolume: primarygroutVolume, topOffVolume: topOffVolume, specificGravity: specificGravity, ownerUid: ownerUid)
                })
            }
        }
    }
}
    
//    func uploadGroutLog(pileNumber: Int, groutDate: Date, groutForemen: String, groutSample: String, primarygroutVolume: Int, topOffVolume: Int, specificGravity: String) async throws {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let groutData = GroutModel(pileNumber: pileNumber, groutDate: groutDate, groutForemen: groutForemen, groutSample: groutSample, primarygroutVolume: primarygroutVolume, topOffVolume: topOffVolume, ownerUid: uid)
//        
//        try await GroutService.uploadGroutLog(groutData)
//
//        print("Grout Log was created")
//    }
//    
//    func fetchUsersGroutLog() async throws {
//        self.groutVM = try await GroutService.fetchGroutLog()
//    }

extension Date {
    func formatDates() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd "
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM d, yyyy")
        return dateFormatter.string(from: self)
    }
}

