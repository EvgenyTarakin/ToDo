//
//  TaskCell.swift
//  ToDo
//
//  Created by Евгений Таракин on 15.11.2024.
//

import UIKit
import SnapKit

// MARK: - protocol

protocol TaskCellDelegate: AnyObject {
    func didTapCell(index: Int)
    func didTapCheckButton(index: Int)
    func didLongPressCell(index: Int)
}

final class TaskCell: UITableViewCell {
    
    // MARK: - property
    
    static let reuseIdentifier = String(describing: TaskCell.self)
    
    weak var delegate: TaskCellDelegate?
    
    // MARK: - private property
    
    private var index = 0
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(tapCell))
    
    private lazy var longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressCell))
    
    private lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "circle")
        
        return imageView
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(), for: .normal)
        button.addTarget(self, action: #selector(tapCheckButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, dateLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 6
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
        }
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(16)
        }
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Color.grayDoneText
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = Color.gray
        
        return separatorView
    }()

    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - override func
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        descriptionLabel.text = ""
        dateLabel.text = ""
        checkImageView.image = UIImage(named: "circle")
    }

}

// MARK: - func

extension TaskCell {
    func configurate(index: Int, title: String, description: String, date: Date, isCompleted: Bool = false) {
        self.index = index
        
        if isCompleted {
            titleLabel.attributedText = title.strikeThrough()
        } else {
            titleLabel.attributedText = title.deleteStrikeThrough()
        }
        titleLabel.textColor = isCompleted ? Color.grayDoneText : Color.grayProgressText
        
        descriptionLabel.text = description
        descriptionLabel.textColor = isCompleted ? Color.grayDoneText : Color.grayProgressText
        dateLabel.text = date.getStringDate()
        
        checkImageView.image = UIImage(named: isCompleted ? "check.circle" : "circle")
    }
}

// MARK: - private func

private extension TaskCell {
    func commonInit() {
        selectionStyle = .none
        
        contentView.addGestureRecognizer(tap)
        contentView.addGestureRecognizer(longPressGestureRecognizer)
        
        contentView.addSubview(checkImageView)
        contentView.addSubview(checkButton)
        contentView.addSubview(separatorView)
        contentView.addSubview(labelStackView)
        
        checkImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.left.equalToSuperview().inset(20)
            $0.height.width.equalTo(24)
        }
        checkButton.snp.makeConstraints {
            $0.center.equalTo(checkImageView)
            $0.height.width.equalTo(32)
        }
        separatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        labelStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.bottom.equalTo(separatorView.snp.top).inset(-12)
            $0.left.equalTo(checkImageView.snp.right).inset(-8)
            $0.right.equalToSuperview().inset(20)
        }
    }
}

// MARK: - obj-c

@objc private extension TaskCell {
    func tapCell() {
        delegate?.didTapCell(index: index)
    }
    
    func tapCheckButton() {
        delegate?.didTapCheckButton(index: index)
    }
    
    func longPressCell() {
        delegate?.didLongPressCell(index: index)
    }
}
