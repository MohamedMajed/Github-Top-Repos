//
//  RepositoriesService.swift
//  MATICTask
//
//  Created by Mohamed Maged on 12/04/2022.
//

import Foundation

protocol RepositoriesService {
    func fetchRepositories(atPage: Int, completion: @escaping (Result<RepositoryResponse, Error>) -> Void)
}

class APIService: RepositoriesService {
    
    func fetchRepositories(atPage: Int, completion: @escaping (Result<RepositoryResponse, Error>) -> Void ) {
        let URLString = "https://api.github.com/search/repositories?per_page=100&q=created:>2017-10-22&sort=stars&order=desc&page=\(atPage)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: URLString)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        executeRequest(url: url, httpMethod: "GET", payload: nil, decoding: RepositoryResponse.self, using: decoder, completion: completion)
    }
    
    func executeRequest<T: Decodable>(url: URL, httpMethod: String, payload: Data?, decoding: T.Type, using decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = payload
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            do {
                if let error = error { throw error }
                
                guard let data = data else {
                    completion(.failure(APIError.dataNotFound))
                    return
                }
                let decodedModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedModel))
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
