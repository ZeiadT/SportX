//
//  LeagueDetailsViewController.swift
//  SportX
//
//  Created by Zeiad Mohammed on 12/5/2026.
//

import UIKit

class LeagueDetailsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var league: League!
    var sportName: String!
    private var presenter: LeagueDetailsPresenterProtocol!

    override func loadView() {
        super.loadView()
        let nib = UINib(nibName: "LeagueDetailsViewController", bundle: nil)
        self.view = nib.instantiate(withOwner: self).first as! UIView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = league.league_name ?? "League Details"
        view.backgroundColor = Theme.backgroundColor
        presenter = LeagueDetailsPresenter(view: self, league: league, sportName: sportName)
        setupCollectionView()
        setupFavoriteButton()
        presenter.viewDidLoad()
    }

    private func setupCollectionView() {
        let upcomingNib = UINib(nibName: "UpcomingEventCell", bundle: nil)
        collectionView.register(upcomingNib, forCellWithReuseIdentifier: "UpcomingEventCell")

        let latestNib = UINib(nibName: "LatestEventCell", bundle: nil)
        collectionView.register(latestNib, forCellWithReuseIdentifier: "LatestEventCell")

        let teamNib = UINib(nibName: "TeamCollectionViewCell", bundle: nil)
        collectionView.register(teamNib, forCellWithReuseIdentifier: "TeamCell")

        let headerNib = UINib(nibName: "SectionHeaderView", bundle: nil)
        collectionView.register(
            headerNib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SectionHeader"
        )

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = createCompositionalLayout()
    }

    private func setupFavoriteButton() {
        let favButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(favoriteTapped)
        )
        favButton.tintColor = Theme.accentColor
        navigationItem.rightBarButtonItem = favButton
    }

    @objc private func favoriteTapped() {
        let isFav = presenter.toggleFavorite()
        updateFavoriteButton(isFavorite: isFav)
    }

    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            switch sectionIndex {
            case 0: return self.makeHorizontalSection(itemWidth: 280, itemHeight: 160)
            case 1: return self.makeVerticalSection(itemHeight: 120)
            case 2: return self.makeHorizontalSection(itemWidth: 120, itemHeight: 150)
            default: return nil
            }
        }
    }

    private func makeHorizontalSection(itemWidth: CGFloat, itemHeight: CGFloat) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemWidth),
            heightDimension: .absolute(itemHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemWidth),
            heightDimension: .absolute(itemHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 16, trailing: 12)
        section.boundarySupplementaryItems = [makeSectionHeader()]
        return section
    }

    private func makeVerticalSection(itemHeight: CGFloat) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(itemHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(itemHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 16, trailing: 12)
        section.boundarySupplementaryItems = [makeSectionHeader()]
        return section
    }

    private func makeSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
}

extension LeagueDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return presenter.numberOfUpcomingEvents()
        case 1: return presenter.numberOfLatestEvents()
        case 2: return presenter.numberOfTeams()
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEventCell", for: indexPath) as! UpcomingEventCell
            cell.configure(with: presenter.upcomingEvent(at: indexPath.item))
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestEventCell", for: indexPath) as! LatestEventCell
            cell.configure(with: presenter.latestEvent(at: indexPath.item))
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCollectionViewCell
            cell.configure(with: presenter.team(at: indexPath.item))
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "SectionHeader",
            for: indexPath
        ) as! SectionHeaderView

        switch indexPath.section {
        case 0: header.titleLabel.text = "Upcoming Events"
        case 1: header.titleLabel.text = "Latest Events"
        case 2: header.titleLabel.text = "Teams"
        default: break
        }

        return header
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            presenter.didSelectTeam(at: indexPath.item)
        }
    }
}

extension LeagueDetailsViewController: LeagueDetailsViewProtocol {

    func reloadData() {
        collectionView.reloadData()
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

    func updateFavoriteButton(isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
    }

    func navigateToTeamDetails(team: Team) {
        let teamDetailsVC = TeamDetailsViewController()
        teamDetailsVC.team = team
        navigationController?.pushViewController(teamDetailsVC, animated: true)
    }
}
