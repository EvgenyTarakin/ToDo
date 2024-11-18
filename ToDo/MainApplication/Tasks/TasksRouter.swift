//
//  TasksRouter.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

// MARK: - protocol

protocol TasksPresenterToRouterProtocol: AnyObject {
    
}

class TasksRouter {
    
    weak var view: TasksRouterToViewProtocol?
    
}

extension TasksRouter: TasksPresenterToRouterProtocol {

}
