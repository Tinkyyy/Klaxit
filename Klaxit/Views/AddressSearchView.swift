//
//  AddressSearchView.swift
//  Klaxit
//
//  Created by Sabri Belguerma on 08/01/2023.
//

import SwiftUI

struct AddressSearchView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var addressViewModel: AddressViewModel

    @State private var search: String = ""
    @State private var isSearching: Bool = false

    var execute: (() -> ())

    var body: some View {
        List {
            Section {
                HStack {
                    TextField("Search Address", text: $search)
                        .onChange(of: self.search, perform: { newValue in
                            self.isSearching = true
                            DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: {
                                self.isSearching = false
                                self.addressViewModel.fetchAddressesPrediction(
                                    search: self.search,
                                    limit: 10
                                )
                            })
                        }).accessibilityLabel("Champ de recherche d'adresse")
                        .accessibilityIdentifier("addAddressInputField")
                    if isSearching {
                        Image(systemName: "clock")
                            .foregroundColor(Color.gray)
                    }
                }
            }
            Section {
                ForEach(addressViewModel.addressesPrediction, id: \.id) { prediction in
                    Text(prediction.label)
                        .foregroundColor(.primary)
                        .onTapGesture {
                            self.addressViewModel.setCurrentAddress(address: prediction)
                            self.addressViewModel.storeCurrentAddress()
                            self.execute()
                            self.dismiss()
                        }
                }
            }.listStyle(GroupedListStyle())
        }
    }
}

