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
    func getActualTasks() -> [TaskModel]
    func getActualTask(for index: Int) -> TaskModel
    func getCountActualDatas() -> Int
    
    func updateTask(for index: Int)
    func deleteTaskFromData(index: Int)
    
    func filterTasks(by text: String)
}

final class TasksInteractor {
    
    // MARK: - property
    
    weak var presenter: TasksInteractorToPresenterProtocol?
    
    // MARK: - private property
    
    private var dataManager = DataManager()
    
    private var filterText = ""
    
    func getFilterTasks() -> [TaskModel] {
        if filterText.isEmpty {
            return dataManager.getDatas()
        } else {
            return dataManager.getDatas().filter { ($0.todo ?? "").contains(filterText) }
        }
    }

}

// MARK: - TasksPresenterToInteractorProtocol

extension TasksInteractor: TasksPresenterToInteractorProtocol {
    func fetchTasks() {
        if dataManager.getDatas().isEmpty {
            AF.request("https://dummyjson.com/todos",
                       method: .get).responseDecodable(of: TodosModel.self) { [weak self] result in
                guard let self else { return }
                result.value?.todos.forEach {
                    self.dataManager.saveData(title: $0.todo, description: $0.todo, completed: $0.completed)
                }
                presenter?.didFetchTasks()
            }
        } else {
            presenter?.didFetchTasks()
        }
    }
    
    func getActualTasks() -> [TaskModel] {
        return getFilterTasks()
    }
    
    func getActualTask(for index: Int) -> TaskModel {
        return getFilterTasks()[index]
    }
    
    func getCountActualDatas() -> Int {
        return getFilterTasks().count
    }
    
    func updateTask(for index: Int) {
        dataManager.updateCheckData(index: index)
        presenter?.didFetchTasks()
    }
    
    func deleteTaskFromData(index: Int) {
        dataManager.deleteData(index: index)
        presenter?.didFetchTasks()
    }
    
    func filterTasks(by text: String) {
        filterText = text
        presenter?.didFetchTasks()
    }
}
