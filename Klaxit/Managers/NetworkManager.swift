//
//  NetworkManager.swift
//  Klaxit
//
//  Created by Sabri Belguerma on 08/01/2023.
//

import SwiftUI

enum NetworkError: Error {
    case placemark
    case coordinate
    case request
    case decodeJson
}

class NetworkManager: NSObject {
    static let geoAPIUrl: String = Bundle.main.infoDictionary!["GEO_API_URL"] as! String

    struct API {
        static func search(for search: String, limit: Int) -> String {
            var stringURL: String = geoAPIUrl

            stringURL.append("/search/")
            stringURL.append("?q=\(search)&")
            stringURL.append("type=housenumber&")
            stringURL.append("limit=\(limit)")

            return stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
        
        static func reverse(lat: Double, lon: Double) -> String {
            var stringURL: String = geoAPIUrl

            stringURL.append("/reverse/")
            stringURL.append("?lon=\(lon)&")
            stringURL.append("lat=\(lat)&")
            stringURL.append("limit=1")
            
            return stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
    }
}
