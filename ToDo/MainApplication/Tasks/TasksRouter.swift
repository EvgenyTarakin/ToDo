//
//  TasksRouter.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

// MARK: - protocol

protocol TasksPresenterToRouterProtocol: AnyObject {
    func openNewTask(index: Int)
    func openDetail(for task: TaskModel, index: Int)
}

final class TasksRouter {
    
    weak var view: TasksRouterToViewProtocol?
    
}

// MARK: - TasksPresenterToRouterProtocol

extension TasksRouter: TasksPresenterToRouterProtocol {
    func openNewTask(index: Int) {
        let controller = DetailTaskConfigurator().configurate(index: index, task: nil)
        view?.navgate(to: controller)
    }
    
    func openDetail(for task: TaskModel, index: Int) {
        let controller = DetailTaskConfigurator().configurate(index: index, task: task)
        view?.navgate(to: controller)
    }
}
