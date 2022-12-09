//
//  StoryboardName.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 02/03/2022.
//

import Foundation

enum PluginStoryboard: String {
    case biometricVerification = "BiometricVerification"
    case cnicUpload = "CNICUpload"
    case openAccount = "OpenAccount"
    case freelancer = "Freelancer"
    case remittanceAccount = "RemittanceAccount"
    case currentAccount = "CurrentAccount"
    
    var name: String {
        switch self {
        case .biometricVerification:
            return PluginStoryboard.biometricVerification.rawValue
        case .cnicUpload:
            return PluginStoryboard.cnicUpload.rawValue
        case .openAccount:
            return PluginStoryboard.openAccount.rawValue
        case .freelancer:
            return PluginStoryboard.freelancer.rawValue
        case .remittanceAccount:
            return PluginStoryboard.remittanceAccount.rawValue
        case .currentAccount:
            return PluginStoryboard.currentAccount.rawValue
        }
    }
}
