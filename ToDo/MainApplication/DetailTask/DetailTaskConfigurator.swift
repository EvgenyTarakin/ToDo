//
//  TasksConfigurator.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

final class DetailTaskConfigurator {
    
    func configurate(task: Todo = Todo(id: 30, todo: "Новая задача", completed: false, userID: 0, date: Date())) -> UIViewController {
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
        
        presenter.configurate(task: task)
        
        return view
    }
    
}
