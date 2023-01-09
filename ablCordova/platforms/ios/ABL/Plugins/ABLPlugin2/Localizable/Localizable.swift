//
//  Localization.swift
//  AABEngage
//
//  Created by Shakeel Ahmed on 25/10/2021.
//

import Foundation
import UIKit

struct LanguageModel {
    let name: String?
    let code: String?
    
    init(name: String, code: String) {
        self.name = name
        self.code = code
    }
}

extension String {
    func localizeString() -> String {
        let languageCode = Defaults.selectedLanguageCode

        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, bundle: bundle!, comment: "")
    }
}

//extension UIViewController {
func funChangeAppLanguageAndSide(to locale: String, vc: UIViewController?) {
    // to: language code
    
    // Persist
    Defaults.selectedLanguageCode = locale
    Defaults.selectedLanguage = locale == "ur" ? "Urdu" : "English"
    
    // Rewind
    vc?.navigationController?.popToRootViewController(animated: false)
    
    // UIView
    UIView.appearance().semanticContentAttribute = locale == "ur" ? .forceRightToLeft : .forceLeftToRight
    
    // UILabel
    UILabel.appearance().semanticContentAttribute = locale == "ur" ? .forceRightToLeft : .forceLeftToRight
    UILabel.appearance().textAlignment = .natural
    
    // UITextField
    UITextField.appearance().semanticContentAttribute = locale == "ur" ? .forceRightToLeft : .forceLeftToRight
    UITextField.appearance().textAlignment = locale == "ur" ? .right : .left
    
    
    // change root vc
    let objStoryboard = UIStoryboard.init(name: "CNICUpload", bundle: nil)
    let rootNav = objStoryboard.instantiateViewController(withIdentifier: "WelcomeNavigationViewController") as! UINavigationController
    UIApplication.shared.keyWindow?.rootViewController = rootNav
    UIApplication.shared.keyWindow?.makeKeyAndVisible()
    
    // update user defaults
    //        Defaults.selectedLanguageCode = locale
    //        Defaults.selectedLanguage = locale == "ar" ? "Arabic" : "English"
    
    
    //MARK: - View Side Change
    
    
    //MARK: - TextField Side Change
    
    //MARK: - Label Side Change
    
    //        UILabel.appearance().textAlignment = locale == "ur" ? .right : .left
    //        UILabel.appearance().textAlignment = UILabel.appearance().textAlignment == .center ? .center : locale == "ur" ? .right : .left
    
    
    //        let parent = view.superview
    //        view.removeFromSuperview()
    //        view = nil
    //        parent?.addSubview(view)
    
    // print(LocalizationSystem.sharedInstance.getLanguage())
}
//}

class Defaults {
    private static let SELECTED_LANGUAGE = "selected_language"
    private static let SELECTED_LANGUAGE_CODE = "selected_language_code"
    //    private static let LATITUDE = "lat"
    //    private static let LONGTITUDE = "lng"
    
    fileprivate static var userDefault: UserDefaults {
        get {
            return Foundation.UserDefaults.standard
        }
    }
    static var selectedLanguage: String {
        get {
            return Defaults.userDefault.object(forKey: SELECTED_LANGUAGE) == nil ? "English" : Defaults.userDefault.object(forKey: SELECTED_LANGUAGE) as! String // as? String?
        } set {
            Defaults.userDefault.set(newValue, forKey: SELECTED_LANGUAGE)
        }
    }
    
    static var selectedLanguageCode: String {
        get {
            
            if Defaults.userDefault.object(forKey: SELECTED_LANGUAGE_CODE) == nil {
                return "en"
            }
            else {
                return Defaults.userDefault.object(forKey: SELECTED_LANGUAGE_CODE) as? String == "ur" ? "ur" : "en" // as? String?
            }
        } set {
            Defaults.userDefault.set(newValue, forKey: SELECTED_LANGUAGE_CODE)
        }
    }
}
