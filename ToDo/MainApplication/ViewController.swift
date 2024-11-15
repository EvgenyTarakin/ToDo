//
//  ViewController.swift
//  ToDo
//
//  Created by Евгений Таракин on 15.11.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - property
    
    private lazy var countLabel: Label = {
        let label = Label(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 48))
        
        return label
    }()
    
    private lazy var addNewFolderButton: Button = {
        let button = Button(frame: CGRect(x: view.frame.width - 80, y: 0, width: 80, height: 48))
        button.delegate = self
        
        return button
    }()

    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }


}

// MARK: - private func

private extension ViewController {
    func commonInit() {
        title = "Задачи"
        
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.subviews.forEach {
            $0.removeFromSuperview()
        }

        tabBarController?.tabBar.addSubview(countLabel)
        tabBarController?.tabBar.addSubview(addNewFolderButton)
        
        view.backgroundColor = .black
        
        countLabel.configurate(10)
    }
}

// MARK: - ButtonDelegate

extension ViewController: ButtonDelegate {
    func didSelectButton() {
        
    }
}
