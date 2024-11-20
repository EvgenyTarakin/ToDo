//
//  TasksInteractor.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

// MARK: - protocol

protocol DetailTaskPresenterToInteractorProtocol: AnyObject {
    func fetchTask()
    func saveTask(title: String, description: String)
}

final class DetailTaskInteractor {
    
    // MARK: - property
    
    weak var presenter: DetailTaskInteractorToPresenterProtocol?

    // MARK: - private property
    
    private var dataManager = DataManager()
    
    private var index: Int = 0
    private var task: TaskModel?
    
}

// MARK: - func

extension DetailTaskInteractor {
    func configurate(index: Int, task: TaskModel?) {
        self.index = index
        self.task = task
    }
}

// MARK: - DetailTaskPresenterToInteractorProtocol

extension DetailTaskInteractor: DetailTaskPresenterToInteractorProtocol {
    func saveTask(title: String, description: String) {
        if task == nil {
            dataManager.saveData(title: title, description: description, completed: false)
        } else {
            dataManager.updateInformationData(index: index, title: title, description: description)
        }
    }
    
    func fetchTask() {
        presenter?.didFetchTask(task: task)
    }
}
