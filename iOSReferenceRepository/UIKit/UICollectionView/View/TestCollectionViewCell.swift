//
//  TestCollectionViewCell.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/16.
//  


import UIKit

class TestCollectionViewCell: UICollectionViewCell {
    typealias Data = TestCollectionViewModel.Data

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var soldoutImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clearView()
    }

    private func initView() {
        // Cellのサイズ設定、labelのフォント設定、labelの背景の透過設定
    }

    private func clearView() {
        thumbImage.image = nil
        soldoutImage.isHidden = true
        priceLabel.text = nil
    }

    func configure(data: Data) {
        thumbImage.image = data.thumbImgage
        soldoutImage.isHidden = !data.isSoldOut
        priceLabel.text = "¥" + "\(data.price)"
    }
}
