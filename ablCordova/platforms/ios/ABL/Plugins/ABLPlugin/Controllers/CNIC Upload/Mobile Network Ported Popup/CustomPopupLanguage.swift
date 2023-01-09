//
//  CustomPopupLanguage.swift
//  ABL
//
//  Created by Robin Yaqoob on 09/01/2023.
//

import UIKit

final class CustomPopupLanguage: UIViewController {

    var portedMobileNetwork: (() -> Void)?
    var titleString: String?
    var message: String?
    var buttonTitle: String?
    @IBOutlet weak var labelTitle: LabelSetting!
    @IBOutlet weak var labelMessage: LabelSetting!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if titleString != nil {
            labelTitle.text = titleString
        }
        if message != nil {
            labelMessage.text = message
        }
        if buttonTitle != nil {
            
            
        }
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
  
    @IBOutlet weak var buttonUrdu: UIButton!
    @IBAction func buttonUrdu(_ sender: Any) {
        funChangeAppLanguageAndSide(to: "ur", vc: self)
        
    }
    @IBOutlet weak var buttonEnglish: UIButton!
    @IBAction func buttonEnglish(_ sender: Any) {
        funChangeAppLanguageAndSide(to: "en", vc: self)
    }
}
