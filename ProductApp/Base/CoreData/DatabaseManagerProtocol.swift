//
//  DatabaseManagerProtocol.swift
//  ProductApp
//
//  Created by Mac on 09/06/2022.
//

import Foundation
import CoreData

protocol DatabaseManagerProtocol {
    func fetchFavoritesListList() -> [RecipeItemModel]
    func addFavoritesItem(item: RecipeItemModel?)
    func deleteFavoritesItem(item: RecipeItemModel?)
    func isFavoriteItem(item: RecipeItemModel?) -> Bool?
}

extension DatabaseManagerProtocol {
    func fetchFavoritesListList() -> [RecipeItemModel] {
        fetchFavoritesListList()
    }
}

class DatabaseManager {
    static let shared: DatabaseManagerProtocol = DatabaseManager()
    
    var databaseHelper: CoreDataHelper = CoreDataHelper.shared
        
    private func getItem(for todo: RecipeItemModel) -> DataUser? {
        let predicate =  NSPredicate(format: "id == %@", todo.id ?? "")
        let result = databaseHelper.fetchFirst(DataUser.self, predicate: predicate)
        switch result {
        case .success(let todoMO):
            return todoMO
        case .failure(_):
            return nil
        }
    }
}

// MARK: - DataManagerProtocol
extension DatabaseManager: DatabaseManagerProtocol {
        
    func deleteFavoritesItem(item: RecipeItemModel?) {
        guard let item = item ,let todoMO = getItem(for: item) else {
            return
        }
        databaseHelper.delete(todoMO)
    }
    
    func isFavoriteItem(item: RecipeItemModel?) -> Bool? {
        
        guard let item = item ,let _ = getItem(for: item) else {
            return false
        }
        return true
    }
    
    func addFavoritesItem(item: RecipeItemModel?) {
        let entity = DataUser.entity()
        let newTodo = DataUser(entity: entity, insertInto: databaseHelper.context)
        guard let item = item,!(isFavoriteItem(item: item) ?? false) else {
            return
        }
        newTodo.image = item.image
        newTodo.des = item.des
        newTodo.id = item.id
        newTodo.name = item.name
        databaseHelper.create(newTodo)
    }
    func fetchFavoritesListList() -> [RecipeItemModel] {
        let result: Result<[DataUser], Error> = databaseHelper.fetch(DataUser.self)
        switch result {
        case .success(let todoMOs):
            return todoMOs.map { $0.convertToTodo() }
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
}
