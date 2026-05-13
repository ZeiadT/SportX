//
//  OnboardingCell.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 10/5/2026.
//

import UIKit

class OnboardingCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.tintColor = Theme.accentColor
        imageView.contentMode = .scaleAspectFit

        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = Theme.primaryText
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.textColor = Theme.secondaryText
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
    }

    func configure(title: String, subtitle: String, systemImage: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        let config = UIImage.SymbolConfiguration(pointSize: 80, weight: .light)
        imageView.preferredSymbolConfiguration = config
        imageView.image = UIImage(systemName: systemImage)?.withRenderingMode(.alwaysTemplate)
    }
}
