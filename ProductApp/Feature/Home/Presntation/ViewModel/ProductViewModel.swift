//
//  ProductViewModel.swift
//  ProductApp
//
//  Created by HanyKaram on 09/06/2022.
//

import Foundation
protocol ViewModelDelegate: AnyObject{
    func willShowRefresher()
    func didHideRefresher()
    func didReloadCollectionView()
}

protocol ViewModelType {
    func viewDidLoad()
    var delegate: ViewModelDelegate? { get set }
    var products: [ProductModelElement] { get }
}

class ProductViewModel: ViewModelType {
    weak var delegate: ViewModelDelegate?
    private let network = NetworkLayer()
    var products: [ProductModelElement] = []
    var dataManager: DatabaseManagerProtocol?
    
    func viewDidLoad() {
        if Reachability.isConnectedToNetwork(){
            delegate?.willShowRefresher()
            dataManager = DatabaseManager()
            network.fetchData { [weak self] respones in
                guard let self = self else {return}
                switch respones {
                case let .success(data):
                    self.products = data
                    for data in self.products {
                        self.dataManager?.addFavoritesItem(item: RecipeItemModel(id: "\(data.id ?? 0)", name: data.productDescription, image: data.image?.url, des: data.productDescription))
                    }
                case let .failure(error):
                    print(error)
                }
                self.delegate?.didHideRefresher()
                self.delegate?.didReloadCollectionView()
            }
        }
    }
    var postsCount: Int {
        return products.count
    }
    func postsAtIndexPath(_ indexPath: IndexPath) -> ProductModelElement {
        return products[indexPath.row]
    }
}
