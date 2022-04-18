//
//  Repository.swift
//  MATICTask
//
//  Created by Mohamed Maged on 11/04/2022.
//

import Foundation

// MARK: - RepositoryResponse
struct RepositoryResponse: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Repository]?
}

// MARK: - Repository
struct Repository: Codable, Equatable {
    let id: Int
    let name: String?
    let owner: Owner?
    let description: String?
    let stargazersCount: Double
    let openIssuesCount: Int
    let updatedAt: Date
}

// MARK: - Owner
struct Owner: Codable, Equatable {
    let login: String?
    let id: Int?
    let avatarUrl: String?
}
