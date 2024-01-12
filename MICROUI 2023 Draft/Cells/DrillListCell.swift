//
//  DrillListCell.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/12/24.
//

import Foundation
import SwiftUI

struct DrillListCell: View {
    var drillings: DrillingModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(drillings.pileID ?? "")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("Date: \(drillings.drilldate)")
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text("Drill Depth: \(drillings.totaldrilldepth)")
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text("Pile: \(drillings.pileType)")
                .font(.subheadline)
                .fontWeight(.medium)
            
        }
        .modifier(lighttabViewModifier())
    }
}

