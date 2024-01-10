//
//  ThreadListView.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

struct ThreadListView: View {
    @State var commentText: String = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewmodel = ProjectThreadViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        LazyVStack(alignment: .leading) {
                            ForEach(viewmodel.threadsVM) { threads in
                                ThreadCell(thread: threads)}
                        }
                        .padding(.top)
                        
                        HStack(spacing: 5) {
                            TextField("Enter Comments ...", text: $commentText, axis: .vertical)
                                .frame(width: 360, height: 100)
                        }
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .font(.footnote)
                        .padding(.vertical, 120)
                        
                        if !commentText.isEmpty {
                            Button(action: {
                                commentText = ""
                            }, label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(Color.gray)
                            })
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    try await viewmodel.fetchUsersThread()
                     // MARK: add this to fetch the usersname and ownerImageUrl
                }
            }
            .padding()
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            // MARK: Tool bar goes here. Remember to add a NavigationStack for the toolbar to work
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                    .font(.subheadline)
                    .fontWeight(.medium)
                }
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        Task {
                          try await  viewmodel.uploadProjectThreads(caption: commentText)
                            
                //MARK: upload users thread viewmodel here
                            dismiss()
                        }
                        //MARK: viewmodel goes here
                    }, label: {
                        Text("Posts")
                    })
                })
            }
        .foregroundColor(Color.black)
        }
        }
    }


struct ThreadListView_Preview: PreviewProvider {
    static var previews: some View {
        ThreadListView(viewmodel: ProjectThreadViewModel())
    }
}


