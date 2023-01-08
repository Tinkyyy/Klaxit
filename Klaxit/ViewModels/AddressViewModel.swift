//
//  AddressViewModel.swift
//  Klaxit
//
//  Created by Sabri Belguerma on 08/01/2023.
//

import SwiftUI
import CoreLocation

public class AddressViewModel: ObservableObject {
    @StateObject private var locationViewModel: LocationViewModel = LocationViewModel()
    @Published var addressesPrediction: [AddressModel] = []
    @Published var currentAddress: AddressModel?
    
    private var addressProvider: AddressProvider = AddressProvider()
    
    public func fetchAddressesPrediction(search: String, limit: Int = 5) -> Void {
        self.addressProvider.fetch(search: search, limit: limit, { [weak self] result in
            switch result {
            case .success(let addresses):
                self?.addressesPrediction = addresses
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    public func fetchCurrentAddress(placemark: CLPlacemark) -> Void {
        self.addressProvider.fetch(placemark: placemark, { [weak self] result in
            switch result {
            case .success(let address):
                self?.currentAddress = address
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }

    func setCurrentAddress(address: AddressModel) {
        self.addressesPrediction = []
        self.currentAddress = address
    }
    
    func storeCurrentAddress() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.currentAddress), forKey:"address")
    }
}
