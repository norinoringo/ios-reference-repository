//
//  TopViewHeader.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/11/12.
//  


import UIKit

class TopViewHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var sectionTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func configure(sectionTitle: String) {
        self.sectionTitleLabel.text = sectionTitle
    }
}
