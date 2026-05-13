//
//  FetchLeagues.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 7/5/2026.
//

import Foundation
import Alamofire

extension NetworkManager {

    func fetchLeagues(
        sport: String
    ) async throws -> [League] {

        let response = try await request(
            endpoint: .leagues(sport: sport),
            model: APIResponse<[League]>.self
        )

        return response.result ?? []
    }
}
