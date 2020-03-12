//
//  API.swift
//  MandiriNews
//
//  Created by Alan Santoso on 12/03/20.
//  Copyright © 2020 Alan Santoso. All rights reserved.
//

import Foundation

enum APIError : Error {
    case unknown
    case decodingError
    case badResponse
}

class APIClient {
    
    static var shared = APIClient()
    
    func fetchAllArticles(with url:URL, completion: @escaping(Result<[NewsModel], APIError>) -> ()){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                completion(.failure(.badResponse))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(NewsResponse.self, from: jsonData)
                var model = [NewsModel]()
                json.sources?.forEach({ (source) in
                    let news = NewsModel(id: source.id,
                                         name: source.name,
                                         sourceDescription: source.description,
                                         url: source.url,
                                         category: source.category)
                    model.append(news)
                })
                completion(.success(model))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
        
        
    }

}
