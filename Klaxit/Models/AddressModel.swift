//
//  AddressModel.swift
//  Klaxit
//
//  Created by Sabri Belguerma on 08/01/2023.
//

import Foundation

struct AddressModel: Codable {
    var id: String
    var name: String
    var postcode: String
    var city: String
    var label: String
}
