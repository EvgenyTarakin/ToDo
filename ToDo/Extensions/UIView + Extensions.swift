//
//  UIView + Extensions.swift
//  PaperForge_ios
//
//  Created by Евгений Таракин on 24.10.2024.
//

import UIKit

extension UIView {
    func setBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
