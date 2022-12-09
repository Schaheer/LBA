//
//  PluginNibs.swift
//  ABL
//
//  Created by Hamza Amin on 4/26/22.
//

import Foundation

enum PluginNibs: String{
    
    case fatcaTVC = "FATCATableViewCell"
    
    var id: String{
        switch self {
        case .fatcaTVC:
            return PluginNibs.fatcaTVC.rawValue
        }
    }
    
}
