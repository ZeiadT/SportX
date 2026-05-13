//
//  APIResponse.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 7/5/2026.
//

import Foundation
struct APIResponse<T: Decodable>: Decodable {

    let success: Int?
    let result: T?
}
