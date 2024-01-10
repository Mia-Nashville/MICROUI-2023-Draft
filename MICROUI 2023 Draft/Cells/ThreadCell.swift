//
//  ThreadCell.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI
import Kingfisher


struct ThreadCell: View {
    let thread : ProjectThreadModel
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                if let profileImageUrl = thread.user?.profileImageUrl {
                    KFImage(URL(string: profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
    }
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                     //   Text("Stashville")
                        Text(thread.user?.username ?? "")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(thread.timestamp.timestampString())
                     //   Text("10m")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray3))
                        
                        Button(action: {
                            
                        }, label: {
                                 Image(systemName: "ellipsis")
                                    .foregroundColor(Color(.darkGray))
                            
                        })
                    }
                    Text(thread.caption)
               //     Text("Nashville Premier Running Club")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "heart")
                        })
                        NavigationLink(destination: {
                      // MARK: Add Comments here
                        }, label: {
                            Image(systemName: "bubble.right")
                        })
//                        Button(action: {
//
//                        }, label: {
//                            Image(systemName: "bubble.right")
//                        })
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "arrow.rectanglepath")
                        })
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "paperplane")
                        })
                    }
                    .padding(.vertical, 9)
                    .foregroundColor(Color.black)
                }
            }
            Divider()
            
                .padding(.top)
                
            }
        }
    }

struct ThreadCell_Preview: PreviewProvider {
    static var previews: some View {
        ThreadCell(thread: devPreview.mockThreads)
    }
}

