//
//  FeedView.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import SwiftUI
import Foundation

struct FeedView: View {
    @ObservedObject var viewModel = ProjectViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.projectVM, id: \.self) {projects in
                        NavigationLink(destination: {
                            ProjectDetailCard(projects: projects)
                        }, label: {
                            FeedCell(projects: projects)
                        })
                    }
                }
                .padding(.top)
                .navigationTitle("Micropile Projects")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct FeedView_Preview: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
