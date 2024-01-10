//
//  ProjectViewModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Firebase
import SwiftUI
import FirebaseFirestoreSwift

final class ProjectViewModel: ObservableObject {
    @Published var projectVM = [ProjectModel]()
    
    init() {
        fetchAllProjects()
    }
    
    func createMainProjects(clientName: String, location: String, projectManager: String, projectNumber: String, projectName: String, projectDescription: String, superintendent: String, image: UIImage? ) {
        guard let user = Auth.auth().currentUser else { return }
        let document = COLLECTION_PROJECTS.document()
        let documentID = document.documentID
        guard let image = image else { return }
        
        ProjectImageUpload.uploadImage(image: image, type: .project) { imageUrl in
            let storedData: [String: Any] = ["clientName": clientName, "location": location, "projectManager": projectManager, "projectNumber": projectNumber, "projectName": projectName, "projectDescription": projectDescription, "superintendent": superintendent, "uid": documentID, "timeStamp": Timestamp(), "ownerUid": user.uid, "imageUrlString": imageUrl]
            
            COLLECTION_PROJECTS.document(documentID).setData(storedData) { _ in
            print("Successfully uploaded Project Data")}
        }
        }
    
    func fetchAllProjects() {
        COLLECTION_PROJECTS.getDocuments { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
             return }
            self.projectVM = documents.compactMap({ (queryDocumentSnapshot) -> ProjectModel? in
                return try? queryDocumentSnapshot.data(as: ProjectModel.self)
            })
        }
    }
    
    func fetchProjectData() {
      // COLLECTION_PROJECTS.getDocuments { querySnapshot, _ in
    //    Firestore.firestore().collection("Micropile Projects 2024").getDocuments { querySnapshot, _ in
        COLLECTION_PROJECTS.getDocuments { (querySnapshot, _) in
            guard let documents = querySnapshot?.documents else { return }
            self.projectVM = documents.map({ queryDocumentSnapshot -> ProjectModel in
                let data = queryDocumentSnapshot.data()
                let projectName = data["projectName"] as? String ?? ""
                let clientName = data["clientName"] as? String ?? ""
                let location = data["location"] as? String ?? ""
                let projectDescription = data["projetDescription"] as? String ?? ""
                let ownerUid = data["ownerUid"] as? String ?? ""
                let projectManager = data["projectManager"] as? String ?? ""
                let projectNumber = data["projectNumber"] as? String ?? ""
                let superintendent = data["superintendent"] as? String ?? ""
                let timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
                let imageUrlString = data["imageUrlString"] as? String ?? ""
                
                return ProjectModel(clientName: clientName, location: location, imageUrlString: imageUrlString, projectManager: projectManager, projectNumber: projectNumber, projectName: projectName, projectDescription: projectDescription, superintendent: superintendent, ownerUid: ownerUid, timeStamp: timeStamp)
            })
        }
    }
    }

