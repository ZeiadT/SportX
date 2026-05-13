//
//  OnboardingViewController.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 10/5/2026.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!

    var onFinish: (() -> Void)?

    private let pages: [(title: String, subtitle: String, systemImage: String)] = [
        (
            title: "Welcome to SportX",
            subtitle: "Your ultimate companion for all sports. Stay updated with live scores, fixtures, and your favourite leagues.",
            systemImage: "sportscourt"
        ),
        (
            title: "Explore Every Sport",
            subtitle: "From football to tennis, cricket to basketball — browse leagues and teams across the globe.",
            systemImage: "globe"
        ),
        (
            title: "Save Your Favourites",
            subtitle: "Add leagues to your favourites for quick access. We'll keep them safe even when you're offline.",
            systemImage: "heart.fill"
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.backgroundColor
        setupCollectionView()
        applyTheme()
    }

    private func setupCollectionView() {
        let nib = UINib(nibName: "OnboardingCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "OnboardingCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func applyTheme() {
        pageControl.currentPageIndicatorTintColor = Theme.accentColor
        pageControl.pageIndicatorTintColor = Theme.secondaryText.withAlphaComponent(0.3)
        nextButton.backgroundColor = Theme.accentColor
        skipButton.setTitleColor(Theme.secondaryText, for: .normal)
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        let currentPage = pageControl.currentPage
        if currentPage < pages.count - 1 {
            let nextIndex = IndexPath(item: currentPage + 1, section: 0)
            collectionView.scrollToItem(at: nextIndex, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentPage + 1
            updateButtonTitle()
        } else {
            onFinish?()
        }
    }

    @IBAction func skipTapped(_ sender: UIButton) {
        onFinish?()
    }

    private func updateButtonTitle() {
        let isLastPage = pageControl.currentPage == pages.count - 1
        nextButton.setTitle(isLastPage ? "Get Started" : "Next", for: .normal)
        skipButton.isHidden = isLastPage
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        let page = pages[indexPath.item]
        cell.configure(title: page.title, subtitle: page.subtitle, systemImage: page.systemImage)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
        updateButtonTitle()
    }
}
