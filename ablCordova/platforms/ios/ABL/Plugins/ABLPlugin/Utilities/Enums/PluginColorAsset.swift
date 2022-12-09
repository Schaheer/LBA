//
//  PluginColorAsset.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 04/03/2022.
//

import UIKit

enum PluginColorAsset: String {
    case appCTABlue = "App CTA Blue"
    case appCTABorder = "App CTA Border"
    case appOrange = "App Orange"
    case otpFieldBorder = "OTP Field Border"
    case textfieldLineBlack = "Textfield Line Black"
    case textfieldPlaceholder = "Textfield Placeholder"
    case appRed = "App Red"
    case alliedBlue = "Allied Blue"
    case appBackground = "App Background"
    
    var color: UIColor {
        switch self {
        case .appCTABlue:
            return UIColor(named: PluginColorAsset.appCTABlue.rawValue) ?? UIColor()
        case .appCTABorder:
            return UIColor(named: PluginColorAsset.appCTABorder.rawValue) ?? UIColor()
        case .appOrange:
            return UIColor(named: PluginColorAsset.appOrange.rawValue) ?? UIColor()
        case .otpFieldBorder:
            return UIColor(named: PluginColorAsset.otpFieldBorder.rawValue) ?? UIColor()
        case .textfieldLineBlack:
            return UIColor(named: PluginColorAsset.textfieldLineBlack.rawValue) ?? UIColor()
        case .textfieldPlaceholder:
            return UIColor(named: PluginColorAsset.textfieldPlaceholder.rawValue) ?? UIColor()
        case .appRed:
            return UIColor(named: PluginColorAsset.appRed.rawValue) ?? UIColor()
        case .alliedBlue:
            return UIColor(named: PluginColorAsset.alliedBlue.rawValue) ?? UIColor()
        case .appBackground:
            return UIColor(named: PluginColorAsset.appBackground.rawValue) ?? UIColor()
        }
    }
}
