//
//  Team.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 7/5/2026.
//

import Foundation
struct Team: Decodable {

    let team_key: Int?
    let team_name: String?
    let team_logo: String?

    let players: [Player]?
    let coaches: [Coach]?
}
