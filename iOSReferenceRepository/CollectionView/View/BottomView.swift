//
//  BottomView.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/10/01.
//  


import Foundation
import UIKit

class BottomView: UIView {
    // コードから生成したときに通る初期化処理
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    // InterfaceBulderで配置した場合に通る初期化処理
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    private func initView() {
        let view = UINib(nibName: "BottomView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        addSubview(view)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
