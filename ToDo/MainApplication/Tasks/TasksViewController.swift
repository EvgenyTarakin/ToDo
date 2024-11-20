//
//  TasksViewController.swift
//  ToDo
//
//  Created by Евгений Таракин on 15.11.2024.
//

import UIKit
import SnapKit

// MARK: - protocols

protocol TasksPresenterToViewProtocol: AnyObject {
    func commonInit()
    func setupTabBar()
    func updateTableView()
    func updateCell(for index: Int)
    func showTaskWithMenu(for index: Int)
}

protocol TasksRouterToViewProtocol: AnyObject {
    func navgate(to controller: UIViewController)
}

final class TasksViewController: UIViewController {
    
    // MARK: - property
    
    var presenter: TasksViewToPresenterProtocol?
    
    // MARK: - private property
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Color.graySelectTask
        textField.layer.cornerRadius = 10
        textField.returnKeyType = .search
        textField.placeholder = "Search"
        textField.setGlassAndMicroImage()
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private lazy var countLabel: Label = {
        let label = Label(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 48))
        
        return label
    }()
    
    private lazy var addNewFolderButton: TabButton = {
        let button = TabButton(frame: CGRect(x: view.frame.width - 80, y: 0, width: 80, height: 48))
        button.delegate = self
        
        return button
    }()
    
    private lazy var selectTaskView: TaskWithMenuView = {
        let selectTaskView = TaskWithMenuView()
        selectTaskView.isHidden = true
        selectTaskView.delegate = self
        
        return selectTaskView
    }()

    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }

}

// MARK: - obj-c

@objc private extension TasksViewController {
    func tapOnView() {
        textField.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate

extension TasksViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var searchText = (textField.text ?? "") + string
        if string.isEmpty {
            searchText.removeLast()
        }
        presenter?.searchTasks(for: searchText)
        
        return true
    }
}

// MARK: - UITableViewDelegate

extension TasksViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCountTasks() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier, for: indexPath) as? TaskCell,
              let task = presenter?.getTask(for: indexPath.row)
        else { return UITableViewCell() }
        cell.configurate(index: indexPath.row,
                         title: task.todo ?? "",
                         description: task.descriptions ?? "",
                         date: task.date ?? Date(),
                         isCompleted: task.completed)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - TaskCellDelegate

extension TasksViewController: TaskCellDelegate {
    func didTapCell(index: Int) {
        view.endEditing(true)
        presenter?.didSelectCell(for: index)
    }
    
    func didTapCheckButton(index: Int) {
        view.endEditing(true)
        presenter?.updateTask(for: index)
    }
    
    func didLongPressCell(index: Int) {
        view.endEditing(true)
        presenter?.longPressTask(for: index)
    }
}

// MARK: - ButtonDelegate

extension TasksViewController: ButtonDelegate {
    func didSelectButton() {
        presenter?.addTask()
    }
}

// MARK: - SelectTaskViewDelegate

extension TasksViewController: TaskWithMenuViewDelegate {
    func didSelectEditButton() {
        presenter?.tapEditTask()
    }
    
    func didSelectShareButton() {
        
    }
    
    func didSelectDeleteButton() {
        presenter?.tapDeleteTask()
    }
}

// MARK: - TasksRouterToViewProtocol

extension TasksViewController: TasksRouterToViewProtocol {
    func navgate(to controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - TasksPresenterToViewProtocol

extension TasksViewController: TasksPresenterToViewProtocol {
    func commonInit() {
        title = "Задачи"
        
        view.backgroundColor = Color.black
        
        view.addGestureRecognizer(tap)
        view.addSubview(textField)
        view.addSubview(tableView)
        
        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(36)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).inset(-16)
            $0.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        tabBarController?.view.addSubview(selectTaskView)
        
        selectTaskView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func setupTabBar() {
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        let backTabBarView = UIView()
        backTabBarView.frame = tabBarController?.tabBar.bounds ?? CGRect.zero
        backTabBarView.setBlurEffect()
        
        tabBarController?.tabBar.addSubview(backTabBarView)
        tabBarController?.tabBar.addSubview(countLabel)
        tabBarController?.tabBar.addSubview(addNewFolderButton)
        
        tableView.snp.remakeConstraints {
            $0.top.equalTo(textField.snp.bottom).inset(-16)
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().inset(backTabBarView.frame.height)
        }
        view.layoutIfNeeded()
    }
    
    func updateTableView() {
        countLabel.configurate(presenter?.getCountTasks() ?? 0)
        tableView.reloadData()
    }
    
    func updateCell(for index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func showTaskWithMenu(for index: Int) {
        guard let task = presenter?.getTask(for: index) else { return }
        selectTaskView.configurate(title: task.todo ?? "",
                                   description: task.descriptions ?? "",
                                   date: task.date ?? Date())
        let frame = tableView.rectForRow(at: IndexPath(row: index, section: 0))
        selectTaskView.showSelectTaskView(frame: tableView.convert(frame, to: tableView.superview))
    }
}
