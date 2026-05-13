//
//  TeamDetailsPresenterProtocol.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 13/05/2026.
//

import Foundation

protocol TeamDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()

    func teamName() -> String
    func teamLogo() -> String?
    func coachName() -> String

    func numberOfSections() -> Int
    func sectionTitle(for section: Int) -> String
    func numberOfPlayers(in section: Int) -> Int
    func player(at indexPath: IndexPath) -> Player
}
