//
//  TasksConfigurator.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

final class DetailTaskConfigurator {
    
    func configurate(index: Int, task: TaskModel?) -> UIViewController {
        let view = DetailTaskViewController()
        let presenter = DetailTaskPresenter()
        let interactor = DetailTaskInteractor()
        let router = DetailTaskRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.view = view
        
        interactor.configurate(index: index, task: task)
        
        return view
    }
    
}
