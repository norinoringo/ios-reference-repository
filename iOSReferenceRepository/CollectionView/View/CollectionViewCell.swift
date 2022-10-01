//
//  UICollexctionViewCell.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/10/01.
//  


import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // コードから生成したときに通る初期化処理
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCell()
    }

    // InterfaceBulderで配置した場合に通る初期化処理
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCell()
    }

    private func initCell() {
        let view = UINib(nibName: "CollectionViewCell", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        addSubview(view)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
