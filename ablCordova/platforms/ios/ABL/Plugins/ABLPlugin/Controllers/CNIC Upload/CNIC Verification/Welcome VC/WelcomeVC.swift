//
//  WelcomeVC.swift
//  ABL
//
//  Created by Hamza Amin on 6/16/22.
//

import UIKit

class WelcomeVC: UIViewController {
    
    @IBOutlet weak var emailStack: UIStackView!
    @IBOutlet weak var phoneNumberStack: UIStackView!
    @IBOutlet weak var helpLineNumber: LabelSetting!
    @IBOutlet weak var email: LabelSetting!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataCacheManager.shared.saveNoOfJointApplicants(input: 0)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        
        openAvailabilityVC()
        
    }
    @IBAction func backTapped(_ sender: UIButton) {
        
        self.view.window?.rootViewController?.dismiss(animated: true)
        
    }
    private func openAvailabilityVC() {
//                let vc = UIStoryboard.init(name: "OpenAccount", bundle: nil).instantiateViewController(withIdentifier: "PictureAndSignatureVC") as? PictureAndSignatureVC
//                self.navigationController?.pushViewController(vc!, animated: true)
//        
//                //Shakeel Test
//                return()
        guard let verifyOTPVC = UIStoryboard.initialize(
            viewController: .cnicAvailabilityVC,
            fromStoryboard: .cnicUpload
        ) as? CNICAvailabilityVC else { return }
        navigationController?.pushViewController(verifyOTPVC, animated: true)
    }
    
    //Irfan
    
    private func setupGestureRecognizers() {
        
        let helpLineNumbertap = UITapGestureRecognizer(target: self, action: #selector(openNumberInNumPad))
        
        helpLineNumber.isUserInteractionEnabled = true
        
        helpLineNumber.addGestureRecognizer(helpLineNumbertap)
        
        
        
        let emailtap = UITapGestureRecognizer(target: self, action: #selector(openEmail))
        
        email.isUserInteractionEnabled = true
        
        email.addGestureRecognizer(emailtap)
        
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
        
        if let appURL = URL(string: "mailto:\(email.text!)"){
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL)
            }
        }
    }
    
    @IBAction func twitterTapped(_ sender: Any) {
        let url = URL(string: "https://twitter.com/ablpk")
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!)
        }
    }
    
    @IBAction func facebookTapped(_ sender: Any) {
        let url = URL(string: "https://www.facebook.com/alliedbankpk")
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!)
        }
    }
    
    @IBAction func youtubeTapped(_ sender: Any) {
        let url = URL(string: "https://www.youtube.com/user/alliedbankltd")
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!)
        }
    }
    
    @IBAction func instagramTapped(_ sender: Any) {
        let url = URL(string: "https://www.instagram.com/ablpk/")
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!)
        }
    }
    
    @IBAction func linkedinTapped(_ sender: Any) {
        let url = URL(string: "https://www.linkedin.com/company/allied-bank-limited/")
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!)
        }
    }
    
    @IBAction func whatsappTapped(_ sender: Any) {
        let url = URL(string: "https://api.whatsapp.com/send?phone=+923001225225")
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!)
        }
    }
    
}
