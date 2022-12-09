//
//  PortedPopupVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 05/04/2022.
//

import UIKit

final class PortedPopupVC: UIViewController {
    
    var portedMobileNetwork: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
        dismiss(animated: true) {
            self.portedMobileNetwork?()
        }
    }
}
