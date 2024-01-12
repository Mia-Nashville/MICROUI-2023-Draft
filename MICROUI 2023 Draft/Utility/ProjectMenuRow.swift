//
//  ProjectMenuRow.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/12/24.
//

import Foundation
import SwiftUI

struct ProjectMenuRow: View {
    @AppStorage("isDarkMode") private var isDarkmedisOn = false
    var title: String = ""
    var leftIcon: String = ""
    var rightIcon: String = ""
    
    var body: some View {
        HStack(spacing: 7) {
            GradientIconButton(icon: leftIcon)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            Spacer()
            
            Image(systemName: rightIcon)
                .fontWeight(.semibold)
                .font(.system(size: 30))
                .opacity(0.9)
                .padding()
                .foregroundColor(isDarkmedisOn ? Color.white: Color(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1)))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

