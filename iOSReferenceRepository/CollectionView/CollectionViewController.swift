//
//  CollectionViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/10/01.
//  

/*

UICollectionViewの実装
- Prootocol継承
 - UIViewController(UICollectionViewControllerを継承するとエラーになる？)
 - UICollectionViewDataSource
 - UICollectionViewDelegate

- UICollectionViewDataSource
 - func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { }
 - func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { }

- ViewDidLoad時
 - collectionView.datasource = self
 - collectionView.delegate = self
 - UICollectionViewCellをregister
    - collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")

 */

import Foundation
import UIKit

class CollectionViewController:  UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        registerCell()
        initCellSize()
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegate {

}

extension CollectionViewController {
    private func initCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func registerCell() {
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
    }

    private func initCellSize() {
        // TODO: UICollectionView_Cellのサイズが自動調整されない
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: 300, height: 500)
    }
}
