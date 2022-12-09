//
//  PluginFonts.swift
//  ABL
//
//  Created by Hamza Amin on 4/26/22.
//

import Foundation

enum PluginFonts: String{
    
    case workSansReg14 = "WorkSans-Regular"
    case latoBlack = "Lato-Black"
    case latoBlackItalic = "Lato-BlackItalic"
    case latoBold = "Lato-Bold"
    case latoBoldItalic = "Lato-BoldItalic"
    case latoItalic = "Lato-Italic"
    case latoLight = "Lato-Light"
    case latoLightItalic = "Lato-LightItalic"
    case latoRegular = "Lato-Regular"
    case latoThin = "Lato-Thin"
    case latoThinItalic = "Lato-ThinItalic"
    
    var font: UIFont{
        switch self {
        case .workSansReg14:
            return UIFont(name: PluginFonts.workSansReg14.rawValue, size: 14) ?? .systemFont(ofSize: 14)
        case .latoBlack:
            return UIFont(name: PluginFonts.latoBlack.rawValue, size: 14) ?? UIFont()
        case .latoBlackItalic:
            return UIFont(name: PluginFonts.latoBlackItalic.rawValue, size: 14) ?? UIFont()
        case .latoBold:
            return UIFont(name: PluginFonts.latoBold.rawValue, size: 14) ?? UIFont()
        case .latoBoldItalic:
            return UIFont(name: PluginFonts.latoBoldItalic.rawValue, size: 14) ?? UIFont()
        case .latoItalic:
            return UIFont(name: PluginFonts.latoItalic.rawValue, size: 14) ?? UIFont()
        case .latoLight:
            return UIFont(name: PluginFonts.latoLight.rawValue, size: 14) ?? UIFont()
        case .latoLightItalic:
            return UIFont(name: PluginFonts.latoLightItalic.rawValue, size: 14) ?? UIFont()
        case .latoRegular:
            return UIFont(name: PluginFonts.latoRegular.rawValue, size: 14) ?? UIFont()
        case .latoThin:
            return UIFont(name: PluginFonts.latoThin.rawValue, size: 14) ?? UIFont()
        case .latoThinItalic:
            return UIFont(name: PluginFonts.latoThinItalic.rawValue, size: 14) ?? UIFont()
        }
    }
}
