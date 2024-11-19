//
//  UITextField + Extension.swift
//  ToDo
//
//  Created by Евгений Таракин on 20.11.2024.
//

import UIKit
import SnapKit

extension UITextField {
    func setGlassAndMicroImage() {
        let leftImageView = UIImageView()
        leftImageView.image = UIImage(systemName: "magnifyingglass")
        leftImageView.tintColor = Color.grayDoneText
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        leftView = leftPaddingView
        leftViewMode = .always
        
        leftPaddingView.addSubview(leftImageView)
        leftImageView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(6)
        }
        
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(systemName: "microphone.fill")
        rightImageView.tintColor = Color.grayDoneText
        
        let rightPaddingView = UIView(frame: CGRect(x: frame.width - 40, y: 0, width: 36, height: 36))
        rightView = rightPaddingView
        rightViewMode = .always
        
        rightPaddingView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(6)
        }
    }
}

