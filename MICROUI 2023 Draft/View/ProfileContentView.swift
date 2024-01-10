//
//  ProfileContentView.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import Foundation
import SwiftUI

struct ProfileContentView: View {
    @StateObject var viewmodel = ProjectViewModel()
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                LazyVStack {
                    ForEach(viewmodel.projectVM, id: \.self) { projects in
                        ProjectCell(projects: projects)
                    }
                }
            }
        }
    }
}

struct ProfileContentView_Preview: PreviewProvider {
    static var previews: some View {
        ProfileContentView()
    }
}
