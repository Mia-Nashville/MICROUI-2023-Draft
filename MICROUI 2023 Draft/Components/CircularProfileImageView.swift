//
//  CircularProfileImageView.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Kingfisher
import SwiftUI

struct CircularProfileImageView: View {
    var user: UserModel?
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .foregroundColor(Color.gray).opacity(0.9)
        }
    }
}

#Preview {
    CircularProfileImageView()
}
