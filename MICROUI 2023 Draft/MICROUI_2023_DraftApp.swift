//
//  MICROUI_2023_DraftApp.swift
//  MICROUI 2023 Draft
//
//  Created by Satoshi Mitsumori on 1/10/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct MICROUI_2023_DraftApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
                ContentView()
        }
    }
}
