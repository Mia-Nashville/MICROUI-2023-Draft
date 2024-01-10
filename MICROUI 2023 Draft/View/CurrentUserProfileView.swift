//
//  CurrentUserProfileView.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var showEditProfile = false
     
 //    private var filterBarWidth: CGFloat {
 //        let count = CGFloat(ProfileThreadFilter.allCases.count)
 //        return UIScreen.main.bounds.width / count - 20
 //    }
     
     private var currentUser: UserModel? {
         return viewModel.currentUser
     }
     
     var body: some View {
         NavigationStack {
             ScrollView(showsIndicators: false, content: {
                 VStack(spacing: 20) {
                         HStack(alignment: .top) {
                             VStack(alignment: .leading, spacing: 12) {
                                 
                                 VStack(alignment: .leading, spacing: 4) {
                                     //  Text("Stashville") or
                                         Text(currentUser?.fullname ?? "")
                                    
                                         .font(.title2)
                                         .fontWeight(.semibold)
                                     
                                      Text(currentUser?.username ?? "")
                                    
                                     //      Text("stashville_nashville")
                                         .font(.subheadline)
                                 }
                      
                                 
                                 Text("2 Followers")
                                     .font(.caption)
                                     .foregroundStyle(.secondary)
                             }
                             
                             Spacer()
                             
                             CircularProfileImageView(user: currentUser)
                         }
                     
                     
                     Button(action: {
                         showEditProfile.toggle()
                     }, label: {
                         Text("Edit Profile")
                             .font(.subheadline)
                             .fontWeight(.semibold)
                             .foregroundStyle(Color.black)
                             .frame(width: 352, height: 36)
                             .background(.white)
                             .cornerRadius(10)
                             .overlay {
                                 RoundedRectangle(cornerRadius: 10)
                                     .stroke(Color(.systemGray4), lineWidth: 1)
                             }
                     })
                     
                     // User Content List View
                     if let currentUser = currentUser {
                       ProfileContentView()
                     //    UserContentListView(user: currentUser)
                     }
                 }
         })
             .sheet(isPresented: $showEditProfile, content: {
                 if let user = currentUser {
                     EditProfileView(user: user)
                 }
             })
             .padding(.horizontal)
             .toolbar {
                 ToolbarItem(placement: .navigationBarTrailing) {
                     Button(action: {
                         AuthService.shared.signOut()
                     }, label: {
                         HStack {
                             Text("Sign Out")
                             Image(systemName: "line.3.horizontal")
                         }
                     })
                     .font(.subheadline)
                     .foregroundColor(Color.black)
                 }
         }
         }
     }
}

struct CurrentUserProfileView_Preview: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView()
    }
}
