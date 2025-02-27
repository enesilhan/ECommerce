//
//  NetworkManager.swift
//  ECommerce
//
//  Created by Enes İlhan on 27.02.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case networkError(Error)
}

protocol NetworkService {
    func fetchData<T: Decodable>(from url: String, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkManager: NetworkService {
    
    static let shared = NetworkManager()
    private init() {}

    func fetchData<T: Decodable>(from url: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
