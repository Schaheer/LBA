//
//  CustomPopupDemoVC.swift
//  ABL
//
//  Created by Muhammad Irfan - External on 23/12/2022.
//

import Foundation
import UIKit

protocol CustomPopupDemoVCDelegate{
    func continueToCamera()
}
final class CustomPopupDemoVC: UIViewController {
    
    var delegate: CustomPopupDemoVCDelegate? = nil
    
    @IBAction func beginVerificationPressed(_ sender: Any) {
        if self.delegate != nil {
            dismiss(animated: true)
            DispatchQueue.main.async {
                self.delegate?.continueToCamera()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
