//
//  MenuButton.swift
//  ToDo
//
//  Created by Евгений Таракин on 15.11.2024.
//

import UIKit
import SnapKit

// MARK: - MenuButtonType

enum MenuButtonType {
    case edit
    case share
    case delete
    
    var title: String? {
        switch self {
        case .edit: return "Редактировать"
        case .share: return "Поделиться"
        case .delete: return "Удалить"
        }
    }
    
    var color: UIColor? {
        switch self {
        case .delete: return Color.red
        default: return Color.black
        }
    }
    
    var image: UIImage? {
        switch self {
        case .edit: return UIImage(named: "edit")
        case .share: return UIImage(named: "export")
        case .delete: return UIImage(named: "trash")
        }
    }
}

// MARK: - protocol

protocol MenuButtonDelegate: AnyObject {
    func didSelectButton(type: MenuButtonType)
}

final class MenuButton: UIView {
    
    // MARK: - property
    
    weak var delegate: MenuButtonDelegate?
    
    // MARK: - private property
    
    private var type: MenuButtonType?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = Color.clear
        button.setTitle("", for: .normal)
        button.setImage(UIImage(), for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        
        return label
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

extension MenuButton {
    func configurate(type: MenuButtonType) {
        self.type = type
        label.text = type.title
        label.textColor = type.color
        imageView.image = type.image
    }
}

// MARK: - private func

private extension MenuButton {
    func commonInit() {
        backgroundColor = Color.grayMenuButton
        
        addSubview(imageView)
        addSubview(label)
        addSubview(button)
        
        imageView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(16)
        }
        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.left.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - obj-c

@objc private extension MenuButton {
    func tapButton() {
        guard let type else { return }
        delegate?.didSelectButton(type: type)
    }
}
