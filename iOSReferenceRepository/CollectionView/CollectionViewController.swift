//
//  CollectionViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/10/01.
//  


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
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: 100, height: 100)
    }
}
