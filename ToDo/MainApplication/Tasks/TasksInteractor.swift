//
//  TasksInteractor.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit
import Alamofire

// MARK: - protocol

protocol TasksPresenterToInteractorProtocol: AnyObject {
    func fetchTasks()
}

class TasksInteractor {
    
    weak var presenter: TasksInteractorToPresenterProtocol?

}

extension TasksInteractor: TasksPresenterToInteractorProtocol {
    func fetchTasks() {
        AF.request("https://dummyjson.com/todos",
                   method: .get).responseDecodable(of: TodosModel.self) { [weak self] result in
            guard let self else { return }
            presenter?.didFetchTasks(result.value?.todos ?? [])
        }
    }
}
