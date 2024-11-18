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
    func updateTableView(_ todo: [Todo])
}

protocol TasksRouterToViewProtocol: AnyObject {
    
}

final class TasksViewController: UIViewController {
    
    // MARK: - property
    
    var presenter: TasksViewToPresenterProtocol?
    
    private var tasks: [Todo] = []
    
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
    
    private lazy var selectTaskView: SelectTaskView = {
        let selectTaskView = SelectTaskView()
        selectTaskView.isHidden = true
        selectTaskView.delegate = self
        
        return selectTaskView
    }()

    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

}

// MARK: - private func

private extension TasksViewController {
    func commonInit() {
        title = "Задачи"
        
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.subviews.forEach {
            $0.removeFromSuperview()
        }

        tabBarController?.tabBar.addSubview(countLabel)
        tabBarController?.tabBar.addSubview(addNewFolderButton)
        
        view.backgroundColor = Color.black
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        tabBarController?.view.addSubview(selectTaskView)
        
        selectTaskView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        presenter?.loadTasks()
    }

}

// MARK: - obj-c

@objc private extension TasksViewController {

}

// MARK: - UITableViewDelegate

extension TasksViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier, for: indexPath) as? TaskCell
        else { return UITableViewCell() }
        let task = tasks[indexPath.row]
        cell.configurate(index: indexPath.row,
                         title: task.todo,
                         description: task.todo,
                         date: "test",
                         isCompleted: task.completed)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - TaskCellDelegate

extension TasksViewController: TaskCellDelegate {
    func didTapCheckButton(index: Int) {
        tasks[index].completed.toggle()
        tableView.reloadData()
    }
    
    func didLongPressCell(index: Int) {
        let frame = tableView.rectForRow(at: IndexPath(row: index, section: 0))
        selectTaskView.showSelectTaskView(frame: tableView.convert(frame, to: tableView.superview))
    }
}

// MARK: - ButtonDelegate

extension TasksViewController: ButtonDelegate {
    func didSelectButton() {
        let controller = DetailTaskViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - SelectTaskViewDelegate

extension TasksViewController: SelectTaskViewDelegate {
    func didSelectEditButton() {
        
    }
    
    func didSelectShareButton() {
        
    }
    
    func didSelectDeleteButton() {
        
    }
}

// MARK: - TasksRouterToViewProtocol

extension TasksViewController: TasksRouterToViewProtocol {

}

// MARK: - TasksPresenterToViewProtocol

extension TasksViewController: TasksPresenterToViewProtocol {
    func updateTableView(_ todo: [Todo]) {
        tasks = todo
        countLabel.configurate(tasks.count)
        tableView.reloadData()
    }
}
