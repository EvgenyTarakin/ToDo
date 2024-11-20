//
//  DetailTaskViewController.swift
//  ToDo
//
//  Created by Евгений Таракин on 15.11.2024.
//

import UIKit

// MARK: - protocols

protocol DetailTaskPresenterToViewProtocol: AnyObject {
    
}

protocol DetailTaskRouterToViewProtocol: AnyObject {
    
}

final class DetailTaskViewController: UIViewController {
    
    // MARK: - property
    
    var presenter: DetailTaskViewToPresenterProtocol!

    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

}

// MARK: - private func

private extension DetailTaskViewController {
    func commonInit() {
        view.backgroundColor = Color.black
        
        navigationController?.navigationBar.tintColor = Color.yellow
        
        tabBarController?.tabBar.isHidden = true
    }
}

// MARK: - DetailTaskRouterToViewProtocol

extension DetailTaskViewController: DetailTaskRouterToViewProtocol {

}

// MARK: - DetailTaskPresenterToViewProtocol

extension DetailTaskViewController: DetailTaskPresenterToViewProtocol {

}
