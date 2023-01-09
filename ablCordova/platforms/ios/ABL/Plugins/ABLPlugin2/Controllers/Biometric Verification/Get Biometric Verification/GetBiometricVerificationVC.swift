//
//  FirstVC.swift
//  TestCordovaApp
//
//  Created by Muhammad Shayan Zahid on 28/02/2022.
//

import UIKit

final class GetBiometricVerificationVC: UIViewController {
    
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var accountNumberTextField: UITextField!
    
    @IBOutlet weak var cnicNumberLabel: UILabel!
    @IBOutlet weak var cnicNumberTextField: UITextField!
    
    private let getBiometricVerificationViewModel = GetBiometricVerificationViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountNumberLabel.makeAttributedText(stringToColor: "*")
        cnicNumberLabel.makeAttributedText(stringToColor: "*")
        
        subscribeViewModel()
        
        accountNumberTextField.delegate = self
        cnicNumberTextField.delegate = self

    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if cnicNumberTextField.text?.count == 0{
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please Enter CNIC Number first")
            return
        }else if accountNumberTextField.text?.count == 0{
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please Enter Account Number first")
            return
        }
        guard
            let cnic = cnicNumberTextField.text,
            let accountNumber = accountNumberTextField.text
        else { return }
        
        if !cnic.isEmpty && !accountNumber.isEmpty {
            getBiometricVerificationViewModel.requestBiometricVerification(
                cnic: cnic,
                accountNumber: accountNumber
            )
        } else {
            AlertManager.shared.showOKAlert(
                with: BaseConstants.SharedError.error,
                message: BaseConstants.SharedError.enterValidInfo
            )
        }
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    private func openVerifyOTPVC() {
        guard let input = self.getBiometricVerificationViewModel.getRequestBiometricInputModel() else { return }
        guard let verifyOTPVC = UIStoryboard.initialize(
            viewController: .verifyOTPVC,
            fromStoryboard: .biometricVerification
        ) as? VerifyOTPVC else { return }
        
        verifyOTPVC.requestBiometricInputModel = input
        navigationController?.pushViewController(verifyOTPVC, animated: true)
    }
    
    private func subscribeViewModel() {
        
        getBiometricVerificationViewModel.userData.bind { [weak self] userData in
            guard let self = self, let userData = userData else { return }
            DataCacheManager.shared.saveUserData(userData: userData)
            DataCacheManager.shared.setAuthHeaders(
                for: "Authorization",
                value: "Bearer \(userData.accessToken ?? "")"
            )
            
            self.getBiometricVerificationViewModel.openVerifyOTPVC()
        }
        
        getBiometricVerificationViewModel.routeToVerifyOTP.bind { [weak self] shouldRoute in
            guard let self = self else { return }
            
            if shouldRoute {
                self.openVerifyOTPVC()
            }
        }
    }
}

extension GetBiometricVerificationVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == accountNumberTextField{
            
            guard let textFieldText = textField.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 16
        }else {
            
            guard let textFieldText = textField.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 13
        }

    }
}
