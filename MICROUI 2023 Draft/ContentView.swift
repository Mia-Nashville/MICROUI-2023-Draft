//
//  ContentView.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewmodel = ContentViewModel()
    
    var body: some View {
        Group {
            if viewmodel.userSession != nil {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
