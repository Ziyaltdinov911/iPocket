//
//  Date.ext.swift
//  iPocket
//
//  Created by KAMA . on 03.05.2025.
//

import UIKit

extension Date {
    func getDateDifference() -> String {
        let curentDateInterval = Int(Date().timeIntervalSinceReferenceDate)
        let dateDifferences = Double(curentDateInterval - Int(self.timeIntervalSinceReferenceDate))
        let dateDifferencesDate = Int(round (dateDifferences/86400))
        switch dateDifferencesDate {
        case 0:
            return "Сегодня"
        case 1:
            return "Вчера"
        case 2...4:
            return "\(dateDifferencesDate) дня назад"
        default:
            return "\(dateDifferencesDate) дней назад"
        }
    }
    
    func formattDate(formatType: DeteFormatType = .full) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru")
        
        formatter.dateFormat = "dd MMMM yyyy"
        
        switch formatType {
            
        case .full:
            formatter.dateFormat = "dd MMMM yyyy"

        case .onlyDate:
            formatter.dateFormat = "dd MMMM"

        case .onlyYear:
            formatter.dateFormat = "yyyy"

        }
        
        return formatter.string(from: self)
    }
    
    func getOnlyYear() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru")
        formatter.dateFormat = "dd MMMM yyyy"
        
        return formatter.string(from: self)

    }
    
}

enum DeteFormatType {
    case full, onlyDate, onlyYear
}
