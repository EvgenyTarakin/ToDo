//
//  TasksInteractor.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import UIKit

// MARK: - protocol

protocol DetailTaskPresenterToInteractorProtocol: AnyObject {

}

class DetailTaskInteractor {
    
    weak var presenter: DetailTaskInteractorToPresenterProtocol!

}

extension DetailTaskInteractor: DetailTaskPresenterToInteractorProtocol {

}
