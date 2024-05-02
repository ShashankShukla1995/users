//
//  Manager.swift
//  Posts
//
//  Created by Shashank Shukla on 02/05/24.
//

import Foundation
class Manager: NSObject {
    static let shared = Manager()

    
    
    func getData(with page:Int, completed: @escaping (Result<[Response], NSError>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(page)") else {
            completed(.failure(NSError.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let _ = error {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([Response].self, from: data)
                completed(.success(users))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
