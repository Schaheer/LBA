//
//  PluginUtils.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 03/03/2022.
//

import UIKit

struct PluginUtils {
    
    static var appWindow: UIWindow {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return UIWindow() }
        return window
    }
    
    static func navigationTransition(animation: UIView.AnimationOptions) {
        UIView.transition(
            with: appWindow,
            duration: 0.3,
            options: animation,
            animations: nil,
            completion: nil
        )
    }
    
    static func makeRootVC(viewController: UIViewController) {
        appWindow.rootViewController = viewController
        navigationTransition(animation: .transitionCrossDissolve)
    }
}
