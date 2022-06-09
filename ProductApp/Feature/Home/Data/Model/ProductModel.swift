//
//  ProductModel.swift
//  ProductApp
//
//  Created by HanyKaram on 09/06/2022.
//

import Foundation

// MARK: - ProductModelElement
struct ProductModelElement: Codable {
    let id: Int?
    let productDescription: String?
    let image: Image?
    let price: Int?
}

// MARK: - Image
struct Image: Codable {
    let width, height: Int?
    let url: String?
}

typealias ProductModel = [ProductModelElement]
