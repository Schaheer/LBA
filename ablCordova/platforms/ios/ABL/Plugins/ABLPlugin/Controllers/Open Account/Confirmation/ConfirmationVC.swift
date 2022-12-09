//
//  ConfirmationVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 14/04/2022.
//

import UIKit

final class ConfirmationVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func noThanksTapped(_ sender: UIButton){
        
        navigationController?.popViewController(animated: true)
//        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    @IBAction func feedbackBtnTapped(_ sender: UIButton){
        
        //
    }
}
