//
//  NextOfKinVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/05/2022.
//

import UIKit

final class NextOfKinVC: UIViewController {
    
    @IBOutlet weak var kinNameTextField: UITextField!
    @IBOutlet weak var cnicTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    private let nextOfKinViewModel = NextOfKinViewModel()
    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        if let count = self.parent?.children.count {
            if count > 1 {
                self.delegate?.removeChild()
                self.parent?.children.last?.remove()
            } else {
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard
            let consumer = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last
        else { return }
        if kinNameTextField.text?.count == 0{
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please enter KIN Name first")
        }else if cnicTextField.text?.count == 0{
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please enter CNIC Number first")
        }else if mobileNumberTextField.text?.count == 0{
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please enter Mobile Number first")
        }else{
            nextOfKinViewModel.registerConsumerBasicInfo(
                customerAccInfoID: consumer.accountInformation?.rdaCustomerAccInfoID,
                customerProfileID: consumer.rdaCustomerProfileID,
                kinName: kinNameTextField.text ?? "",
                kinCNIC: cnicTextField.text ?? "",
                kinMobileNumber: mobileNumberTextField.text ?? "",
                isPrimary: true
            )
        }
    }
    
    private func subscribeViewModel() {
        nextOfKinViewModel.registerConsumerBasicInfoResponse.bind { [weak self] response in
            guard let self = self, let response = response else { return }
            guard
                let status = response.message?.status,
                let description = response.message?.description?.lowercased()
            else { return }
            
            if status == "200" && description == "success" {
                self.delegate?.addChild(vc: .pictureAndSignatureVC, fromViewController: "")
            }
        }
        
        nextOfKinViewModel.errorMessage.bind { error in
            guard let error = error else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: error)
        }
    }
}
