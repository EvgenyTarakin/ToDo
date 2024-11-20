//
//  TasksRouter.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

// MARK: - protocol

protocol DetailTaskPresenterToRouterProtocol: AnyObject {
    
}

class DetailTaskRouter {
    
    weak var view: DetailTaskRouterToViewProtocol!
    
}

extension DetailTaskRouter: DetailTaskPresenterToRouterProtocol {

}
