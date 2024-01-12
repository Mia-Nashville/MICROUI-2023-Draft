//
//  GroutLogSetup.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

struct GroutLogSetup: View {
    @ObservedObject var viewmodel: GroutViewModel
    
    @Environment(\.dismiss) var dismiss
    @State var backgroundGradient =  AngularGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1))]), center: .center, angle: .degrees(70))
    @State private var dateselected = Date.now
    @State private var sampleisOn: Bool = false
    @State private var showAlertIcon: Bool = false
    @State private var plunging: Bool = false
    @State private var tremie: Bool = false
    @State private var selectedgroutVolume: Int?
    @State private var selectedtopOffVolume: Int?
    @State private var specificGravity = ""
    @State var selectedPile : Int?
    @State private var selectedforeman = ""
    
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()
            VStack(spacing: 20) {
                
                Text("Grouting Log")
                    .fontWeight(.bold)
                    .font(.title3)
                    .padding(.horizontal)
                
                HStack(spacing: 5) {
                    TextField("Enter Pile Number", value: $selectedPile, format: .number)
                        .modifier(ThreadsTextFieldModifier())
                        .frame(width: 400)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 5) {
                        DatePicker("Select a Date ->", selection: $dateselected, displayedComponents: .date)
                            .padding(.horizontal, 20)
                            .foregroundColor(Color.blue)
                            .fontWeight(.black)
                    }
                }
                
                HStack(spacing: 5) {
                    TextField("Enter Grout Foreman",text: $selectedforeman)
                        .modifier(ThreadsTextFieldModifier())
                        .frame(width: 400)
                }
                
                HStack(spacing: 5) {
                    TextField("Primary Grout Volume", value: $selectedgroutVolume, format: .number)
                        .modifier(ThreadsTextFieldModifier())
                        .frame(width: 400)
                }
                
                HStack(spacing: 5) {
                    TextField("Enter Specific Gravity",text: $specificGravity)
                        .modifier(ThreadsTextFieldModifier())
                        .frame(width: 400)
                }
                .padding(.vertical, 10)
                HStack(spacing: 20) {
                    Toggle("Grout Sample Taken", isOn: $sampleisOn)
                    Text(sampleisOn ? "YES" : "NO")
                }
                .padding(.horizontal, 10)
                
                HStack(spacing: 20) {
                    Toggle("Hole is clean and depth was verified prior to grouting", isOn: $tremie)
                        .lineLimit(2)
                        .font(.subheadline)
                    Text(tremie ? "YES" : "NO")
                }
                .padding(.horizontal, 10)
                
                HStack(spacing: 20) {
                    Toggle("Pile was plunged for full length casing", isOn: $plunging)
                        .lineLimit(2)
                        .font(.subheadline)
                    Text(plunging ? "YES" : "NO")
                        .labelsHidden()
                }
                .padding(.horizontal, 10)
                
                HStack(spacing: 5) {
                    TextField("TopOff Grout Volume", value: $selectedtopOffVolume, format: .number)
                        .modifier(ThreadsTextFieldModifier())
                        .frame(width: 400)
                }
                
                HStack(spacing: 5) {
                    Button(action: {
                        // MARK: add viewmodel here
                        viewmodel.createGroutLog(pileNumber: selectedPile ?? 0, groutDate: dateselected, groutForemen: selectedforeman, groutSample: "Yes", primarygroutVolume: selectedgroutVolume ?? 0, topOffVolume: selectedtopOffVolume ?? 0, specificGravity: specificGravity)
                        
                        showAlertIcon = true
                    }, label: {
                        Text("Submit")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(plunging ? .white : .gray)
                            .frame(width: 160, height: 46)
                            .background(.black)
                            .cornerRadius(12)
                            .padding(.vertical, 5)
                    })
                    .disabled(!plunging)
                    
                    .padding()
                    
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                            .frame(width: 160, height: 46)
                            .background(.indigo)
                            .cornerRadius(12)
                            .padding(.vertical, 5)
                    })
                }
            }
        }
        .padding(.horizontal, 20
        )
        .alert("Notification", isPresented: $showAlertIcon, actions: {
            Text("Grouting Log Is Now Saved")
        })
    }
        
    }
    
struct GroutLogSetup_Preview: PreviewProvider {
    static var previews: some View {
        GroutLogSetup(viewmodel: GroutViewModel(projects: devPreview.mockProjects))
    }
}
