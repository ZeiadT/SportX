//
//  LeagueDetailsPresenterProtocol.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 13/05/2026.
//

import Foundation

protocol LeagueDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()

    func numberOfUpcomingEvents() -> Int
    func upcomingEvent(at index: Int) -> Fixture

    func numberOfLatestEvents() -> Int
    func latestEvent(at index: Int) -> Fixture

    func numberOfTeams() -> Int
    func team(at index: Int) -> Team
    func didSelectTeam(at index: Int)

    func isFavorite() -> Bool
    func toggleFavorite() -> Bool
}
