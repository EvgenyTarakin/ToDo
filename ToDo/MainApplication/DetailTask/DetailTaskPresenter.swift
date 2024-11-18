//
//  TasksPresenter.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

// MARK: - protocols

protocol DetailTaskViewToPresenterProtocol: AnyObject {

}

protocol DetailTaskInteractorToPresenterProtocol: AnyObject {

}

class DetailTaskPresenter {
    
    weak var view: DetailTaskPresenterToViewProtocol!
    var interactor: DetailTaskPresenterToInteractorProtocol!
    var router: DetailTaskPresenterToRouterProtocol!
    
}

extension DetailTaskPresenter: DetailTaskViewToPresenterProtocol {

}

extension DetailTaskPresenter: DetailTaskInteractorToPresenterProtocol {

}
