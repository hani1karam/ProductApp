//
//  Home + Extenstion.swift
//  ProductApp
//
//  Created by Mac on 09/06/2022.
//

import UIKit

extension HomeVC: ViewModelDelegate {
    func willShowRefresher() {
        DispatchQueue.main.async { [weak self] in
            self?.productCollectionView?.refreshControl?.beginRefreshing()
        }
    }
    func didHideRefresher() {
        DispatchQueue.main.async { [weak self] in
            self?.productCollectionView?.refreshControl?.endRefreshing()
        }
    }
    func didReloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.productCollectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width * 0.5) - 10 , height: 379)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
