//
//  LeaguesPresenterProtocol.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 13/05/2026.
//

import Foundation

protocol LeaguesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfLeagues() -> Int
    func league(at index: Int) -> League
    func didSelectLeague(at index: Int)
}
