//
//  ProjectSetup.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

struct ProjectSetup: View {
    @State var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showSheet = false
    @State private var postImage: Image?
    @State private var location = ""
    @State private var client = ""
    @State private var superIntendent = ""
    @State private var projectManager = ""
    @State private var projectNumber = ""
    @State private var projectName = ""
    @State private var showAlertIcon = false
    @State private var projectDescription = ""
    
    @StateObject var viewModel = ProjectViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var isAnimating = false
    
    @State var backgroundGradient =  AngularGradient(gradient: Gradient(colors:[Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1))]), center: .center, angle: .degrees(70))
    
    
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()
            VStack(spacing: 20) {
                
                Text("Project Setup")
                    .fontWeight(.bold)
                    .font(.title3)
                    .padding(.horizontal)
                
                HStack(spacing: 5) {
                    
                    TextField("Enter Project Name", text: $projectName)
                        .modifier(ThreadsTextFieldModifier())
                        .frame(width: 400)
                }
                
                HStack(spacing: 5) {
                    TextField("Project Number", text: $projectNumber)
                        .modifier(ThreadsTextFieldModifier())
                        .frame(width: 400)
                        .keyboardType(.asciiCapableNumberPad)
                }
                
                HStack(spacing: 5) {
                    TextField("Project Manager", text: $projectManager)
                        .modifier(ThreadsTextFieldModifier())
                        .frame(width: 400)
                }
                
                HStack(spacing: 5) {
                    TextField("Superintendent", text: $superIntendent)
                        .modifier(ThreadsTextFieldModifier())
                        .frame(width: 400)
                    
                }
                
                HStack(spacing: 5) {
                    TextField("Enter Client", text: $client)
                        .modifier(ThreadsTextFieldModifier())
                        .frame(width: 400)
                    
                }
                
                HStack(spacing: 5) {
                    TextField("City, State", text: $location)
                        .modifier(ThreadsTextFieldModifier())
                        .frame(width: 400)
                }
                
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Enter Jobsite Description")
                        .foregroundColor(Color.black).opacity(0.9)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 60)
                    
                    HStack(spacing: 5) {
                        TextEditor(text: $projectDescription)
                            .frame(width: 360, height: 80)
                            .cornerRadius(20)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 60)
                            .shadow(radius: 5, x: 5, y: 10)
                            .padding(.vertical, 15)
                    }
                    VStack(spacing: 10) {
                        Button { self.showImagePicker = true
                            //   print("Show Image Picker")
                        } label: {
                            HStack(spacing: 0) {
                                GradientIconButton(icon: "camera.fill")
                                    .padding(.horizontal, 15)
                                
                                Text("Insert Photos")
                                    .foregroundColor(Color.black)
                                    .font(.subheadline)
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
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1))
                            
                        }
                        .padding(.horizontal, 40)
                        
                        
                        HStack {
                            Button(action: {
                                viewModel.createMainProjects(clientName: client, location: location, projectManager: projectManager, projectNumber: projectNumber, projectName: projectName, projectDescription: projectDescription, superintendent: superIntendent, image: selectedImage)
                                
                                client = ""
                                location = ""
                                projectManager = ""
                                projectNumber = ""
                                projectName = ""
                                projectDescription = ""
                                superIntendent = ""
                                
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
                            .animation(.linear(duration: 0.50).delay(2), value: isAnimating)
                            .onAppear {
                                isAnimating.toggle()
                            }
                            
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
                    .padding(.horizontal, 20
                    )
                    .alert("Notification", isPresented: $showAlertIcon, actions: {
                        Text("Project Is Now Saved")
                    })
                    
                }
                
            }
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(image: $selectedImage)
            })
            
        }
        
    }
}

struct ProjectSetup_Preview: PreviewProvider {
    static var previews: some View {
        ProjectSetup()
    }
}


