//
//  DrillLogSetup.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

struct DrillLogSetup: View {
    @ObservedObject var viewmodel: DrillingViewModel
    @Environment (\.dismiss) var dismiss
    
    @State var pilenumber: Int?
    @State var date = Date()
    @State var pileTypesArray = "Type A"
    @State var casingStickup = "1 ft"
    @State var actualBondLength = "20 ft"
    @State var driller = String()
    @State var totaldrilldepth: Int?
    
    var casingStickupArray: Array = ["0 ft", "1 ft", "2 ft", "3 ft", "4 ft", "5 ft"]
    @State var texteditor = String()
    @State var imageUI = UIImage()
    @State var showSheet: Bool = false
    
    @State var soilselected: Bool = false
    @State var inputImage: UIImage?
    @State var showImagePicker: Bool = false
    @State var showAlertIcon3: Bool = false
    @State var backgroundGradient =  RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1006665184, green: 0.007843137719, blue: 0.7041791803, alpha: 1)).opacity(0.8),Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(0.9), Color(#colorLiteral(red: 0.07443883983, green: 0.007843137719, blue: 0.4499540527, alpha: 1)).opacity(0.9)]), center: .bottomTrailing, startRadius: 4, endRadius: 400)
    
    @State var soilGeology1: SoilCondition = .na
    @State var soilGeology2: SoilCondition = .na
    @State var soilGeology3: SoilCondition = .na
    @State var soilGeology4: SoilCondition = .na
    @State var soilCondition2 = String()
    @State var soilCondition3 = String()
    @State var soilCOndition4 = String()
    @State var stepperValue1 = 0
    @State var stepperValue2 = 0
    @State var stepperValue3 = 0
    @State var stepperValue4 = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Drilling Log")
                            .foregroundColor(Color.white)
                            .font(.largeTitle.bold())
                            .padding(.top)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                        
                        HStack(spacing: 5) {
                            TextField("Enter Pile Number", value: $pilenumber, format: .number)
                                .textFieldStyle(GradientTextFieldBackground(systemImageString: "target"))
                                .padding(.vertical, 10)

                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 5) {
                                DatePicker("Select a Date ->", selection: $date, displayedComponents: .date)
                                    .padding(.horizontal, 20)
                                    .foregroundColor(Color.blue)
                                    .fontWeight(.black)
                            }
                            Text("Select Pile Type")
                                .padding(.horizontal, 20)
                                .padding(.leading, 1)
                                .font(.headline)
                                .foregroundStyle(Color.white)
                            
                            
                            Picker("Select Pile Type", selection: $pileTypesArray) {
                                ForEach(pileArrayCollections.pileType, id: \.self) {piletype in
                                    Text(piletype)}
                            }
                            
                            .pickerStyle(.segmented)
                            .padding()
                            
                            Text("Select Casing Stickup")
                                .padding(.horizontal, 20)
                                .foregroundColor(Color.white)
                                .fontWeight(.bold)
                            
                            Picker("Select Casing Stickup", selection: $casingStickup, content: {
                                ForEach(pileArrayCollections.casingStickup, id: \.self) { casings in
                                    Text(casings)
                                }
                            })
                            .padding()
                        }
                        
                        .pickerStyle(.segmented)
                      
                        Text("Actual Bond Length")
                            .padding(.horizontal, 20)
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                        
                        Picker("Select Bond Length", selection: $actualBondLength) {
                            ForEach(pileArrayCollections.bondZoneLength, id: \.self) {bonds in
                                Text(bonds)}
                        }
                        
                        .padding()
                        .pickerStyle(.segmented)
                      
                        
                        HStack(spacing: 5) {
                            TextField("Enter Driller Name", text: $driller)
                                .textFieldStyle(GradientTextFieldBackground(systemImageString: "person.circle.fill"))
                                .padding(.vertical, 5)
                        }
                        
                        // MARK: Need to correct .drillerName
                        HStack(spacing: 5) {
                            TextField("Total Drill Depth FT", value: $totaldrilldepth, format: .number)
                                .textFieldStyle(GradientTextFieldBackground(systemImageString: "ruler.fill"))
                                .padding(.vertical, 5)
                            
                        }
                        // MARK: Drill Depth, bond length, casing stick up, pile number
                        
                        VStack(spacing: 10) {
                            Button { self.showImagePicker = true
                                //   print("Show Image Picker")
                            } label: {
                                HStack(spacing: 0) {
                                    GradientIconButton(icon: "camera.fill")
                                        .padding(.horizontal, 10)
                                    Text("Insert Photos")
                                        .foregroundColor(Color.white)
                                        .font(.subheadline)
                                        .frame(width: 200, height: 55)
                                    // MARK: Note the frame dimension must be set at this width for it to not expand the entire view
                                    
                                    if let inputImage = inputImage {
                                        Image(uiImage: inputImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50, alignment: .center)
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                            .padding(.horizontal, 10)
                                    }
                                }
                                
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white.opacity(0.6), lineWidth: 1))
                                
                            }
                            .padding(.horizontal, 30)
                            .padding(.top)
                            
                            // MARK: UIImage from PhotoPicker
                            
//                            Toggle("Soil Selection", isOn: $soilselected)
//                                .toggleStyle(SwitchToggleStyle(tint: .red))
//                                .padding(.horizontal, 35)
//                                .padding(.vertical, 5)
//                                .font(.headline)
//                                .foregroundColor(Color.white)
//
//                            if soilselected == true {
                                VStack(alignment: .leading) {
                                    Stepper("Enter Soil Depth 1", value: $stepperValue1, in: 0...50)
                                        .padding(.horizontal, 10)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.bold)
                                        .padding(.vertical, 5)
                                    
                                    Text("DL 1 (0 - \(stepperValue1)) ft")
                                        .padding(.horizontal,110)
                                        .foregroundColor(Color.blue)
                                        .fontWeight(.bold)
                                        .font(.title2).lineLimit(1)
                                        .padding(.vertical, 10)
                                    
                                    HStack(spacing: 80) {
                                        Text("Select Soil Profile 1")
                                            .lineLimit(1)
                                            .foregroundColor(Color.white)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .padding(.horizontal, 10)
                                        
                                        Picker("Select Soil Profile 1:", selection: $soilGeology1) {
                                            ForEach(SoilCondition.allCases, id: \.self) { soils in
                                                Text(soils.soilarray)
                                            }
                                            
                                            .pickerStyle(.menu)
                                            .foregroundColor(Color.blue)
                                        }
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(20)
                                    }
                                    Stepper("Enter Soil Depth 2", value: $stepperValue2, in: 10...60)
                                        .padding(.horizontal, 10)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.bold)
                                        .padding(.vertical, 5)
                                    
                                    Text("DL 2 (\(stepperValue1) - \(stepperValue2)) ft")
                                        .padding(.horizontal,110)
                                        .foregroundColor(Color.blue)
                                        .fontWeight(.bold)
                                        .font(.title2).lineLimit(1)
                                        .padding(.vertical, 10)
                                    
                                    HStack(spacing: 80) {
                                        Text("Select Soil Profile 2")
                                            .lineLimit(1)
                                            .foregroundColor(Color.white)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .padding(.horizontal, 10)
                                        
                                        Picker("Select Soil Profile 2:", selection: $soilGeology2) {
                                            ForEach(SoilCondition.allCases, id: \.self) { soils in
                                                Text(soils.soilarray)
                                            }
                                            .pickerStyle(.menu)
                                            .foregroundColor(Color.blue)
                                        }
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(20)
                                    }
                                    Stepper("Enter Soil Depth 3", value: $stepperValue3, in: 30...100)
                                        .padding(.horizontal, 10)
                                        .foregroundColor(Color.white)
                                        .fontWeight(.bold)
                                        .padding(.vertical, 5)
                                    
                                    Text("DL 3 (\(stepperValue2) - \(stepperValue3)) ft")
                                        .padding(.horizontal,110)
                                        .foregroundColor(Color.blue)
                                        .fontWeight(.bold)
                                        .font(.title2).lineLimit(1)
                                        .padding(.vertical, 10)
                                    
                                    HStack(spacing: 80) {
                                        Text("Select Soil Profile 3")
                                            .lineLimit(2)
                                            .foregroundColor(Color.white)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .padding(.horizontal, 10)
                                        
                                        
                                        Picker("Select Soil Profile 3:", selection: $soilGeology3) {
                                            ForEach(SoilCondition.allCases, id: \.self) { soils in
                                                Text(soils.soilarray)
                                            }
                                            .pickerStyle(.menu)
                                            .foregroundColor(Color.white)
                                        }
                                        .background(.ultraThinMaterial)
                                        .cornerRadius(20)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Stepper("Enter Rock Depth 4", value: $stepperValue4, in: 40...100)
                                            .padding(.horizontal, 10)
                                            .foregroundColor(Color.white)
                                            .fontWeight(.bold)
                                            .padding(.vertical, 5)
                                        
                                        Text("DL 4 (\(stepperValue3) - \(stepperValue4)) ft")
                                            .padding(.horizontal, 110)
                                            .foregroundColor(Color.blue)
                                            .fontWeight(.bold)
                                            .font(.title2).lineLimit(1)
                                            .padding(.vertical, 2)
                                        
                                        HStack(spacing: 80) {
                                            Text("Select Soil Profile 4")
                                                .foregroundColor(Color.white)
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .padding(.horizontal, 10)
                                                .lineLimit(2)
                                            
                                            Picker("Select Soil Profile 4:", selection: $soilGeology4) {
                                                ForEach(SoilCondition.allCases, id: \.self) { soils in
                                                    Text(soils.soilarray)
                                                }
                                                .pickerStyle(.menu)
                                                .foregroundColor(Color.blue)
                                            }
                                            .background(.ultraThinMaterial)
                                            .cornerRadius(20)
                                        }
                                        .padding(.vertical, 20)
                                                }
                                  
                                            
                                    // MARK: Add soil condition log here
                                    
                                    VStack(alignment: .leading, spacing: 0) {
                                        HStack(spacing: 10) {
                                            Button(action: {
                                                viewmodel.createDrillLog(pileID: pilenumber ?? 0, drillDate: date, pileType: pileTypesArray, casingStickup: casingStickup, actualBondLength: actualBondLength, totalDrillDepth: totaldrilldepth ?? 0, drillerName: driller, soilDepth1: stepperValue1, soilDepth2: stepperValue2, soilDepth3: stepperValue3, soilDepth4: stepperValue4, soilProfile1: soilGeology1.rawValue, soilProfile2: soilGeology2.rawValue, soilProfile3: soilGeology3.rawValue, soilProfile4: soilGeology4.rawValue, image: inputImage)
                                                
                                                showAlertIcon3 = true
                                            }, label: {
                                                Text("Submit")
                                                    .font(.subheadline)
                                                    .foregroundStyle(Color.white)
                                                    .fontWeight(.bold)
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
                                        
                                            .alert("Notification", isPresented: $showAlertIcon3, actions: {
                                                Text("Drilling Log is now saved!")
                                                    .font(.title2)
                                                    .foregroundStyle(Color.black)
                                                    .fontWeight(.semibold)
                                        })
                                            .padding(.horizontal, 10)
                                        }
                                        
                                    }
                                }
                           // }
                        }
                    }
                    .padding()
                }
                .sheet(isPresented: $showImagePicker, content: {
                    ImagePicker(image: $inputImage)
                }
                )}
            .background(backgroundGradient)
            .navigationBarBackButtonHidden(true)
        }
    }
    }

struct DrillLogSetup_Preview: PreviewProvider {
    static var previews: some View {
        DrillLogSetup(viewmodel: DrillingViewModel(projects: devPreview.mockProjects))
    }
}
