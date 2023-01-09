//
//  NatureOfAccount.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 06/05/2022.
//

import Foundation

enum NatureOfAccount: String {
    case single = "Single"
    case joint = "Joint"
    case minor = "Minor"
    
    var code: Double {
        switch self {
        case .single:
            return 102101
        case .joint:
            return 102102
        case .minor:
            return 102103
        }
    }
    
    static func getDescription(for code: Double) -> String {
        switch code {
        case NatureOfAccount.single.code:
            return NatureOfAccount.single.rawValue
        case NatureOfAccount.joint.code:
            return NatureOfAccount.joint.rawValue
        case NatureOfAccount.minor.code:
            return NatureOfAccount.minor.rawValue
        default:
            return "N/A"
        }
    }
}
