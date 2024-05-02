//
//  ViewModel.swift
//  Posts
//
//  Created by Shashank Shukla on 02/05/24.
//

import Foundation
final class ViewModel {
    
    var users: [Response] = []
    func getUsers(count:Int, completion: @escaping (Result<[Response], NSError>) -> Void) {
        Manager.shared.getData(with: count) { [weak self] response in
            switch (response) {
            case .success(let userData):
                self?.users.append(contentsOf: userData)
                completion(.success(self!.users))
            case .failure(let error):
                print(error)
            }
        }
    }
}
