//
//  NetworkManager.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 23.09.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://www.boredapi.com/api/activity/"
    
    private init() {}
    
    func getActivity(completed: @escaping (Result<Activity, BAError>) -> Void) {
        guard let url = URL(string: baseURL) else {
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