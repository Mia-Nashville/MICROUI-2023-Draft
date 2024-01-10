//
//  HazardDetailView.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

struct HazardDetailView: View {
    var selectedsafety: InsiteSafetyModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack(alignment:.leading, spacing: 0) {
                Image(selectedsafety.jobphoto)
                    .resizable()
                //  .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                    .clipped()
                    .overlay(
                        HStack {
                            VStack(alignment: .leading) {
                                Spacer()
                                Text(selectedsafety.title)
                                    .font(.system(.title3, design: .rounded))
                                    .foregroundColor(Color.white)
                                    .padding(10)
                                    .background(Color.blue)
                                    .fontWeight(.bold)
                                    .cornerRadius(20)
                            }
                        })
                
                VStack(alignment: .leading) {
                    Text(selectedsafety.subtitle)
                        .fontWeight(.black)
                        .font(.title2)
                        .padding(5)
                    
                    Text(selectedsafety.description)
                        .hoverEffect(.automatic)
                        .font(.body)
                        .padding(5)
                    Text(selectedsafety.hazardControltitle)
                        .fontWeight(.black)
                        .font(.title2)
                        .padding(5)
                    
                    Text(selectedsafety.controlMeasure)
                        .font(.body)
                        .hoverEffect(.automatic)
                    
                    Spacer(minLength: 10)
                    Text(selectedsafety.controlMeasure2)
                        .fontWeight(.medium)
                }
                .padding()
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
