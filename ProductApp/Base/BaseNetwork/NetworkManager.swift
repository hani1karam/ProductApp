//
//  NetworkManager.swift
//  ProductApp
//
//  Created by HanyKaram on 09/06/2022.
//
import Foundation
protocol NetworkManager{
    func fetchData(completion: @escaping (Result<[ProductModelElement], Error>) -> Void)
}
class NetworkLayer:NetworkManager{
    func fetchData(completion: @escaping (Result<[ProductModelElement], Error>) -> Void) {
        guard let url = URL(string: "http://myjson.dit.upm.es/api/bins/f16t") else {return}
        let dataTask = URLSession.shared.dataTask(with: url) { data, _ , error in
            do {
                let respones = try JSONDecoder().decode([ProductModelElement].self, from: data ?? Data())
                completion(.success(respones))
                
            } catch let error {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}
