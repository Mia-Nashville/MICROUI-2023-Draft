//
//  ProjectCell.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import Kingfisher
import SwiftUI

struct ProjectCell: View {
    let projects: ProjectModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 12) {
                if let imageUrlString = projects.imageUrlString {
                    KFImage(URL(string: imageUrlString))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                        .foregroundColor(Color.gray).opacity(0.9)
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                        .foregroundColor(Color.gray).opacity(0.9)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        //  Text("Project Panda")
                        Text(projects.projectName)
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    //    Text("Project #11000093")
                    Text(projects.projectNumber)
                        .font(.subheadline)
                    
                    // Text("Columbia, TN")
                    Text(projects.location)
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    NavigationLink(destination: {
                        
                    }, label: {
                        Image(systemName: "bubble.right")
                    })
                }
            }
            Divider()
                .padding(.top)
        }
        .padding()
    }
}

struct ProjectCell_Preview: PreviewProvider {
    static var previews: some View {
        ProjectCell(projects: devPreview.mockProjects)
        
    }
}


