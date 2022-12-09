//
//  PersonalInformationFirstVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/03/2022.
//

import UIKit

 final class PersonalInformationFirstVC: UIViewController {
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var fathersNameTextField: UITextField!
    @IBOutlet weak var cnicIssueTextField: UITextField!
    @IBOutlet weak var cnicExpiryTextField: UITextField!
    
    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton){
        
        delegate?.addChild(vc: .personalInformationSecondVC, fromViewController: "")
        
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton){
        
        
    }
    
    private func openPersonalInformationSecondVC() {
        guard let verifyOTPVC = UIStoryboard.initialize(
            viewController: .personalInformationSecondVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationSecondVC else { return }
        navigationController?.pushViewController(verifyOTPVC, animated: true)
    }
}
