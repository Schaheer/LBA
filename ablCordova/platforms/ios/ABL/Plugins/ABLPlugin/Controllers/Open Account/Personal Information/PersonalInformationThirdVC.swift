//
//  PersonalInformationThirdVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/03/2022.
//

import UIKit

//protocol PersonalInfoThirdToBaseProtocol: AnyObject{
//
//    func nextBtnTapped()
//}

final class PersonalInformationThirdVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lanlineNumTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var nearestLandmaarkTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    
    
    var isEditFromReviewDetailsViewController = false
    var forViewController = ""
    
    private var personalInformationViewModel = PersonalInformationViewModel()
    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        
        countryTextField.text = "Pakistan"
        countryTextField.isUserInteractionEnabled = false
        emailTextField.delegate = self
        lanlineNumTextField.delegate = self
        super.viewDidLoad()
        subscribeViewModel()
        prePopulateData()
        loadData()
    }
    
    
    @IBAction func nextBtnClicked(_ sender: UIButton){
        if validations() {
            callRegisterEmail()
        }
        //        callRegisterAddress()
    }
    
    @IBAction func backBtnClicked(_ snder: UIButton){
        if let count = self.parent?.children.count{
            if count > 1{
                self.delegate?.removeChild()
                self.parent?.children.last?.remove()
            }else{
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func loadData() {
        emailTextField.text = modelRegistrationSteper.emailOptional
        //        lanlineNumTextField.text = modelRegistrationSteper.landLineOptional
        addressTextField.text = modelRegistrationSteper.addressCurrent
        nearestLandmaarkTextField.text = modelRegistrationSteper.nearestLandMarkCurrent
        cityTextField.text = modelRegistrationSteper.cityCurrent
        townTextField.text = modelRegistrationSteper.townTehsilCurrent
    }
    
    private func prePopulateData() {
        if let data = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.first {
            addressTextField.text = data.addresses?.first?.customerAddress
            townTextField.text = data.addresses?.first?.customerTown
            nearestLandmaarkTextField.text = data.addresses?.first?.nearestLandMark
            cityTextField.text = data.addresses?.first?.city
            lanlineNumTextField.text = data.mobileNo
            //            countryTextField.text = data.addresses?.first?.country
            countryTextField.text = "Pakistan"
        }
    }
    
    private func callRegisterEmail() {
        
        personalInformationViewModel.registerConsumerEmail(
            customerAccInfoID: DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last?.accountInformation?.rdaCustomerAccInfoID,
            customerProfiledID: DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last?.rdaCustomerProfileID,
            emailAddress: emailTextField.text,
            isPrimary: true
        )
        modelRegistrationSteper.emailOptional = emailTextField.text
        modelRegistrationSteper.landLineOptionalCurrent = lanlineNumTextField.text
        modelRegistrationSteper.addressCurrent = addressTextField.text
        modelRegistrationSteper.nearestLandMarkCurrent = nearestLandmaarkTextField.text
        modelRegistrationSteper.cityCurrent = cityTextField.text
        modelRegistrationSteper.townTehsilCurrent = townTextField.text
        modelRegistrationSteper.country = countryTextField.text
    }
    
    func validations() -> Bool {
        if emailTextField.text != "" && !emailTextField.text!.isValidEmail{
            AlertManager.shared.showOKAlert(with: "Error", message: "Email is invalid")
            return false
        }
        //        if emailTextField.text == "" || !emailTextField.text!.isValidEmail{
        //            AlertManager.shared.showOKAlert(with: "Error", message: "Email is invalid")
        //            return false
        //        }
        else if lanlineNumTextField.text == "" {
            AlertManager.shared.showOKAlert(with: "Error", message: "Please enter landline number")
            return false
        }
        else if addressTextField.text == "" {
            AlertManager.shared.showOKAlert(with: "Error", message: "Address is missing")
            return false
        }
        else if nearestLandmaarkTextField.text == "" {
            AlertManager.shared.showOKAlert(with: "Error", message: "Enter nearest land mark")
            
            return false
        }
        else if cityTextField.text == "" {
            AlertManager.shared.showOKAlert(with: "Error", message: "Please enter city")
            
            return false
        }
        else if townTextField.text == "" {
            AlertManager.shared.showOKAlert(with: "Error", message: "Please enter town/tehsil")
            
            return false
        }
        else if countryTextField.text == "" {
            AlertManager.shared.showOKAlert(with: "Error", message: "Please enter country")
            
            return false
        }
        else {
            return true
        }
    }
    
    private func callRegisterAddress(){
        
        personalInformationViewModel.registerConsumerAddress(
            rdaCustomerId: BaseConstants.Config.rdaCustomerId,
            nearestLandMark: nearestLandmaarkTextField.text,
            customerAddress: addressTextField.text,
            city: cityTextField.text,
            addressTypeId: BaseConstants.CustomerAddress.currentAddressId,
            countryId: BaseConstants.CustomerAddress.countryId,
            rdaCustomerProfileAddrId: nil,
            postalCode: nil,
            phone: nil,
            mobileNo: nil,
            customerTown: nil,
            countryCodeMobile: nil,
            country: nil,
            addressTypeForeignInd: nil,
            emailAddress: nil,
            phoneNumber: nil
        )
    }
    
    private func subscribeViewModel() {
        personalInformationViewModel.registerConsumerEmailResponse.bind() { [weak self] response in
            
            guard let status = response?.message?.status, let description = response?.message?.description?.lowercased() else { return }
            if status == "200" && description.lowercased() == "success"{
                guard let accountVariantID = DataCacheManager.shared.loadAccountType() else {
                    
                    //Shakeel
                    //                    self?.delegate?.addChild(vc: .occupationVC)
                    self?.delegate?.addChild(vc: .nationalityVC, fromViewController: "")
                    return
                }
                print(accountVariantID)
                print(AccountVariant.currentAccount.id)
                print(AccountVariant.currentAccount)
                
                var results = []
                for i in (108243 ..< 108255) {
                    results.append(Double(i))
                }
                print(results)
                print(accountVariantID)
                print(AccountVariant.currentAccount.id)
                print(AccountVariant.currentAccount)
                //Shakeel
                //don't show residential address screen from ACCOUNT_VARIANT_ID 108243 to 108253
                //go directly to nationality in this scenario
                //never go to employment screen directly
                if (results.first{$0 as! Double == accountVariantID} != nil) {
                    self?.callRegisterAddress()
                }
                else {
                    self?.delegate?.addChild(vc: .registerPermanentAddress, fromViewController: "")
                }
                
                //                if accountVariantID == AccountVariant.currentAccount.id {
                //                    self?.delegate?.addChild(vc: .registerPermanentAddress)
                //                }else {
                //                    self?.callRegisterAddress()
                ////                    self?.delegate?.addChild(vc: .occupationVC)
                //                }
                
            }
            
        }
        
        personalInformationViewModel.registerConsumerAddressResponse.bind() { [weak self] response in
            
            guard let status = response?.message?.status, let description = response?.message?.description?.lowercased() else { return }
            if status == "200" && description.lowercased() == "success"{
                guard let accountVariantID = DataCacheManager.shared.loadAccountType() else {
                    
                    //Shakeel
                    //                    self?.delegate?.addChild(vc: .occupationVC)
                    self?.delegate?.addChild(vc: .nationalityVC, fromViewController: "")
                    return
                }
                if accountVariantID == AccountVariant.currentAccount.id {
                    self?.delegate?.addChild(vc: .registerPermanentAddress, fromViewController: "")
                }else {
                    //Shakeel
                    //                    self?.delegate?.addChild(vc: .occupationVC)
                    self?.delegate?.addChild(vc: .nationalityVC, fromViewController: "")
                }
                
                //                self?.delegate?.addChild(vc: .occupationVC)
            }
        }
        
        personalInformationViewModel.errorMessage.bind() { error in
            guard let error = error else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: error)
        }
    }
    
}

extension PersonalInformationThirdVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        if lanlineNumTextField == textField {
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            
            textField.text = formatLandLineNumber(with: "XXXX-XXXXXXX", phone: newString)
            return false
        }
        return true
    }
    /// mask example: `+X (XXX) XXX-XXXX`
    func formatLandLineNumber(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
        
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                
                // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}
