//
//  UberAppApp.swift
//  UberApp
//
//  Created by Agata Menes on 02/03/2023.
//

import SwiftUI

@main
struct UberAppApp: App {
    
    @StateObject var locationViewModel = LocationSearchViewModel() //we use single instance because only one instance contains location
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
