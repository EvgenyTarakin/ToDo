//
//  TasksPresenter.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

// MARK: - protocols

protocol TasksViewToPresenterProtocol: AnyObject {
    func loadTasks()
}

protocol TasksInteractorToPresenterProtocol: AnyObject {
    func didFetchTasks(_ tasks: [Todo])
}

class TasksPresenter {
    
    weak var view: TasksPresenterToViewProtocol?
    var interactor: TasksPresenterToInteractorProtocol?
    var router: TasksPresenterToRouterProtocol?
    
}

extension TasksPresenter: TasksViewToPresenterProtocol {
    func loadTasks() {
        interactor?.fetchTasks()
    }
}

extension TasksPresenter: TasksInteractorToPresenterProtocol {
    func didFetchTasks(_ tasks: [Todo]) {
        view?.updateTableView(tasks)
    }
}
