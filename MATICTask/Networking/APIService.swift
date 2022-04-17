//
//  RepositoriesService.swift
//  MATICTask
//
//  Created by Mohamed Maged on 12/04/2022.
//

import Foundation

protocol APIServiceProtocol {
    func fetchRepositories(atPage: Int, completion: @escaping (Result<[Repository]?, Error>) -> Void)
}

class APIService: APIServiceProtocol {
    
    func fetchRepositories(atPage: Int, completion: @escaping (Result<[Repository]?, Error>) -> Void ) {
        let URLString = "https://api.github.com/search/repositories?per_page=100&q=created:>2017-10-22&sort=stars&order=desc&page=\(atPage)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = URL(string: URLString)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try decoder.decode(RepositoryResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(json.items))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                print(error.localizedDescription)
            }
        }.resume()
    }
}
