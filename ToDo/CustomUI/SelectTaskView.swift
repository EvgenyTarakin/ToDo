//
//  SelectTaskView.swift
//  ToDo
//
//  Created by Евгений Таракин on 15.11.2024.
//

import UIKit
import SnapKit

// MARK: - protocol

protocol SelectTaskViewDelegate: AnyObject {
    func didSelectEditButton()
    func didSelectShareButton()
    func didSelectDeleteButton()
}

final class SelectTaskView: UIView {
    
    // MARK: - property
    
    weak var delegate: SelectTaskViewDelegate?
    
    // MARK: - private property
    
    private var isAnimated = false
    
    private var startFrame: CGRect?
    
    private lazy var tapEditView = UITapGestureRecognizer(target: self, action: #selector(hideEditView))
    
    private lazy var backView: UIView = {
        let backView = UIView()
        backView.backgroundColor = Color.graySelectTask
        backView.layer.cornerRadius = 12
        backView.addSubview(labelStackView)
        
        labelStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.right.left.equalToSuperview().inset(16)
        }
        
        return backView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTaskLabel, descriptionTaskLabel, dateTaskLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 6
        
        titleTaskLabel.snp.makeConstraints {
            $0.height.equalTo(24)
        }
        dateTaskLabel.snp.makeConstraints {
            $0.height.equalTo(16)
        }
        
        return stackView
    }()
    
    private lazy var titleTaskLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = Color.grayProgressText
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var descriptionTaskLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Color.grayProgressText
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var dateTaskLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Color.grayDoneText
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var buttonsBackView: UIView = {
        let backView = UIView()
        backView.backgroundColor = Color.graySeparatorMenu
        backView.layer.cornerRadius = 12
        backView.clipsToBounds = true
        backView.isHidden = true
        backView.addSubview(buttonStackView)
        
        buttonStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        return backView
    }()
    
    // MARK: - Menu
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [editMenuButton, shareMenuButton, deleteMenuButton])
        stackView.backgroundColor = Color.clear
        stackView.layer.cornerRadius = 12
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 1
        
        editMenuButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        return stackView
    }()
    
    private lazy var editMenuButton: MenuButton = {
        let button = MenuButton()
        button.configurate(type: .edit)
        button.delegate = self
        
        return button
    }()
    
    private lazy var shareMenuButton: MenuButton = {
        let button = MenuButton()
        button.configurate(type: .share)
        button.delegate = self
        
        return button
    }()
    
    private lazy var deleteMenuButton: MenuButton = {
        let button = MenuButton()
        button.configurate(type: .delete)
        button.delegate = self
        
        return button
    }()

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - func

extension SelectTaskView {
    func configurate(title: String, description: String, date: Date) {
        titleTaskLabel.text = title
        descriptionTaskLabel.text = description
        dateTaskLabel.text = date.getStringDate()
    }
    
    func showSelectTaskView(frame: CGRect) {
        if !isAnimated {
            isHidden = false
            startFrame = frame
            backView.frame = frame
            backView.frame.origin.x += 20
            backView.frame.size.width -= 40
            showEditCellView()
        }
    }
}

// MARK: - private func

private extension SelectTaskView {
    func commonInit() {
        setBlurEffect()
        isHidden = true
        addGestureRecognizer(tapEditView)
        
        addSubview(backView)
        addSubview(buttonsBackView)
        
        buttonsBackView.snp.makeConstraints {
            $0.top.equalTo(backView.snp.bottom).inset(-16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(254)
        }
    }
    
    func showEditCellView() {
        isAnimated = true
        UIView.animate(withDuration: 0.15, animations: {
            self.backView.frame.origin.y = self.center.y - self.backView.frame.height / 2
        }, completion: { _ in
            self.buttonsBackView.isHidden = false
        })
    }
}

// MARK: - obj-c

@objc private extension SelectTaskView {
    func hideEditView() {
        buttonsBackView.isHidden = true
        isAnimated = false
        UIView.animate(withDuration: 0.15, animations: {
            self.backView.frame.origin.y = self.startFrame?.origin.y ?? 0
        }, completion: { _ in
            self.isHidden = true
        })
    }
}

// MARK: - MenuButtonDelegate

extension SelectTaskView: MenuButtonDelegate {
    func didSelectButton(type: MenuButtonType) {
        buttonsBackView.isHidden = true
        isAnimated = false
        UIView.animate(withDuration: 0.15, animations: {
            self.backView.frame.origin.y = self.startFrame?.origin.y ?? 0
        }, completion: { _ in
            self.isHidden = true
            
            switch type {
            case .edit: self.delegate?.didSelectEditButton()
            case .share: self.delegate?.didSelectShareButton()
            case .delete: self.delegate?.didSelectDeleteButton()
            }
        })
    }
}
