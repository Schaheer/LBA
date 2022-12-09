//
//  Double.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import Foundation

extension Double {
    
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
    
    func timeString() -> String {
        let minutes = Int(truncatingRemainder(dividingBy: 60 * 60) / 60)
        let hours = Int(self / 3600)
        
        return String(format: "%.2d:%.2d", hours, minutes)
    }
}
