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
        setupGestureRecognizers()
    }
    @IBOutlet weak var appEmail: LabelSetting!
    @IBOutlet weak var abmNumber: LabelSetting!
    
    @IBAction func noThanksTapped(_ sender: UIButton){
        
        navigationController?.popViewController(animated: true)
//        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    @IBAction func feedbackBtnTapped(_ sender: UIButton){
        
        //
    }
    
    
    //Irfan
    
    private func setupGestureRecognizers() {
        
        let helpLineNumbertap = UITapGestureRecognizer(target: self, action: #selector(openNumberInNumPad))
        
        abmNumber.isUserInteractionEnabled = true
        
        abmNumber.addGestureRecognizer(helpLineNumbertap)
        
        
        
        let emailtap = UITapGestureRecognizer(target: self, action: #selector(openEmail))
        
        appEmail.isUserInteractionEnabled = true
        
        appEmail.addGestureRecognizer(emailtap)
        
    }
    
    //Irfan
    
    @objc private func openNumberInNumPad() {
        let phoneNumber: String = "telprompt://111225225"
        
        if let appURL = URL(string: phoneNumber){
            
            
            
            if #available(iOS 10.0, *) {
                
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                
            } else {
                
                UIApplication.shared.openURL(appURL)
                
            }
            
        }
    }
    @objc private func openEmail() {
        
        if let appURL = URL(string: "mailto:\(appEmail.text!)"){
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL)
            }
        }
    }
}
