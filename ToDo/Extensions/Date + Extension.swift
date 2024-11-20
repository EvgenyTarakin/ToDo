//
//  Date + Extension.swift
//  ToDo
//
//  Created by Евгений Таракин on 19.11.2024.
//

import Foundation

extension Date {
    func getStringDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let string = formatter.string(from: self)
        let date = formatter.date(from: string)
        formatter.dateFormat = "dd.MM.yyyy"
        let stringDate = formatter.string(from: self)
        
        return stringDate
    }
}
