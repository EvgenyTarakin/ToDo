//
//  TasksRouter.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

// MARK: - protocol

protocol TasksPresenterToRouterProtocol: AnyObject {
    func openNewTask()
    func openDetail(for task: TaskModel)
}

final class TasksRouter {
    
    weak var view: TasksRouterToViewProtocol?
    
}

// MARK: - TasksPresenterToRouterProtocol

extension TasksRouter: TasksPresenterToRouterProtocol {
    func openNewTask() {
        let controller = DetailTaskConfigurator().configurate()
        view?.navgate(to: controller)
    }
    
    func openDetail(for task: TaskModel) {
        let controller = DetailTaskConfigurator().configurate(task: task)
        view?.navgate(to: controller)
    }
}
