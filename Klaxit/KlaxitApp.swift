//
//  KlaxitApp.swift
//  Klaxit
//
//  Created by Sabri Belguerma on 07/01/2023.
//

import SwiftUI

@main
struct KlaxitApp: App {
    @StateObject var addressViewModel: AddressViewModel = AddressViewModel()
    @StateObject var locationViewModel: LocationViewModel = LocationViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(self.addressViewModel)
                .environmentObject(self.locationViewModel)
        }
    }
}
