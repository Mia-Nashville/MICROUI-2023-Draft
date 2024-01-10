//
//  DailyReportSetup.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

struct DailyReportSetup: View {
    @ObservedObject var viewmodel : DailyViewModel
    @State var siteActivity: String
    @State var materialDelivered: String
    @State var delayEncountered: String
    @State var conversation: String
    @State private var dateSelected = Date.now
    @State var showImagePicker: Bool = false
    @State var showAlertIcon: Bool = false
    @State private var selectedImage: UIImage?
    @State private var postImage: Image?
    @Environment(\.dismiss) var dismiss
    
    @State var backgroundGradient =  RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1006665184, green: 0.007843137719, blue: 0.7041791803, alpha: 1)).opacity(0.8),Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(0.9), Color(#colorLiteral(red: 0.07443883983, green: 0.007843137719, blue: 0.4499540527, alpha: 1)).opacity(0.9)]), center: .bottomTrailing, startRadius: 4, endRadius: 400)
    
    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily Site Report")
                        .foregroundColor(Color.white)
                        .font(.title.bold())
                        .padding(.top)
                        .padding(.horizontal, 35)
                    
                    VStack(alignment: .leading) {
                        
                        HStack(spacing: 10) {
                            DatePicker("Select a Date", selection: $dateSelected, displayedComponents: .date)
                                .padding(.horizontal, 35)
                                .foregroundColor(Color.blue)
                        }
                        .padding(.leading, 1)
                        .font(.headline)
                        
                        VStack(spacing: 5) {
                            Text("Site Activity")
                                .modifier(fontModifier())
                            
                            HStack(spacing: 5) {
                                TextEditor(text: $siteActivity)
                                    .modifier(TextFieldClearButton(nextText: $siteActivity))
                                    .modifier(ChangeFrameSize())
                            }
                            
                            Text("Delay Encountered")
                                .modifier(fontModifier())
                            
                            HStack(spacing: 5) {
                                TextEditor(text: $delayEncountered)
                                    .modifier(TextFieldClearButton(nextText: $delayEncountered))
                                    .modifier(ChangeFrameSize())
                            }
                            Text("Conversation")
                                .modifier(fontModifier())
                            
                            HStack(spacing: 5) {
                                TextEditor(text: $conversation)
                                    .modifier(TextFieldClearButton(nextText: $conversation))
                                    .modifier(ChangeFrameSize())
                            }
                            
                            Text("Material Delivered")
                                .modifier(fontModifier())
                            
                            HStack(spacing: 5) {
                                TextEditor(text: $materialDelivered)
                                    .modifier(TextFieldClearButton(nextText: $materialDelivered))
                                    .modifier(ChangeFrameSize())
                            }
                            .padding(.bottom, 15)
                            
                            VStack(spacing: 5) {
                                Button { self.showImagePicker = true
                                    //   print("Show Image Picker")
                                } label: {
                                    HStack(spacing: 0) {
                                        GradientIconButton(icon: "camera.fill")
                                            .padding(.horizontal, 15)
                                        
                                        Text("Insert Photos")
                                            .foregroundColor(Color.white)
                                            .font(.headline)
                                            .frame(width: 230, height: 60)
                                        
                                        Image(uiImage: selectedImage ?? UIImage())
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50, alignment: .center)
                                            .clipShape(RoundedRectangle(cornerRadius: 11))
                                            .padding(.horizontal, 10)
                                        
                                    }
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white.opacity(0.6), lineWidth: 1))
                                    
                                }
                                .padding(.horizontal, 40)
                                
                                HStack(spacing: 5) {
                                    Button(action: {
                                        // MARK: Add viewModel for Daily Report here
                                        viewmodel.createDailyReport(reportDate: dateSelected, siteActivity: siteActivity, materialDelivered: materialDelivered, delaysEncountered: delayEncountered, image: selectedImage, conversation: conversation)
                                        showAlertIcon = true
                                    }, label: {
                                        Text("Submit")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color.white)
                                            .frame(width: 160, height: 46)
                                            .background(.black)
                                            .cornerRadius(12)
                                            .padding(.vertical, 5)
                                    })
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
                            
                            .alert("Notification", isPresented: $showAlertIcon, actions: {
                                Text("Project Is Now Saved")
                            })
                        }
                    }
                }
                .sheet(isPresented: $showImagePicker, content: {
                    ImagePicker(image: $selectedImage)
                })
            }
        } .background(backgroundGradient)
    }
    }

struct DailyReportSetup_Preview: PreviewProvider {
    static var previews: some View {
        DailyReportSetup(viewmodel: DailyViewModel(projects: devPreview.mockProjects), siteActivity: "Drilled 4 piles, 400 Linear ft, cleaned up spoil and cutoff Piles.", materialDelivered: "27 ton cement delivered", delayEncountered: " 2hr GC delay", conversation: "Conversation with Leroy Smith with Reeves & Young. Notified to relocate MC-28 for foundation contractors.")
    }
}

struct ChangeFrameSize: ViewModifier {
    func body(content: Content) -> some View {
        content
        
            .frame(width: 370, height: 80, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.systemGray2)))
            .background(.ultraThickMaterial).opacity(0.8)
            .foregroundColor(Color.black)
            .cornerRadius(20)
            .padding(.horizontal, 30)
            .shadow(radius: 5, x:5, y: 10)
    }
}

    struct fontModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(.vertical, 10)
                .padding(.horizontal, 5)
                .padding(.leading, 2)
                .foregroundColor(Color.white)
                .font(.headline)
            
        }
    }

struct TextFieldClearButton: ViewModifier {
    @Binding var nextText: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !nextText.isEmpty {
                Button(action: {self.nextText = ""}, label: {
                    Image(systemName: "delete.left.fill")
                        .font(.system(size: 18))
                        .foregroundColor(Color.gray)
                })
            }
        }
    }
}


