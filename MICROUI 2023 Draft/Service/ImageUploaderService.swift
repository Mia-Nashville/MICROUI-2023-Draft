//
//  ImageUploaderService.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

enum UploadType {
   case profile
   case project
   case drilling
   case dailyReport
   
   var filePath: StorageReference {
       let filename = NSUUID().uuidString
       switch self {
       case .profile:
           return Storage.storage().reference(withPath: "/PROFILE_IMAGES/\(filename)")
       case .project:
           return Storage.storage().reference(withPath: "PROJECT_IMAGES/\(filename)")
       case .drilling:
           return Storage.storage().reference(withPath: "DRILLING_IMAGES/\(filename)")
       case .dailyReport:
           return Storage.storage().reference(withPath: "REPORT_IMAGES/\(filename)")
       }
   }
}

struct ImageUploader {
    static func uploadImage(_ image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.6) else { return nil }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "/profile_images/ \(filename)")
        
        do {
            let _ = try await storageRef.putDataAsync(imageData)
            let url = try await storageRef.downloadURL()
            return url.absoluteString
        } catch {
            print("Debug: Failed to upload image with error: \(error.localizedDescription)")
            return nil
        }
    }
}
   
   struct ProjectImageUpload {
       static func uploadImage(image: UIImage, type: UploadType, completion: @escaping(String)-> Void) {
           guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
           let docRef = type.filePath
           docRef.putData(imageData, metadata: nil) { (_, error) in
               if let error = error {
                   print("Debug Failed to upliad image \(error.localizedDescription)")
                   return }
               docRef.downloadURL { (url, _) in
                   guard let imageUrl = url?.absoluteString else { return }
                   completion(imageUrl)
               }
           }
       }
   }


