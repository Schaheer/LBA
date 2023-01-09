//
//  UIStoryboard.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 02/03/2022.
//

import UIKit

extension UIStoryboard {
    
    class func initialize(viewController: PluginViewController, fromStoryboard: PluginStoryboard) -> UIViewController {
        let storyboard = self.init(name: fromStoryboard.name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: viewController.id)
        
        return vc
    }
}
