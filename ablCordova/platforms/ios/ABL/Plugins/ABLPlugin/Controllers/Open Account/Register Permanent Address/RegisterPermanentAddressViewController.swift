//
//  RegisterPermanentAddressViewController.swift
//  ABL
//
//  Created by Hamza Amin on 5/24/22.
//

import UIKit
import BetterSegmentedControl

final class RegisterPermanentAddressViewController: UIViewController {
    
    @IBOutlet weak var viewMailingAddress: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var nearestLandmaarkTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var landlineTextField: UITextField!
    @IBAction func toggleMailAddressSwitch(_ sender: BetterSegmentedControl) {
        sameAsCurrentAddress(isCurrent: sender.index == 1)
    }
    @IBOutlet weak var toggleMailAddressSwitch: BetterSegmentedControl!
    @IBOutlet weak var mailAddressSwitch: BetterSegmentedControl!
    @IBOutlet weak var mailAddressPreferenceSwitch: BetterSegmentedControl!
    
    var isEditFromReviewDetailsViewController = false
    var forViewController = ""
    let ACCEPTABLE_CHARACTERS = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"

    private let permanentAddressViewModel = PersonalInformationViewModel()
    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeViewModel()
        setupViews()
    }
    override func viewDidAppear(_ animated: Bool) {
        mailAddressSwitch.setIndex(1)
        mailAddressSwitch.isSelected = true
        sameAsCurrentAddress(isCurrent: true)
        
        if modelRegistrationSteper.permanentAddressViewModel != nil {
            addressTextField.text = modelRegistrationSteper.addressTextFieldPermanent
            townTextField.text = modelRegistrationSteper.townTextFieldPermanent
            nearestLandmaarkTextField.text = modelRegistrationSteper.nearestLandmaarkTextFieldPermanent
            cityTextField.text = modelRegistrationSteper.cityTextFieldPermanent
            landlineTextField.text = modelRegistrationSteper.landlineTextFieldPermanent
        }
    }
    
    private func setupViews(){
        landlineTextField.delegate = self
        cityTextField.delegate = self
        townTextField.delegate = self
        addressTextField.delegate = self
        nearestLandmaarkTextField.delegate = self
//        emailTextField.delegate = self
        mailAddressPreferenceSwitch.segments = LabelSegment.segments(withTitles: ["Permanent", "Current"],
                                                                   normalTextColor: .white,
                                                                     selectedTextColor: .white)
        mailAddressSwitch.segments = LabelSegment.segments(withTitles: ["No", "Yes"],
                                                                   normalTextColor: .white,
                                                           selectedTextColor: .white)
    }
    
    func sameAsCurrentAddress(isCurrent: Bool) {
        if isCurrent {
            addressTextField.text = modelRegistrationSteper.addressCurrent
            townTextField.text = modelRegistrationSteper.townTehsilCurrent
            nearestLandmaarkTextField.text = modelRegistrationSteper.nearestLandMarkCurrent
            cityTextField.text = modelRegistrationSteper.cityCurrent
            landlineTextField.text = modelRegistrationSteper.landLineOptionalCurrent
            viewMailingAddress.isHidden = true
        }
        else {
            addressTextField.text = ""
            townTextField.text = ""
            nearestLandmaarkTextField.text = ""
            cityTextField.text = ""
            landlineTextField.text = ""
            viewMailingAddress.isHidden = false
        }
    }
        
    @IBAction func nextBtnClicked(_ sender: UIButton){
        if addressTextField.text?.count == 0{
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please enter Address first")
        }else if nearestLandmaarkTextField.text?.count == 0{
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please enter Nearest Landmark first")
        }else if cityTextField.text?.count == 0{
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please enter City first")
        }else if townTextField.text?.count == 0{
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please enter Town / Tehsil first")
        }else{
            callRegisterAddress()
        }

        
    }
    
    @IBAction func mailAddressPreferenceSwitchTapped(_ sender: UIButton){


        
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
    
    
    private func callRegisterAddress(){
    
        permanentAddressViewModel.registerConsumerAddress(
            rdaCustomerId: BaseConstants.Config.rdaCustomerId,
            nearestLandMark: nearestLandmaarkTextField.text,
            customerAddress: addressTextField.text,
            city: cityTextField.text,
            addressTypeId: BaseConstants.CustomerAddress.permanetAddressId,
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
    
    private func callRegisterMailAddressPreference(){

        let mailingAddrPrefId = mailAddressPreferenceSwitch.index == 0 ? BaseConstants.CustomerAddress.permanetAddressId : BaseConstants.CustomerAddress.currentAddressId
        guard let viewAppGenerateResponseModel = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last else { return }
        permanentAddressViewModel.registerMailAddressPreference(rdaCustomerAccInfoId: viewAppGenerateResponseModel.accountInformation?.rdaCustomerAccInfoID, rdaCustomerId: viewAppGenerateResponseModel.accountInformation?.rdaCustomerID, customerTypeId: viewAppGenerateResponseModel.customerTypeID, esoaInd: nil, physicalCardInd: nil, bankingModeId: viewAppGenerateResponseModel.accountInformation?.bankingModeID, customerBranch: viewAppGenerateResponseModel.customerBranch, customerAccountTypeId: viewAppGenerateResponseModel.accountInformation?.customerAccountTypeID, purposeOfAccountId: viewAppGenerateResponseModel.accountInformation?.purposeOfAccountID, proofOfIncomeInd: nil, accountVariantId: viewAppGenerateResponseModel.accountInformation?.accountVariantID, atmTypeId: viewAppGenerateResponseModel.accountInformation?.atmTypeID, transAlertInd: nil, chequeBookReqInd: nil, transactionalAlertId: viewAppGenerateResponseModel.accountInformation?.transactionalAlertID, natureOfAccountId: viewAppGenerateResponseModel.accountInformation?.natureOfAccountID, currencyTypeId: viewAppGenerateResponseModel.accountInformation?.currencyTypeID, pdaRemitterDetailList: nil, noOfJointApplicatns: viewAppGenerateResponseModel.accountInformation?.noOfJointApplicants, mailingAddrPrefId: mailingAddrPrefId, reasonForVisaDebitCardRequestId: nil)
    }
    
    private func subscribeViewModel() {
        
        permanentAddressViewModel.registerConsumerAddressResponse.bind { [weak self] response in
            guard let status = response?.message?.status, let description = response?.message?.description?.lowercased() else { return }
            if status == "200" && description.lowercased() == "success"{
                modelRegistrationSteper.permanentAddressViewModel = (self?.permanentAddressViewModel)!
//                self?.callRegisterMailAddressPreference()
                modelRegistrationSteper.addressTextFieldPermanent = self?.addressTextField.text
                modelRegistrationSteper.townTextFieldPermanent = self?.townTextField.text
                modelRegistrationSteper.nearestLandmaarkTextFieldPermanent = self?.nearestLandmaarkTextField.text
                modelRegistrationSteper.cityTextFieldPermanent = self?.cityTextField.text
                modelRegistrationSteper.landlineTextFieldPermanent = self?.landlineTextField.text
//                self?.delegate?.addChild(vc: .occupationVC)
                self?.delegate?.addChild(vc: .nationalityVC, fromViewController: "")
            }
        }
        
        permanentAddressViewModel.registerMailAddressResponse.bind { [weak self] response in
            guard let status = response?.message?.status, let description = response?.message?.description?.lowercased() else { return }
            if status == "200" && description.lowercased() == "success"{
                self?.delegate?.addChild(vc: .nationalityVC, fromViewController: "")
            }
        }
        
        permanentAddressViewModel.errorMessage.bind { error in
            guard let error = error else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: error)
        }
    }
    
}


extension RegisterPermanentAddressViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        if landlineTextField == textField {
            let maxLength = 17
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        if landlineTextField == textField {
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            
            textField.text = formatLandLineNumber(with: "XXXX-XXXXXXX", phone: newString)
            return false
        }
        else if cityTextField == textField || townTextField == textField {
            let cs = CharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
            let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
            if(string == filtered){
                let maxLength = 17
                let currentString: NSString = textField.text! as NSString
                let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
                return newString.length <= maxLength
            }else{
                return false
            }
        }
        else if addressTextField == textField{
            let maxLength = 35
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if nearestLandmaarkTextField == textField  {
            let maxLength = 25
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        if nearestLandmaarkTextField == textField {
            let cs = CharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
            let filtered: String = (string.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
            return (string == filtered)
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

