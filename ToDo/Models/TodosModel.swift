//
//  TodosModel.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import Foundation

// MARK: - TodosModel

struct TodosModel: Codable {
    let todos: [Todo]
    let total, skip, limit: Int
}

// MARK: - Todo

struct Todo: Codable {
    let id: Int
    var todo: String
    var completed: Bool
    let userID: Int
    var date = Date()

    enum CodingKeys: String, CodingKey {
        case id, todo, completed
        case userID = "userId"
    }
}
