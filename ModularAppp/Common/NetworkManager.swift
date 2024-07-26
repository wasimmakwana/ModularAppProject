//
//
//  RemoteDataManager.swift
//  ModularApp
//
//  Created by Wasim on 25/07/24.
//
import Foundation

protocol RemoteDataManagerProtocol {
    func fetchUniversities(completion: @escaping (Result<[University], Error>) -> Void)
}

class RemoteDataManager: RemoteDataManagerProtocol {
    func fetchUniversities(completion: @escaping (Result<[University], Error>) -> Void) {
        let urlString = "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }

            // Print raw response for debugging
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw response: \(rawResponse)")
            }

            do {
                let decoder = JSONDecoder()
                let universities = try decoder.decode([University].self, from: data)
                completion(.success(universities))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
