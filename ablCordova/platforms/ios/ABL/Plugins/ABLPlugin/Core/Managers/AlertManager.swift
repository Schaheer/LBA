//
//  AlertManager.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 09/03/2022.
//

import UIKit

final class AlertManager {
    
    private let superWindow = PluginUtils.appWindow
    
    static let shared: AlertManager = {
       return AlertManager()
    }()
    
    private var topController: UIViewController? {
        if var topController = self.superWindow.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            return topController
        }
        
        return nil
    }
    
    private init() {}
    
    func showOKAlert(with title: String? = "", message: String? = "") {
        
        DispatchQueue.main.async {
//            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//            let okAlertAction = UIAlertAction(title: "OK", style: .default)
//
//            alert.addAction(okAlertAction)
//
////            self.topController?.present(alert, animated: true)
            let portedPopupVC = UIStoryboard.init(name: "CNICUpload", bundle: nil).instantiateViewController(withIdentifier: "CustomPopup") as! CustomPopup

            portedPopupVC.titleString = title?.localizeString()
            portedPopupVC.message = message?.localizeString()
            portedPopupVC.buttonTitle = "OK".localizeString()
            portedPopupVC.portedMobileNetwork = {

            }
            self.topController?.present(portedPopupVC, animated: true)
        }
        
//        {
//            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
//
//            let titFont = [NSAttributedString.Key.font: UIFont(name: "ArialHebrew-Bold", size: 15.0)!]
//            let msgFont = [NSAttributedString.Key.font: UIFont(name: "Avenir-Roman", size: 13.0)!]
//            let messageAttrString = NSMutableAttributedString(string: message ?? "", attributes: msgFont as [NSAttributedString.Key : Any])
//            let titleAttrString = NSMutableAttributedString(string: title ?? "", attributes: titFont as [NSAttributedString.Key : Any])
//
//            alert.setValue(messageAttrString, forKey: "attributedMessage")
//            alert.setValue(titleAttrString, forKey: "attributedTitle")
//
//            let okAlertAction = UIAlertAction(title: "OK", style: .default)
//
//            alert.addAction(okAlertAction)
//
//            self.topController?.present(alert, animated: true)
//        }
    }
    
    func showOkAlert(title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

//        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        var rootViewController = UIApplication.shared.keyWindow?.rootViewController

        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }

        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }

       // rootViewController?.present(alertController, animated: true, completion: nil)
        
        let portedPopupVC = UIStoryboard.init(name: "CNICUpload", bundle: nil).instantiateViewController(withIdentifier: "CustomPopup") as! CustomPopup

        portedPopupVC.titleString = title
        portedPopupVC.message = message
        portedPopupVC.buttonTitle = "OK"
        portedPopupVC.portedMobileNetwork = {

        }
        rootViewController?.present(portedPopupVC, animated: true)
    }
    
    func showOkAlertWithViewFingerprintsOption(title: String, message: String, handler: @escaping (UIAlertAction) -> ()) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "View Fingerprints", style: UIAlertAction.Style.default, handler: handler))
        
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        
        rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func showLocationAuthorizationAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Allow Location Access",
                message: "myABL needs access to your location. Turn on Location Services in your device settings.",
                preferredStyle: .alert
            )
            
            // Button to Open Settings
            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }
            }))
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.topController?.present(alert, animated: true)
        }
    }
    
    func showBasicChoiceAlert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAlertAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
            let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            alert.addAction(okAlertAction)
            alert.addAction(cancelAlertAction)
            
            self.topController?.present(alert, animated: true)
        }
    }
    
    func showOKChoiceAlert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAlertAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
            
            alert.addAction(okAlertAction)
            
            self.topController?.present(alert, animated: true)
        }
    }
}
