//
//  AddressProvider.swift
//  Klaxit
//
//  Created by Sabri Belguerma on 08/01/2023.
//

import SwiftUI
import CoreLocation

class AddressProvider: ObservableObject {
    
    func fetch(placemark: CLPlacemark, _ completion: @escaping (Result<AddressModel, Error>) -> Void) {
        guard let coordinate = placemark.location?.coordinate else {
            completion(.failure(NetworkError.coordinate))
            return
        }
        
        guard let urlRequest = URL(string: NetworkManager.API.reverse(
            lat: coordinate.latitude, lon: coordinate.longitude)
        ) else {
            completion(.failure(NetworkError.request))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                        if let features = json["features"] as? [[String : Any]] {
                            for feature in features {
                                if let properties = feature["properties"] as? [String : Any] {
                                    let data = try JSONSerialization.data(withJSONObject: properties)
                                    
                                    if let address = try? JSONDecoder().decode(AddressModel.self, from: data)  {
                                        DispatchQueue.main.async {
                                            completion(.success(address))
                                        }
                                    }
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(.failure(NetworkError.decodeJson))
                                return
                            }
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.decodeJson))
                        return
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func fetch(search: String, limit: Int, _ completion: @escaping (Result<[AddressModel], Error>) -> Void) {
        guard let urlRequest = URL(string: NetworkManager.API.search(for: search, limit: limit)) else {
            completion(.failure(NetworkError.request))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.success([]))
                }
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                
                if let features = json["features"] as? [[String : Any]] {
                    var addresses: [AddressModel] = []
                    for feature in features {
                        guard let properties = feature["properties"] as? [String : Any] else {
                            break
                        }
                        let data = try JSONSerialization.data(withJSONObject: properties)
                        
                        guard let address = try? JSONDecoder().decode(AddressModel.self, from: data) else {
                            break
                        }
                        addresses.append(address)
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(addresses))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                        return
                    }
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.decodeJson))
                }
            }
        }
        dataTask.resume()
    }
}
