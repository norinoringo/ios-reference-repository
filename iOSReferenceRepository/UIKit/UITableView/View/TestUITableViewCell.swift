//
//  TestUITableViewCell.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/12.
//  


import Foundation
import UIKit

class TestUITableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImageView.image = nil
        titleLabel.text = nil
        subTitleLabel.text = nil
    }

    private func initView() {
        titleLabel.font = .boldSystemFont(ofSize: 20)
        subTitleLabel.font = .italicSystemFont(ofSize: 14)
    }

    func configure(thumbImage: UIImage,
                   title: String,
                   subTitle: String) {
        thumbImageView.image = thumbImage
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}
