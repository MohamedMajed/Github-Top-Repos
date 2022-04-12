//
//  Repository.swift
//  MATICTask
//
//  Created by Mohamed Maged on 11/04/2022.
//

import Foundation

// MARK: - RepositoryResponse
struct RepositoryResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]
}

// MARK: - Repository
struct Repository: Codable {
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: Int
    let openIssuesCount: Int
    let createdAt, updatedAt: Date
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let id: Int
    let avatarURL: String
   

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
    }
}
