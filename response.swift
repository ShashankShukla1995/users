//
//  response.swift
//  Posts
//
//  Created by Shashank Shukla on 02/05/24.
//

import Foundation
// MARK: - Response
struct Response: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
