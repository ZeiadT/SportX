//
//  FavouritesViewProtocol.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 13/05/2026.
//

import Foundation

protocol FavouritesViewProtocol: AnyObject {
    func reloadData()
    func showOfflineAlert()
    func navigateToLeagueDetails(leagueId: Int, leagueName: String, leagueLogo: String, sportName: String)
    func showEmptyState(_ show: Bool)
}
