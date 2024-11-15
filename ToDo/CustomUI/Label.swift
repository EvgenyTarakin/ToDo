//
//  Label.swift
//  ToDo
//
//  Created by Евгений Таракин on 15.11.2024.
//

import UIKit

final class Label: UIView {
    
//    MARK: - property
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

//    MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    MARK: - private func
    
    private func commonInit() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
//    MARK: - func
    
    func configurate(_ count: Int) {
        switch count {
        case 1: label.text = "\(count) Задача"
        case 2...4: label.text = "\(count) Задачи"
        default: label.text = "\(count) Задач"
        }
    }

}
