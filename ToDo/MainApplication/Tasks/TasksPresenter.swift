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
    func getCountTasks() -> Int
    func loadTasks()
    func filterTask(for text: String)
    func longPressTask(for index: Int)
    func updateTask(for index: Int)
    func didSelectCell(for index: Int)
    func editTask()
    func deleteTask()
    func addTask()
}

protocol TasksInteractorToPresenterProtocol: AnyObject {
    func didFetchTasks(_ tasks: [Todo])
}

final class TasksPresenter {
    
    // MARK: - property
    
    weak var view: TasksPresenterToViewProtocol?
    var interactor: TasksPresenterToInteractorProtocol?
    var router: TasksPresenterToRouterProtocol?
    
    // MARK: - private property
    
    private var tasks: [Todo] = []
    private var tasksCopy: [Todo] = []
    
    private var selectedIndex = 0
    
}

// MARK: - TasksViewToPresenterProtocol

extension TasksPresenter: TasksViewToPresenterProtocol {
    func getTask(for index: Int) -> Todo {
        return tasks[index] 
    }
    
    func getCountTasks() -> Int {
        return tasks.count
    }
    
    func loadTasks() {
        interactor?.fetchTasks()
    }
    
    func filterTask(for text: String) {
        if text.isEmpty {
            tasks = tasksCopy
        } else {
            tasks = tasks.filter { $0.todo.contains(text) }
        }
        view?.updateTableView()
    }
    
    func longPressTask(for index: Int) {
        selectedIndex = index
        view?.showTaskWithMenu(for: index)
    }
    
    func updateTask(for index: Int) {
        tasks[index].completed.toggle()
        for i in tasksCopy.indices {
            if tasksCopy[i].id == tasks[index].id {
                tasksCopy[i].completed.toggle()
            }
        }
        view?.updateCell(for: index)
    }
    
    func didSelectCell(for index: Int) {
        router?.openDetail(for: getTask(for: index))
    }
    
    func addTask() {
        router?.openNewTask()
    }
    
    func editTask() {
        router?.openDetail(for: getTask(for: selectedIndex))
    }
    
    func deleteTask() {
        tasks.remove(at: selectedIndex)
        view?.deleteWithAnimatecell(for: selectedIndex)
    }
}

// MARK: - TasksInteractorToPresenterProtocol

extension TasksPresenter: TasksInteractorToPresenterProtocol {
    func didFetchTasks(_ tasks: [Todo]) {
        self.tasks = tasks
        tasksCopy = tasks
        view?.updateTableView()
    }
}
