//
//  TeamDetailsPresenter.swift
//  SportX
//
//  Created by Zeiad Mohammed on 12/5/2026.
//

import Foundation

class TeamDetailsPresenter: TeamDetailsPresenterProtocol {

    weak var view: TeamDetailsViewProtocol?
    private let team: Team
    private var sections: [(title: String, players: [Player])] = []

    init(view: TeamDetailsViewProtocol, team: Team) {
        self.view = view
        self.team = team
    }

    func viewDidLoad() {
        groupPlayers()
        view?.displayTeamInfo(
            name: team.team_name ?? "Unknown",
            logoURL: team.team_logo,
            coach: coachName()
        )
        view?.reloadData()
    }

    func teamName() -> String {
        return team.team_name ?? "Unknown"
    }

    func teamLogo() -> String? {
        return team.team_logo
    }

    func coachName() -> String {
        return team.coaches?.first?.coach_name ?? "N/A"
    }

    func numberOfSections() -> Int {
        return sections.count
    }

    func sectionTitle(for section: Int) -> String {
        return sections[section].title
    }

    func numberOfPlayers(in section: Int) -> Int {
        return sections[section].players.count
    }

    func player(at indexPath: IndexPath) -> Player {
        return sections[indexPath.section].players[indexPath.row]
    }

    private func groupPlayers() {
        guard let players = team.players else {
            sections = []
            return
        }

        let positionOrder = ["Goalkeepers", "Defenders", "Midfielders", "Forwards"]
        var grouped: [String: [Player]] = [:]

        for player in players {
            let type = player.player_type ?? "Other"
            grouped[type, default: []].append(player)
        }

        sections = []
        for position in positionOrder {
            if let playersInPosition = grouped[position], !playersInPosition.isEmpty {
                sections.append((title: position, players: playersInPosition))
                grouped.removeValue(forKey: position)
            }
        }

        for (title, players) in grouped.sorted(by: { $0.key < $1.key }) {
            if !players.isEmpty {
                sections.append((title: title, players: players))
            }
        }
    }
}
