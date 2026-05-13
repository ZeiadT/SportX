//
//  FavouritesPresenterProtocol.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 13/05/2026.
//

import Foundation

protocol FavouritesPresenterProtocol: AnyObject {
    func viewWillAppear()
    func numberOfLeagues() -> Int
    func league(at index: Int) -> LeagueDBEntity
    func didSelectLeague(at index: Int)
    func deleteLeague(at index: Int)
}
