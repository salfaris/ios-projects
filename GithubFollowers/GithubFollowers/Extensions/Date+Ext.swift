//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Salman Faris on 18/10/2020.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
