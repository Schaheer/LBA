//
//  PluginImageAsset.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 03/03/2022.
//

import UIKit

enum PluginImageAsset: String {
    case navbarRectangle = "navbar-rectangle"
    case myABLLogo = "myabl-logo"
    case navbarBackButton = "navbar-back-button"
    case radioFilled = "radio-filled"
    case radioUnfilled = "radio-unfilled"
    case asaanDigitalAccountText = "ada-text"
    case currentAccountText = "current-account-text"
    case checkIcon = "check-icon"
    case uncheckIcon = "uncheck-icon"
    
    var image: UIImage {
        switch self {
        case .navbarRectangle:
            return UIImage(named: PluginImageAsset.navbarRectangle.rawValue) ?? UIImage()
        case .myABLLogo:
            return UIImage(named: PluginImageAsset.myABLLogo.rawValue) ?? UIImage()
        case .navbarBackButton:
            return UIImage(named: PluginImageAsset.navbarBackButton.rawValue) ?? UIImage()
        case .radioFilled:
            return UIImage(named: PluginImageAsset.radioFilled.rawValue) ?? UIImage()
        case .radioUnfilled:
            return UIImage(named: PluginImageAsset.radioUnfilled.rawValue) ?? UIImage()
        case .asaanDigitalAccountText:
            return UIImage(named: PluginImageAsset.asaanDigitalAccountText.rawValue) ?? UIImage()
        case .currentAccountText:
            return UIImage(named: PluginImageAsset.currentAccountText.rawValue) ?? UIImage()
        case .checkIcon:
            return UIImage(named: PluginImageAsset.checkIcon.rawValue) ?? UIImage()
        case .uncheckIcon:
            return UIImage(named: PluginImageAsset.uncheckIcon.rawValue) ?? UIImage()
        }
    }
}
