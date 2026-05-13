//
//  SportCollectionViewCell.swift
//  SportX
//
//  Created by Wahid Ali Wahid on 11/5/2026.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sportImageView: UIImageView!
    @IBOutlet weak var sportNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        Theme.applyShadow(to: self)
        self.layer.cornerRadius = Theme.cornerRadius
        sportImageView.tintColor = Theme.accentColor
        sportNameLabel.textColor = Theme.primaryText
    }

    func configure(with sport: Sport) {
        sportNameLabel.text = sport.sport_name ?? "Unknown"
        sportImageView.image = image(for: sport.sport_name ?? "")
    }

    private func image(for sportName: String) -> UIImage {
        let assetName: String
        switch sportName.lowercased() {
        case "football":   assetName = "Football"
        case "basketball": assetName = "Basketball"
        case "cricket":    assetName = "Cricket"
        case "tennis":     assetName = "Tennis"
        case "handball":   assetName = "Handball"
        default:           assetName = "Football"
        }
        return UIImage(named: assetName) ?? UIImage(systemName: "sportscourt") ?? UIImage()
    }
}
