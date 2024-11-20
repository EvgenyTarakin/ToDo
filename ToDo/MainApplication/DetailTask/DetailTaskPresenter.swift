//
//  TasksPresenter.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

// MARK: - protocols

protocol DetailTaskViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
}

protocol DetailTaskInteractorToPresenterProtocol: AnyObject {

}

final class DetailTaskPresenter {
    
    // MARK: - property
    
    weak var view: DetailTaskPresenterToViewProtocol?
    var interactor: DetailTaskPresenterToInteractorProtocol?
    var router: DetailTaskPresenterToRouterProtocol?
    
    // MARK: - private property
    
    private var task: Todo?
    
}

// MARK: - func

extension DetailTaskPresenter {
    func configurate(task: Todo) {
        self.task = task
    }
}

// MARK: - DetailTaskViewToPresenterProtocol

extension DetailTaskPresenter: DetailTaskViewToPresenterProtocol {
    func viewDidLoad() {
        view?.commonInit()
        guard let task else { return }
        view?.setupTask(task)
    }
}

// MARK: - DetailTaskInteractorToPresenterProtocol

extension DetailTaskPresenter: DetailTaskInteractorToPresenterProtocol {

}
