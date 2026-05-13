//
//  API.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 7/5/2026.
//

import Foundation
enum API {
    static let baseURL = "https://apiv2.allsportsapi.com"
    static var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "ALL_SPORTS_API_KEY") as? String,
              !key.isEmpty else {
            fatalError("Missing ALL_SPORTS_API_KEY. Add it to an .xcconfig file or Xcode build setting before running the app.")
        }
        return key
    }
}
