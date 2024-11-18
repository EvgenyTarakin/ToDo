//
//  TasksConfigurator.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

class DetailTaskConfigurator {
    
    func configurate() -> UIViewController {
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
        
        return view
    }
    
}
