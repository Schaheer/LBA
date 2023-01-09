//
//  OpenAccountThreeViewController.swift
//  ABL
//
//  Created by Hamza Amin on 3/3/22.
//

import UIKit

class BiometricVerificationSuccessVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
}
