//
//  LeagueDetailsViewProtocol.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 13/05/2026.
//

import Foundation

protocol LeagueDetailsViewProtocol: AnyObject {
    func reloadData()
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
    func updateFavoriteButton(isFavorite: Bool)
    func navigateToTeamDetails(team: Team)
}
