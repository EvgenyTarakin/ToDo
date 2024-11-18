//
//  TasksConfigurator.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

class TasksConfigurator {
    
    func configurate() -> UIViewController {
        let view = TasksViewController()
        let presenter = TasksPresenter()
        let interactor = TasksInteractor()
        let router = TasksRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
    
}
