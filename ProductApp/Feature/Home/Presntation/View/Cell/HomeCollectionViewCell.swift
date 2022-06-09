//
//  HomeCollectionViewCell.swift
//  ProductApp
//
//  Created by HanyKaram on 09/06/2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productDetails: UILabel!
    @IBOutlet weak var homeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        homeView.staticShadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.5))
        homeView.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        homeView.layer.cornerRadius = 10
        img.layer.cornerRadius = 15.0
        img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    func configuration (_ viewModel: ProductModelElement) {
        self.price.text = "\(viewModel.price ?? 0)$"
        self.productDetails.text = viewModel.productDescription
        ImageLoader.sharedLoader.imageForUrl(urlString: viewModel.image?.url ?? "") { (image, url) in
            DispatchQueue.main.async {
                self.img.image = image
            }
        }
    }
}
