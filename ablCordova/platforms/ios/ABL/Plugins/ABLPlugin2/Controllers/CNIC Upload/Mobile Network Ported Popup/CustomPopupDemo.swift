//
//  CustomPopupDemoVC.swift
//  ABL
//
//  Created by Muhammad Irfan - External on 23/12/2022.
//

import Foundation
import UIKit


final class CustomPopupDemoVC: UIViewController {
        
    var callBackContinueWithImage: (() -> ())!
    
    @IBAction func beginVerificationPressed(_ sender: Any) {
        self.dismiss(animated: true) {
            self.callBackContinueWithImage?()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
