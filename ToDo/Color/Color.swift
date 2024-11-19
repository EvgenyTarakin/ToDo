//
//  Color.swift
//  Events_ios
//
//  Created by Евгений Таракин on 12.09.2022.
//
 
import UIKit

struct Color {
    
    // MARK: - Main colors
    
    static var clear: UIColor { return UIColor.clear }
    static var white: UIColor { return UIColor(hex: "FFFFFF") }
    static var black: UIColor { return UIColor(hex: "000000") }
    
    // MARK: - gray
    
    static var gray: UIColor { return UIColor(hex: "4D555E") }
    static var grayProgressText: UIColor { return UIColor(hex: "F4F4F4") }
    static var grayDoneText: UIColor { return UIColor(hex: "7C7C7C") }
    static var graySelectTask: UIColor { return UIColor(hex: "272729")}
    static var grayMenuButton: UIColor { return UIColor(hex: "EDEDED", alpha: 0.8) }
    static var graySeparatorMenu: UIColor { return UIColor(hex: "4D555E", alpha: 0.5) }
    
    // MARK: - yellow
    
    static var yellow: UIColor { return UIColor(hex: "FED702") }
    
    // MARK: - red
    
    static var red: UIColor { return UIColor(hex: "D70015") }
    
}
