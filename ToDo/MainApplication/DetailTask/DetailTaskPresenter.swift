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
    func viewDidDisappear(title: String, description: String)
}

protocol DetailTaskInteractorToPresenterProtocol: AnyObject {
    func didFetchTask(task: TaskModel?)
}

final class DetailTaskPresenter {
    
    // MARK: - property
    
    weak var view: DetailTaskPresenterToViewProtocol?
    var interactor: DetailTaskPresenterToInteractorProtocol?
    var router: DetailTaskPresenterToRouterProtocol?
    
}

// MARK: - DetailTaskViewToPresenterProtocol

extension DetailTaskPresenter: DetailTaskViewToPresenterProtocol {
    func viewDidLoad() {
        view?.commonInit()
        interactor?.fetchTask()
    }
    
    func viewDidDisappear(title: String, description: String) {
        interactor?.saveTask(title: title, description: description)
    }
}

// MARK: - DetailTaskInteractorToPresenterProtocol

extension DetailTaskPresenter: DetailTaskInteractorToPresenterProtocol {
    func didFetchTask(task: TaskModel?) {
        view?.setupTask(task)
    }
}
