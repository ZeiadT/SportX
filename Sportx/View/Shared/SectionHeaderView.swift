//
//  SectionHeaderView.swift
//  SportX
//
//  Created by Zeiad Mohammed on 12/5/2026.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = Theme.primaryText
    }
}
