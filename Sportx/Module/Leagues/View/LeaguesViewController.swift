//
//  LeaguesViewController.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 12/5/2026.
//

import UIKit

class LeaguesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var sport: Sport!
    private var presenter: LeaguesPresenterProtocol!

    override func loadView() {
        super.loadView()
        let nib = UINib(nibName: "LeaguesViewController", bundle: nil)
        self.view = nib.instantiate(withOwner: self).first as! UIView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = sport.sport_name ?? "Leagues"
        view.backgroundColor = Theme.backgroundColor
        presenter = LeaguesPresenter(view: self, sport: sport)
        setupTableView()
        presenter.viewDidLoad()
    }

    private func setupTableView() {
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LeagueCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfLeagues()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueTableViewCell
        let league = presenter.league(at: indexPath.row)
        cell.leagueTitleLabel.text = league.league_name ?? "Unknown League"
        cell.leagueImageView.loadImage(from: league.league_logo)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectLeague(at: indexPath.row)
    }
}

extension LeaguesViewController: LeaguesViewProtocol {

    func reloadData() {
        tableView.reloadData()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func showLoading() {
        activityIndicator?.startAnimating()
    }

    func hideLoading() {
        activityIndicator?.stopAnimating()
    }

    func navigateToLeagueDetails(league: League, sportName: String) {
        let detailsVC = LeagueDetailsViewController()
        detailsVC.league = league
        detailsVC.sportName = sportName
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
