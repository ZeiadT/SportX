//
//  LeagueDetailsPresenter.swift
//  SportX
//
//  Created by Zeiad Mohammed on 12/5/2026.
//

import Foundation

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {

    weak var view: LeagueDetailsViewProtocol?

    private let league: League
    private let sportName: String

    private var upcomingEvents: [Fixture] = []
    private var latestEvents: [Fixture] = []
    private var teams: [Team] = []

    init(view: LeagueDetailsViewProtocol, league: League, sportName: String) {
        self.view = view
        self.league = league
        self.sportName = sportName
    }

    func viewDidLoad() {
        view?.updateFavoriteButton(isFavorite: isFavorite())
        fetchData()
    }

    func numberOfUpcomingEvents() -> Int {
        return upcomingEvents.count
    }

    func upcomingEvent(at index: Int) -> Fixture {
        return upcomingEvents[index]
    }

    func numberOfLatestEvents() -> Int {
        return latestEvents.count
    }

    func latestEvent(at index: Int) -> Fixture {
        return latestEvents[index]
    }

    func numberOfTeams() -> Int {
        return teams.count
    }

    func team(at index: Int) -> Team {
        return teams[index]
    }

    func didSelectTeam(at index: Int) {
        let team = teams[index]
        view?.navigateToTeamDetails(team: team)
    }

    func isFavorite() -> Bool {
        guard let leagueKey = league.league_key else { return false }
        return CoreDataManager.shared.isFavorite(id: String(leagueKey))
    }

    func toggleFavorite() -> Bool {
        guard let leagueKey = league.league_key else { return false }
        return CoreDataManager.shared.toggleFavorite(
            id: String(leagueKey),
            name: league.league_name ?? "",
            badgeURL: league.league_logo ?? "",
            sportName: sportName
        )
    }

    private func fetchData() {
        guard let leagueId = league.league_key else { return }

        view?.showLoading()

        Task { @MainActor in
            do {
                async let fixturesTask = NetworkManager.shared.fetchFixtures(sport: sportName, leagueId: leagueId)
                async let teamsTask = NetworkManager.shared.fetchTeams(sport: sportName, leagueId: leagueId)

                let allFixtures = try await fixturesTask
                self.teams = try await teamsTask
                self.splitFixtures(allFixtures)
                self.view?.reloadData()
            } catch {
                self.view?.showError(error.localizedDescription)
            }
            self.view?.hideLoading()
        }
    }

    private func splitFixtures(_ fixtures: [Fixture]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let today = dateFormatter.string(from: Date())

        upcomingEvents = []
        latestEvents = []

        for fixture in fixtures {
            guard let eventDate = fixture.event_date else { continue }

            if eventDate >= today {
                let result = fixture.event_final_result
                if result == nil || result == "" || result == "-" {
                    upcomingEvents.append(fixture)
                } else {
                    latestEvents.append(fixture)
                }
            } else {
                latestEvents.append(fixture)
            }
        }

        upcomingEvents.sort { ($0.event_date ?? "") < ($1.event_date ?? "") }
        latestEvents.sort { ($0.event_date ?? "") > ($1.event_date ?? "") }
    }
}
