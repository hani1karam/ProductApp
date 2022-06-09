//
//  DataUser.swift
//  ProductApp
//
//  Created by Mac on 09/06/2022.
//

import Foundation
extension DataUser{
    func convertToTodo() -> RecipeItemModel {
        RecipeItemModel(
            id:id,
            name: name,
            image:image,
            des:des)
    }
}
