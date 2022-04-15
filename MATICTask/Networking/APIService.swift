//
//  RepositoriesService.swift
//  MATICTask
//
//  Created by Mohamed Maged on 12/04/2022.
//

import Foundation

class APIService {
    
    func fetchRepositories(atPage: Int, completion: @escaping ([Repository]?, Error?) -> Void ) {
        let URLString = "https://api.github.com/search/repositories?q=created:>2017-10-22&sort=stars&order=desc&page=\(atPage)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = URL(string: URLString)
        let request = URLRequest(url: url!)
        let _ = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try decoder.decode(RepositoryResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(json.items, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion([], error)
                }
                print(error.localizedDescription)
            }
        }.resume()
        
        //        let _ = URLSession.shared.dataTask(with: request) { data, response, error in
        //            do {
        //                if let data = data {
        //                    let decoder = JSONDecoder()
        //                    decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601
        //                    decoder.keyDecodingStrategy = .convertFromSnakeCase
        //                    let json = try decoder.decode(RepositoryResponse.self, from: data)
        //                    DispatchQueue.main.async {
        //                        completion(json.items, nil)
        //                    }
        //                }
        //            } catch {
        //                DispatchQueue.main.async {
        //                    completion([], error)
        //                }
        //                print(error.localizedDescription)
        //            }
        //        }.resume()
    }
}

