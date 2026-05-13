//
//  FavouritesViewController.swift
//  SportX
//
//  Created by Zeiad Mohammed on 9/5/2026.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!

    private var presenter: FavouritesPresenterProtocol!

    override func loadView() {
        super.loadView()
        let nib = UINib(nibName: "FavouritesViewController", bundle: nil)
        self.view = nib.instantiate(withOwner: self).first as! UIView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favourites"
        view.backgroundColor = Theme.backgroundColor
        presenter = FavouritesPresenter(view: self)
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }

    private func setupTableView() {
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LeagueCell")
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
    }
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfLeagues()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueTableViewCell
        let league = presenter.league(at: indexPath.row)
        cell.leagueTitleLabel.text = league.name ?? "Unknown"
        cell.leagueImageView.loadImage(from: league.badge)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectLeague(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteLeague(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension FavouritesViewController: FavouritesViewProtocol {

    func reloadData() {
        tableView.reloadData()
    }

    func showOfflineAlert() {
        let alert = UIAlertController(
            title: "No Internet Connection",
            message: "Please check your internet connection and try again.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func navigateToLeagueDetails(leagueId: Int, leagueName: String, leagueLogo: String, sportName: String) {
        let detailsVC = LeagueDetailsViewController()
        let league = League(
            league_key: leagueId,
            league_name: leagueName,
            country_name: nil,
            league_logo: leagueLogo
        )
        detailsVC.league = league
        detailsVC.sportName = sportName
        navigationController?.pushViewController(detailsVC, animated: true)
    }

    func showEmptyState(_ show: Bool) {
        emptyLabel.isHidden = !show
        tableView.isHidden = show
    }
}
