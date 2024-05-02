//
//  Error.swift
//  Posts
//
//  Created by Shashank Shukla on 02/05/24.
//

import Foundation
enum NSError: String, Error {
    case invalidUrl = "Invalid Url"
    case invalidResponse = "Error in Response"
    case invalidData = "Error in Response Data"
}
