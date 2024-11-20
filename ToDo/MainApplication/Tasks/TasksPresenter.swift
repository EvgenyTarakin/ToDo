//
//  TasksPresenter.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

// MARK: - protocols

protocol TasksViewToPresenterProtocol: AnyObject {
    func getTask(for index: Int) -> TaskModel
    func getCountTasks() -> Int
    func viewDidLoad()
    func viewDidAppear()
    func searchTasks(for text: String)
    func longPressTask(for index: Int)
    func updateTask(for index: Int)
    func didSelectCell(for index: Int)
    func tapEditTask()
    func tapDeleteTask()
    func addTask()
}

protocol TasksInteractorToPresenterProtocol: AnyObject {
    func didFetchTasks()
}

final class TasksPresenter {
    
    // MARK: - property
    
    weak var view: TasksPresenterToViewProtocol?
    var interactor: TasksPresenterToInteractorProtocol?
    var router: TasksPresenterToRouterProtocol?
    
    // MARK: - private property
    
    private var selectedIndex = 0
    
}

// MARK: - TasksViewToPresenterProtocol

extension TasksPresenter: TasksViewToPresenterProtocol {
    func getTask(for index: Int) -> TaskModel {
        return interactor?.getActualTask(for: index) ?? TaskModel()
    }
    
    func getCountTasks() -> Int {
        return interactor?.getCountActualDatas() ?? 0
    }
    
    func viewDidLoad() {
        view?.commonInit()
        interactor?.fetchTasks()
    }
    
    func viewDidAppear() {
        view?.setupTabBar()
        interactor?.fetchTasksAfterUpdates()
    }
    
    func searchTasks(for text: String) {
        interactor?.filterTasks(by: text)
    }
    
    func longPressTask(for index: Int) {
        selectedIndex = index
        view?.showTaskWithMenu(for: index)
    }
    
    func updateTask(for index: Int) {
        interactor?.updateTask(for: index)
    }
    
    func didSelectCell(for index: Int) {
        router?.openDetail(for: getTask(for: index), index: index)
    }
    
    func addTask() {
        router?.openNewTask(index: getCountTasks())
    }
    
    func tapEditTask() {
        router?.openDetail(for: getTask(for: selectedIndex), index: selectedIndex)
    }
    
    func tapDeleteTask() {
        interactor?.deleteTaskFromData(index: selectedIndex)
    }
}

// MARK: - TasksInteractorToPresenterProtocol

extension TasksPresenter: TasksInteractorToPresenterProtocol {
    func didFetchTasks() {
        view?.updateTableView()
    }
}
