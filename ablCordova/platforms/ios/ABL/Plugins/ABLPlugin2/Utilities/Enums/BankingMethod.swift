//
//  BankingMethod.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 30/03/2022.
//

import Foundation

enum BankingMethod {
    case islamic
    case conventional
    
    var code: Double {
        switch self {
        case .islamic:
            return 114202
        case .conventional:
            return 114201
        }
    }
    
    var categoryType: String {
        switch self {
        case .islamic:
            return "I"
        case .conventional:
            return "C"
        }
    }
    
    static func getDescription(for code: Double) -> String {
        switch code {
        case BankingMethod.islamic.code:
            return "Islamic"
        case BankingMethod.conventional.code:
            return "Conventional"
        default:
            return "N/A"
        }
    }
}
