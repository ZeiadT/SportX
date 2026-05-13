//
//  SportsPresenter.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 11/5/2026.
//

import Foundation

class SportsPresenter: SportsPresenterProtocol {

    weak var view: SportsViewProtocol?
    private var sports: [Sport] = []

    private static let availableSports: [Sport] = [
        Sport(sport_key: 1, sport_name: "Football",   sport_icon: nil),
        Sport(sport_key: 2, sport_name: "Basketball", sport_icon: nil),
        Sport(sport_key: 3, sport_name: "Cricket",    sport_icon: nil),
        Sport(sport_key: 4, sport_name: "Tennis",     sport_icon: nil),
        Sport(sport_key: 5, sport_name: "Handball",   sport_icon: nil),
    ]

    init(view: SportsViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        loadSports()
    }

    func numberOfSports() -> Int {
        return sports.count
    }

    func sport(at index: Int) -> Sport {
        return sports[index]
    }

    func didSelectSport(at index: Int) {
        let sport = sports[index]
        view?.navigateToLeagues(sport: sport)
    }

    private func loadSports() {
        view?.showLoading()
        sports = SportsPresenter.availableSports
        view?.reloadData()
        view?.hideLoading()
    }
}
