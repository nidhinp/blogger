//
//  Double+Extentsions.swift
//  Consumer
//
//  Created by Q8coders on 5/15/17.
//  Copyright © 2017 Q8coders. All rights reserved.
//

import Foundation

extension Double {
    func percentage() -> String {
        let stringValue = "\(self)".components(separatedBy: ".")[1]
        if stringValue == "0" {
            return "100%"
        }
        let startIndex = stringValue.index(stringValue.startIndex, offsetBy: 2)
        return String(stringValue[..<startIndex]) + "%"
    }
    
    func epochTimeToDateString() -> String {
        let date = Date(timeIntervalSince1970: self)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
