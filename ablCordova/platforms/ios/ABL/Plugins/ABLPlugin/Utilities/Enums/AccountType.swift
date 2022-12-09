//
//  AccountType.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 30/03/2022.
//

import Foundation

enum AccountType {
    case current
    case savings
    
    var code: Double {
        switch self {
        case .current:
            return 114301
        case .savings:
            return 114302
        }
    }
    
    static func getDescription(for code: Double) -> String {
        switch code {
        case AccountType.current.code:
            return "Current"
        case AccountType.savings.code:
            return "Savings"
        default:
            return "N/A"
        }
    }
}
