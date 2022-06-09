//
//  RecipeItemModel.swift
//  ProductApp
//
//  Created by Mac on 09/06/2022.
//

import Foundation
struct RecipeItemModel : Codable {
    let id : String?
    let name : String?
    let image : String?
    let des : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case des = "des"
    }
}
