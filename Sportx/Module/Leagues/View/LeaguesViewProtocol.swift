//
//  LeaguesViewProtocol.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 13/05/2026.
//

import Foundation

protocol LeaguesViewProtocol: AnyObject {
    func reloadData()
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
    func navigateToLeagueDetails(league: League, sportName: String)
}
