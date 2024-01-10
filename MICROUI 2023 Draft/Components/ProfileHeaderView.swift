//
//  ProfileHeaderView.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

struct ProfileHeaderViews: View {
    var user: UserModel
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(user.fullname)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(user.username)
                        .font(.subheadline)
                }
                Text("2 Following")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            
            CircularProfileImageView(user: user)
                .padding()
        }
        .padding(.leading)
    }
}
