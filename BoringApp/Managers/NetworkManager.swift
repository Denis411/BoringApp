//
//  NetworkManager.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 23.09.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://www.boredapi.com/api/activity"
    private var requestURL: String?
    
    private init() {}
    
    public func getActivity(with filter: Filter?, completed: @escaping (Result<Activity, BAError>) -> Void) {
        if let filter = filter {
            print(filter)
            var queryParameters: String = "?"
            
            if let types = filter.selectedTypes {
                for type in types {
                    queryParameters += "type=" + type + "&"
                }
                queryParameters = String(queryParameters.dropLast())
            }
            
            if let participants = filter.participants {
                queryParameters += "&" + "participants=" + String(participants)
            }
            
            if let price = filter.price {
                queryParameters += "&"
                switch price {
                case .free(price: let price):
                    queryParameters += "price=" + String(price)
                case .cheap(minimalPrice: let minimalPrice, maximumPrice: let maximumPrice):
                    queryParameters += "minprice=" + String(minimalPrice) + "&" + "maxprice=" + String(maximumPrice)
                case .average(minimalPrice: let minimalPrice, maximumPrice: let maximumPrice):
                    queryParameters += "minprice=" + String(minimalPrice) + "&" + "maxprice=" + String(maximumPrice)
                case .pricey(minimalPrice: let minimalPrice, maximumPrice: let maximumPrice):
                    queryParameters += "minprice=" + String(minimalPrice) + "&" + "maxprice=" + String(maximumPrice)
                }
            }
            
            requestURL = baseURL + queryParameters
            print(requestURL!)
        }
        
        guard let url = URL(string: requestURL ?? baseURL) else {
            completed(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let activity = try decoder.decode(Activity.self, from: data)
                completed(.success(activity))
            } catch {
                completed(.failure(.noActivity))
            }
        }
        
        task.resume()
    }
}
