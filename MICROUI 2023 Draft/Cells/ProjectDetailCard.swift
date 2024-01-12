//
//  ProjectDetailCard.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/12/24.
//

import Foundation
import SwiftUI
import Kingfisher

struct ProjectDetailCard: View {
    var projects: ProjectModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 5) {
                    if let imageUrlString = projects.imageUrlString {
                        KFImage(URL(string: imageUrlString))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 400, height: 345)
                            .shadow(radius: 5)
                    } else {
                        Image(systemName: "questionmark.square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 400, height: 345)
                            .shadow(radius: 5)
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text(projects.projectName)
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.black)
                        
                        HStack(spacing: 8) {
                            ForEach(1...5, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow).opacity(0.8)
                                    .font(.subheadline)
                            }
                            Text("5.0")
                                .font(.system(.headline))
                                .padding(.leading, 5)
                        }
                        
                        Text("Project Number: \(projects.projectNumber)")
                            .font(.headline)
                            .fontWeight(.black)
                        
                        Text("Locations: \(projects.location)")
                            .font(.subheadline)
                            .fontWeight(.black)
                            .padding(.bottom, 10)
                        
                        Text("Project Manager: \(projects.projectManager)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Text("Superintendent: \(projects.superintendent)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Text("Client: \(projects.clientName ?? "")")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Text("Project Description: \(projects.projectDescription ?? "")")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                    }
                    .padding()
                    
                    // NavigationStack here
                    Group {
                        VStack(alignment: .leading, spacing: 0) {
                            NavigationLink(destination: {
                                
                            }, label: {
                                ProjectMenuRow(title: "Drilling Summary", leftIcon: "target")
                            })
                            .padding(.vertical, 5)
                            
                            NavigationLink(destination: {
                                
                            }, label: {
                                ProjectMenuRow(title: "Grouting", leftIcon: "rectangle.inset.filled.and.person.filled")
                            })
                            .padding(.vertical, 5)
                            
                            NavigationLink(destination: {
                                
                            }, label: {
                                ProjectMenuRow(title: "Daily Site Report", leftIcon: "doc.badge.plus")
                            })
                            .padding(.vertical, 5)
                            
                            
                            NavigationLink(destination: {
                                
                            }, label: {
                                ProjectMenuRow(title: "Setup Pile Type", leftIcon: "textformat.abc")
                            })
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .foregroundColor(Color.black).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 25))
                    }
                }
            }
            
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}
