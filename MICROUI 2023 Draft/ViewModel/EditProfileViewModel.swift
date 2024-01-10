//
//  EditProfileViewModel.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI
import PhotosUI

class EditProfileViewModel : ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task {
                 await loadImage()
            }
        }
    }
    private var uiImage: UIImage?
    @Published var profileImage: Image?
    
    @MainActor
     func loadImage() async {
        guard let item = selectedItem else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else {
            return
        }
        guard let uiImage = UIImage(data: data) else { return }
        self.profileImage = Image(uiImage: uiImage)
        self.uiImage = uiImage
     }
    
    func updateUserData() async throws {
       try await updateProfileImage()
    }
    
    private func updateProfileImage() async throws {
        guard let image = self.uiImage else { return }
        guard let imageUrl = try? await ImageUploader.uploadImage(image) else { return }
        try await UserService.shared.updateUserProfileImage(withImageUrl: imageUrl)
        
    }
}

