//
//  DetailTaskViewController.swift
//  ToDo
//
//  Created by Евгений Таракин on 15.11.2024.
//

import UIKit
import SnapKit

// MARK: - protocols

protocol DetailTaskPresenterToViewProtocol: AnyObject {
    func commonInit()
    func setupTask(_ task: TaskModel?)
}

protocol DetailTaskRouterToViewProtocol: AnyObject {
    
}

final class DetailTaskViewController: UIViewController {
    
    // MARK: - property
    
    var presenter: DetailTaskViewToPresenterProtocol?
    
    // MARK: - private property
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Color.clear
        textField.returnKeyType = .continue
        textField.font = .systemFont(ofSize: 34, weight: .bold)
        textField.adjustsFontSizeToFitWidth = true
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.grayDoneText
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = Color.clear
        textView.font = .systemFont(ofSize: 16)
        
        return textView
    }()

    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.viewDidDisappear(title: titleTextField.text ?? "",
                                    description: textView.text)
    }

}

// MARK: - obj-c

@objc private extension DetailTaskViewController {
    func tapOnView() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension DetailTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - DetailTaskRouterToViewProtocol

extension DetailTaskViewController: DetailTaskRouterToViewProtocol {

}

// MARK: - DetailTaskPresenterToViewProtocol

extension DetailTaskViewController: DetailTaskPresenterToViewProtocol {
    func commonInit() {
        view.backgroundColor = Color.black
        
        navigationController?.navigationBar.tintColor = Color.yellow
        navigationController?.navigationBar.prefersLargeTitles = false
        
        tabBarController?.tabBar.isHidden = true
        
        view.addGestureRecognizer(tap)
        
        view.addSubview(titleTextField)
        view.addSubview(dateLabel)
        view.addSubview(textView)
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(42)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).inset(-8)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(16)
        }
        textView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).inset(-16)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupTask(_ task: TaskModel?) {
        titleTextField.text = task == nil ? "Новая задача" : task?.todo
        dateLabel.text = task == nil ? Date().getStringDate() : task?.date?.getStringDate()
        textView.text = task == nil ? "Новая задача" : task?.descriptions
    }
}

