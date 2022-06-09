//
//  HomeVC.swift
//  ProductApp
//
//  Created by HanyKaram on 09/06/2022.
//

import UIKit

class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    @IBOutlet weak var productCollectionView: UICollectionView!
    lazy var viewModel: ProductViewModel = {
        return ProductViewModel()
    }()
    static let cellIdentifierDemoCell = "HomeCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        configureUI()
    }
    //MARK: - Helper
    private func configureUI() {
        showCollection()
        productCollectionView.refreshControl = UIRefreshControl()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    private func showCollection(){
        productCollectionView.register(UINib(nibName: HomeVC.cellIdentifierDemoCell, bundle: nil), forCellWithReuseIdentifier: HomeVC.cellIdentifierDemoCell)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.postsCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeVC.cellIdentifierDemoCell, for: indexPath) as! HomeCollectionViewCell
        cell.configuration(viewModel.postsAtIndexPath(indexPath))
        return cell
    }
}
