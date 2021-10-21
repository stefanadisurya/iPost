//
//  ConsumeAPI.swift
//  iPost
//
//  Created by Stefan Adisurya on 18/10/21.
//

import Foundation

struct Constants {
    static let userUrl = URL(string: "https://jsonplaceholder.typicode.com/users")
    static let postUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")
    static let albumUrl = URL(string: "https://jsonplaceholder.typicode.com/albums")
}

extension URLSession {
    
    enum CustomError: Error {
        case invalidUrl
        case invalidData
    }
    
    func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        let task = self.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func get(url: URL?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        let task = self.dataTask(with: url) { data, _, error in
            guard data != nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                if let data = data {
                    completion(.success(data))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
}
