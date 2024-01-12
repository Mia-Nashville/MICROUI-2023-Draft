//
//  DrillListView.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/12/24.
//

import Foundation
import SwiftUI

struct DrillListView: View {
    @ObservedObject var viewmodel: DrillingViewModel
    @Environment(\.dismiss) var dismiss

    var sortedDrillCategory: [DrillingModel] {
        viewmodel.drillingVM.sorted { $0.pileID ?? "" < $1.pileID ?? "" }
    }
  
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    ForEach(sortedDrillCategory.sorted(by: { $0.pileID ?? "" < $1.pileID ?? "" }), id: \.self) { drillings in
                        NavigationLink(destination: {
                            
                        }, label: {
                            DrillListCell(drillings: drillings)
                                
                            })
                        }
                    }
                  
                }
            }
        }
    }


