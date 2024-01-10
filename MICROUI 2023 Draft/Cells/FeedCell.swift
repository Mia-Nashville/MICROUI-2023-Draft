//
//  FeedCell.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI
import Kingfisher

struct FeedCell: View {
    @State var projects: ProjectModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            if let profileImageUrl = projects.imageUrlString {
                KFImage(URL(string: profileImageUrl))
                    .resizable()
                    .padding(.vertical, 10)
                    .frame(width: 400, height: 340)
                    .cornerRadius(5)
            } else {
                Image("image 1")
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical, 10)
                    .frame(width: 400, height: 340)
            }
            
            VStack {
                Text(projects.projectName)
                    .font(.title3)
                    .fontWeight(.black)
                    .lineLimit(2)
                    .padding(.bottom, 0)
                
                Text(projects.location)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .padding(.bottom, 0)
            }
            .padding(.horizontal, 10)
                
            VStack(spacing: 5) {
                HStack(spacing: 20) {
                    NavigationLink(destination: {
                        // MARK: Add Drill Log here
                        DrillLogSetup(viewmodel: DrillingViewModel(projects: projects))
                
                    }, label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                        Text("Drilling ")
                    })
                    .font(.headline).fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .background(.ultraThickMaterial)
                    
                    NavigationLink(destination: {
                        // MARK: Add Grout Log here
                        GroutLogSetup(viewmodel: GroutViewModel(projects: projects))
                        
                    }, label: {
                        Image(systemName: "pencil.tip")
                        Text("Grouting")
                    })
                    .font(.headline).fontWeight(.bold)
                    .foregroundColor(Color.indigo)
                    .background(.ultraThickMaterial)
                    
                    
                    NavigationLink(destination: {
                        // MARK: Add Daily Report Here
                        DailyReportSetup(viewmodel: DailyViewModel(projects: projects), siteActivity: "Drilled 4 piles, 350 linear ft", materialDelivered: "27 ton cement delivered", delayEncountered: "2 hours delayed by GC", conversation: " Conversation with Reeves & Young")
                        
                    }, label: {
                        Image(systemName: "doc.fill.badge.plus")
                        Text("Daily Report")
                    })
                    .font(.headline).fontWeight(.bold)
                    .foregroundColor(Color.gray)
                    .background(.ultraThickMaterial)
                }
                HStack(spacing: 20) {
                    NavigationLink(destination: {
                        // MARK: Add Pile Type here
                    }, label: {
                        Image(systemName: "l.joystick.tilt.up.fill")
                        Text("Pile Type")
                    })
                    .font(.headline).fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .background(.ultraThickMaterial)
                    
                    NavigationLink(destination: {
                        // MARK: Setup Project Notes
                
                    }, label: {
                        Image(systemName: "r.joystick.tilt.down.fill")
                        Text("Project Notes")
                    })
                    .font(.headline).fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .background(.ultraThickMaterial)
                }
            }
            .padding(.horizontal, 10)
        }
    }
}



struct FeedCell_Preview: PreviewProvider {
    static var previews: some View {
        FeedCell(projects: devPreview.mockProjects)
    }
}



