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
    func longPressTask(for index: Int)
    func updateTask(for index: Int)
    func deleteTask()
}

protocol TasksInteractorToPresenterProtocol: AnyObject {
    func didFetchTasks(_ tasks: [Todo])
}

class TasksPresenter {
    
    // MARK: - property
    
    weak var view: TasksPresenterToViewProtocol?
    var interactor: TasksPresenterToInteractorProtocol?
    var router: TasksPresenterToRouterProtocol?
    
    // MARK: - private property
    
    private var selectedIndex = 0
    
}

extension TasksPresenter: TasksViewToPresenterProtocol {
    func loadTasks() {
        interactor?.fetchTasks()
    }
    
    func longPressTask(for index: Int) {
        selectedIndex = index
        view?.showTaskWithMenu(for: index)
    }
    
    func updateTask(for index: Int) {
        view?.updateCell(for: index)
    }
    
    func deleteTask() {
        view?.deleteWithAnimatecell(for: selectedIndex)
    }
}

extension TasksPresenter: TasksInteractorToPresenterProtocol {
    func didFetchTasks(_ tasks: [Todo]) {
        view?.updateTableView(tasks)
    }
}
