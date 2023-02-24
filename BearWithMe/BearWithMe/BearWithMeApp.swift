//
//  BearWithMeApp.swift
//  BearWithMe
//
//  Created by Adem Tsranchaliev on 21.02.23.
//

import SwiftUI
import FirebaseCore



@main
struct BearWithMeApp: App {
    @StateObject var dataManager: DataManager = DataManager()

    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(dataManager)
            }
        }
    }
}
