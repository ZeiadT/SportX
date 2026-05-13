//
//  TeamDetailsViewProtocol.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 13/05/2026.
//

import Foundation

protocol TeamDetailsViewProtocol: AnyObject {
    func reloadData()
    func displayTeamInfo(name: String, logoURL: String?, coach: String)
}
