//
//  ContentView.swift
//  Klaxit
//
//  Created by Sabri Belguerma on 07/01/2023.
//

import SwiftUI

struct HomeView: View {
    @Environment (\.colorScheme) public var colorScheme: ColorScheme

    @EnvironmentObject var addressViewModel: AddressViewModel
    @EnvironmentObject var locationViewModel: LocationViewModel

    @State private var displaySearchView = false
    @State private var displayLocalizedAddress = false
    
    var body: some View {
        VStack {
            Text("Mon adresse")
                .bold()
                .font(.title)
                .accessibilityLabel("Titre de l'interface")
            Spacer()
            if let currentAddress = addressViewModel.currentAddress {
                Text(currentAddress.label)
                    .multilineTextAlignment(.center)
                    .accessibilityLabel("Addresse sauvegardée")
            }
            Spacer()
            HStack {
                Button {
                    self.displaySearchView.toggle()
                } label: {
                    Text("Ajouter")
                        .font(.title2)
                        .bold()
                        .frame(width: UIScreen.main.bounds.width / 2.5)
                }.buttonStyle(
                    KlaxitButtonStyle(
                        backgroundColor: Color.color(for: colorScheme)
                    )
                ).accessibilityIdentifier("addAddressButton")
                    .accessibilityLabel("Button d'ajout d'addresse")
                Spacer()
                Button {
                    self.locationViewModel.requestPermission()
                    self.displayLocalizedAddress = true
                    self.setLocalizedAddress()
                } label: {
                    Text("Localiser")
                        .font(.title2)
                        .bold()
                        .frame(width: UIScreen.main.bounds.width / 2.5)
                }.buttonStyle(
                    KlaxitButtonStyle(
                        backgroundColor: Color.color(for: colorScheme)
                    )
                ).accessibilityIdentifier("askAndLocalizationButton")
                    .accessibilityLabel("Button de demande et de récuperation de la localisation")
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width)
        }
        .padding()
        .onAppear { self.getStoredAddress() }
        .onReceive(locationViewModel.$authorizationStatus) { _ in self.setLocalizedAddress() }
        .sheet(isPresented: $displaySearchView) {
            AddressSearchView {
                self.displayLocalizedAddress = false
            }
        }
    }
    
    func setLocalizedAddress() {
        if displayLocalizedAddress {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if(locationViewModel.authorizationStatus == .authorizedWhenInUse){
                    if let placemark = self.locationViewModel.currentPlacemark {
                        self.addressViewModel.fetchCurrentAddress(placemark: placemark)
                    }
                }
            }
        }
    }
    
    func getStoredAddress() {
        if let data = UserDefaults.standard.value(forKey: "address") as? Data {
            if let storedAddress = try? PropertyListDecoder().decode(AddressModel.self, from: data) {
                self.addressViewModel.setCurrentAddress(address: storedAddress)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
