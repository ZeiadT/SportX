//
//  SportsViewController.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 11/5/2026.
//

import UIKit

class SportsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var presenter: SportsPresenterProtocol!

    override func loadView() {
        super.loadView()
        let nib = UINib(nibName: "SportsViewController", bundle: nil)
        self.view = nib.instantiate(withOwner: self).first as! UIView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Sports"
        view.backgroundColor = Theme.backgroundColor
        setupCollectionView()
        presenter = SportsPresenter(view: self)
        presenter.viewDidLoad()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = Theme.padding
        let itemsPerRow: CGFloat = 2
        let totalSpacing = spacing * (itemsPerRow + 1)
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / itemsPerRow

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.1)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing

        collectionView.collectionViewLayout = layout

        let nib = UINib(nibName: "SportCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SportCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SportsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfSports()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCell", for: indexPath) as! SportCollectionViewCell
        cell.configure(with: presenter.sport(at: indexPath.item))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectSport(at: indexPath.item)
    }
}

extension SportsViewController: SportsViewProtocol {

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

    func navigateToLeagues(sport: Sport) {
        let leaguesVC = LeaguesViewController()
        leaguesVC.sport = sport
        navigationController?.pushViewController(leaguesVC, animated: true)
    }
}
