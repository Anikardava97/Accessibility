//
//  AccessibleNewsApp.swift
//  AccessibleNews
//
//  Created by Ani's Mac on 27.12.23.
//

import SwiftUI

@main
struct AccessibleNewsApp: App {
    @StateObject var viewModel = NewsViewModel()
    
    var body: some Scene {
        WindowGroup {
            NewsView()
                .environmentObject(viewModel)
        }
    }
}
