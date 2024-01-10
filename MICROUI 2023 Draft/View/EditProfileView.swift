//
//  EditProfileVIew.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct EditProfileView : View {
    @State private var bio = ""
    @State private var link = ""
    @State private var isprivateprofile: Bool = false
    @Environment(\.dismiss) var dismiss
    @StateObject var viewmodel = EditProfileViewModel()
    let user: UserModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
                
                VStack {
                    // Name and Profile Image
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Name")
                                .fontWeight(.semibold)
                            
                            Text(user.fullname)
                           // Text("Stashville Running CLub")
                        }
                        .font(.footnote)
                        
                        
                        Spacer()
                        
                        PhotosPicker(selection: $viewmodel.selectedItem) {
                            if let image = viewmodel.profileImage {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                CircularProfileImageView(user: user)
                            }
                        }
                    //    CircularProfileImageView()
                    }
                    
                    Divider()
                    // Bio Fields
                    
                    VStack(alignment: .leading) {
                        Text("Bio")
                            .fontWeight(.semibold)
                        
                        TextField("Enter your Bio", text: $bio, axis: .vertical)
                    }
                    .font(.footnote)
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text(user.email)
                            .fontWeight(.semibold)
                        
                        TextField("Add Link...", text: $link)
                    }
                    .font(.footnote)
                    
                    Divider()
                    
                    Toggle("Private Profile", isOn: $isprivateprofile)
                    
                        .font(.footnote)
                }
                .padding() // background padding
                .background(Color.white)
                .padding()
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Task {
                            try await viewmodel.updateUserData()
                            dismiss()
                        }
                    }, label: {
                        Text("Done")
                    })
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .fontWeight(.semibold)
                }
            }
        }
    }
}


struct EditProfileView_Preview: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: devPreview.mockUser)
    }
}


