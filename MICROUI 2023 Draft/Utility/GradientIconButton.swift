//
//  GradientIconButton.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

struct GradientIconButton: View {
    var icon: String
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)), Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .mask(Image(systemName: icon).font(.system(size: 17)))
            .background(Color(#colorLiteral(red: 0.1019607843, green: 0.07058823529, blue: 0.2431372549, alpha: 0.6004759934)))
            .frame(width: 40, height: 40)
            .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(lineWidth: 2)
                .foregroundColor(Color.white)
                .blendMode(.overlay))
    }
}
