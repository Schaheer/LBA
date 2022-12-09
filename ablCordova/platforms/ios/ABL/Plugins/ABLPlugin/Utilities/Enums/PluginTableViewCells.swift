//
//  PluginTableViewCells.swift
//  ABL
//
//  Created by Hamza Amin on 4/26/22.
//

import Foundation

enum PluginTableViewCells: String{
    
    case fatcaTVC = "FATCATableViewCell"
    
    var id: String{
        switch self{
        case .fatcaTVC:
            return PluginTableViewCells.fatcaTVC.rawValue

        }
    }
}
