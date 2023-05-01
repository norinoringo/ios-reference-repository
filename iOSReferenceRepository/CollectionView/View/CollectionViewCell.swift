//
//  UICollexctionViewCell.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/10/01.
//  

/*

Custom UICollectionViewCellの実装
- override init(frame: CGRect) { }
- required inti?(coder aDecoder: NSCoder) { }
- xibファイルを読み込んでaddSubViewする必要あり
参考文献：https://qiita.com/uhooi/items/ce1b8f56fe7d3eaca325

*/

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // コードから生成したときに通る初期化処理
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }

    // InterfaceBulderで配置した場合に通る初期化処理
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureCell()
    }

    private func configureCell() {
        loadNib()
    }

    private func loadNib() {
        let view = UINib(nibName: "CollectionViewCell", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        addSubview(view)

        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
