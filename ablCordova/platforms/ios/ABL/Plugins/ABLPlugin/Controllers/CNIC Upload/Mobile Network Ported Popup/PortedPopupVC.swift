//
//  PortedPopupVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 05/04/2022.
//

import UIKit

final class PortedPopupVC: UIViewController {
    
    var portedMobileNetwork: (() -> Void)?
    var message: String?
    var buttonTitle: String?
    @IBOutlet weak var doneButton: ButtonSetting!
    @IBOutlet weak var labelMessage: LabelSetting!
    
   
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if message != nil {
            labelMessage.text = message
        }
        if buttonTitle != nil {
            doneButton.setTitle(buttonTitle, for: .normal)
        }
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
        dismiss(animated: true) {
            self.portedMobileNetwork?()
        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true) {
            self.portedMobileNetwork?()
        }
    }
}
