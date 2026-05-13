//
//  SportsPresenterProtocol.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 13/05/2026.
//

import Foundation

protocol SportsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfSports() -> Int
    func sport(at index: Int) -> Sport
    func didSelectSport(at index: Int)
}
