//
//  TasksPresenter.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

// MARK: - protocols

protocol TasksViewToPresenterProtocol: AnyObject {
    func getTask(for index: Int) -> Todo
    func getTasks() -> [Todo]
    func getCountTasks() -> Int
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
    
    private var tasks: [Todo] = []
    
    private var selectedIndex = 0
    
}

extension TasksPresenter: TasksViewToPresenterProtocol {
    func getTask(for index: Int) -> Todo {
        return tasks[index] 
    }
    
    func getTasks() -> [Todo] {
        return tasks
    }
    
    func getCountTasks() -> Int {
        return tasks.count
    }
    
    func loadTasks() {
        interactor?.fetchTasks()
    }
    
    func longPressTask(for index: Int) {
        selectedIndex = index
        view?.showTaskWithMenu(for: index)
    }
    
    func updateTask(for index: Int) {
        tasks[index].completed.toggle()
        view?.updateCell(for: index)
    }
    
    func deleteTask() {
        tasks.remove(at: selectedIndex)
        view?.deleteWithAnimatecell(for: selectedIndex)
        view?.updateCountLabel()
    }
}

extension TasksPresenter: TasksInteractorToPresenterProtocol {
    func didFetchTasks(_ tasks: [Todo]) {
        self.tasks = tasks
        view?.updateTableView()
        view?.updateCountLabel()
    }
}
