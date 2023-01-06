//
//  CNICManualVerificationVC.swift
//  ABL
//
//  Created by Hamza Amin on 6/16/22.
//

import UIKit
import BetterSegmentedControl

final class CNICManualVerificationVC: UIViewController {
    
    // MARK: - Class Outlets
    
    @IBOutlet weak var togglePortedNetwork: BetterSegmentedControl!
  
    @IBAction func togglePortedNetwork(_ sender: BetterSegmentedControl) {
        if sender.index == 1 {
            openPortedPopupVC()
        }
    }
    private func openPortedPopupVC() {
        guard let portedPopupVC = UIStoryboard.initialize(
            viewController: .portedPopupVC,
            fromStoryboard: .cnicUpload
        ) as? PortedPopupVC else { return }
        
        portedPopupVC.portedMobileNetwork = { [weak self] in
            guard let self = self else { return }

        }
        present(portedPopupVC, animated: true)
    }
    @IBOutlet weak var cnicTextField: UITextField!
    @IBOutlet weak var textFieldCnicIssueDate: UITextField!
    @IBOutlet weak var textFieldDateOfBirth: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!

    @IBOutlet weak var buttonBack: UIButton!

//asdfasdf
    private let cnicVerificationViewModel = CNICVerificationViewModel()
    private let selectBankingMethodViewModel = SelectBankingMethodViewModel()
    
    var mobileNumber: String?
    var datePickerDateOfBirth = UIDatePicker()
    var datePickerIssueDate = UIDatePicker()

    
//    var isPortedMobileNetwork: Bool?
//    lazy var jointAccountSecondaryApplicant = false
//
//    private var frontSideCNICData: Data?
//    private var backSideCNICData: Data?
    var cameFromJointFlow = false
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeViewModel()
        textFieldPhoneNumber.text = modelRegistrationSteper.phoneNumber

        textFieldPhoneNumber.delegate = self
        datePickerDateOfBirth = textFieldDateOfBirth.setPickerDate()
        datePickerDateOfBirth.addTarget(self, action: #selector(self.tappedOnDate), for: .valueChanged)
        
        datePickerIssueDate = textFieldCnicIssueDate.setPickerDate()
        datePickerIssueDate.addTarget(self, action: #selector(self.tappedOnDate), for: .valueChanged)
        
        togglePortedNetwork.segments = LabelSegment.segments(
            withTitles: ["No".localizeString(), "Yes".localizeString()],
            normalBackgroundColor: PluginColorAsset.otpFieldBorder.color,
            normalTextColor: .white,
            selectedBackgroundColor: PluginColorAsset.appOrange.color,
            selectedTextColor: .white
        )
    }
    
    @IBAction func buttonBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if validationError() {
            return()
        }
        cnicVerificationViewModel.viewAppGenerateOTPWithoutAttachment(
            customerTypeID: BaseConstants.Config.customerTypeID,
            mobileNumber: mobileNumber,
            generateOTP: true,
            idNumber: cnicTextField.text,
            dateOfIssue: textFieldCnicIssueDate.text!,
            dateOfBirth: textFieldDateOfBirth.text!,
            isPortedMobileNetwork: togglePortedNetwork.index == 1 ? true : false)
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    private func callRegisterVerifyOTP(){
        
        guard let viewAppGenerateResponseModel = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList else { return }
        
        var consumerListInputModelArray = [BasicInfoConsumerListInputModel]()
        consumerListInputModelArray = getListOfConsumers(newUserInfo: BasicInfoConsumerListInputModel()!)

        //TODO: add data of primary and all the secondary applicants in consumerList Array
        guard let registerVerifyOTPInput = RegisterVerifyOTPInputModel(
            consumerList: consumerListInputModelArray,
            noOfJointApplicants: 0,
            bioMetricVerificationNadraMobileReq: nil,
            channelId: BaseConstants.Config.channelID,
            customerTypeId: BaseConstants.Config.customerTypeID
        ) else { return }

        selectBankingMethodViewModel.registerVerifyOTP(input: registerVerifyOTPInput)
    }
    
    @objc func tappedOnDate(sender: UIDatePicker) {
        print(sender)
        let stringDate = sender.date.dateString()

        if sender == datePickerIssueDate {
            textFieldCnicIssueDate.text = stringDate
        }
        if sender == datePickerDateOfBirth {
            textFieldDateOfBirth.text = stringDate
        }
    }
    
    func validationError() -> Bool {
        if textFieldPhoneNumber.text!.isEmpty {
            showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: "Please enter mobile number")
            return true
        }
        else if !(textFieldPhoneNumber.text!.isValidPhoneNumber) {
            showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: "Please enter valid mobile number")
            return true
        }
        else if cnicTextField.text!.isEmpty {
            showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: "Please enter CNIC number")
            return true
        }
        else if textFieldCnicIssueDate.text!.isEmpty {
            showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: "Please enter CNIC issue date")
            return true
        }
        else if textFieldDateOfBirth.text!.isEmpty {
            showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: "Please enter CNIC date of birth")
            return true
        }
        return false
    }
    
    private func openSimVerificationVC() {
        guard let simVerificationVC = UIStoryboard.initialize(
            viewController: .simVerificationVC,
            fromStoryboard: .cnicUpload
        ) as? SimVerificationVC else { return }
        
        navigationController?.pushViewController(simVerificationVC, animated: true)
    }
    
    private func openVerifyOTPVC() {
        guard let verifyOTPVC = UIStoryboard.initialize(
            viewController: .verifyOTPVC,
            fromStoryboard: .biometricVerification
        ) as? VerifyOTPVC else { return }
        
        verifyOTPVC.otpVerifyMode = .cnicUpload
        navigationController?.pushViewController(verifyOTPVC, animated: true)
    }
    
    private func openPersonalInformationVC() {
        guard let personalInformationVC = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC else { return }
                
        navigationController?.pushViewController(personalInformationVC, animated: true)
    }

    
    private func subscribeViewModel() {
        cnicVerificationViewModel.openAccountUserData.bind { [weak self] response in
            guard let self = self, let response = response else { return }
            
            // These two functions are used together, the first appends the response and the second saves the array in user defaults.
            //            DataCacheManager.shared.appendViewAppGenerateOTPResponse(response: response)
            //            DataCacheManager.shared.saveViewAppGenerateOTPResponseArray()
            
            DataCacheManager.shared.saveViewAppGenerateOTPResponse(input: response)
            
            if !self.cameFromJointFlow {
                self.cnicVerificationViewModel.openVerifyOTPVC()
            } else {
                //                    self.cnicVerificationViewModel.openPersonalInformationVC()
                self.callRegisterVerifyOTP()
            }
        }
        
        cnicVerificationViewModel.routeToVerifyOTPVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openVerifyOTPVC()
        }
        
        cnicVerificationViewModel.routeToPersonalInformationVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openPersonalInformationVC()
        }
        
        cnicVerificationViewModel.errorMessage.bind { error in
            guard let error = error else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: error)
        }
        
        selectBankingMethodViewModel.registerVerifyOTPResponse.bind { [weak self] response in
            //            TODO: where to get relation code and average monthly salary for savekyc
            if let noOfJointApplicants = DataCacheManager.shared.loadNoOfJointApplicants() {
                if noOfJointApplicants > 0 {
                    let registerOTPResponse = DataCacheManager.shared.loadRegisterVerifyOTPResponse()
                    guard let rdaCustomerAccountInfoId = registerOTPResponse?.consumerList?.first?.accountInformation?.rdaCustomerAccInfoID, let rdaCustomerProfileId = registerOTPResponse?.consumerList?.first?.rdaCustomerProfileID else { return }
                    let relationCode = DataCacheManager.shared.loadAdditionalApplicantRelationship()?.id
                    self?.cnicVerificationViewModel.saveKyc(
                        rdaCustomerAccInfoId: rdaCustomerAccountInfoId,
                        rdaCustomerProfileId: rdaCustomerProfileId,
                        isPrimary: false,
                        relationCode1: relationCode, averageMonthlySalary: nil)
                }
            }
            
        }
        
        cnicVerificationViewModel.saveKYCResponseData.bind { [weak self] response in
            guard let statusCode = response?.message?.status, let message = response?.message?.description else { return }
            if statusCode == "200" && message.lowercased() == "success"{
                self?.cnicVerificationViewModel.openPersonalInformationVC()
            }
        }
    }
    
    
    //MARK: - For merging
    func getListOfConsumers(newUserInfo: BasicInfoConsumerListInputModel) -> [BasicInfoConsumerListInputModel] {
        var tempRdaCustomerProfileID = newUserInfo.rdaCustomerProfileId
        var tempRdaCustomerAccInfoId = newUserInfo.rdaCustomerAccInfoId
        
        let cousumerListHamza = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList
        var currentConsumerList = getCurrentConsumerListResponseInInputModel(responseCunsumerList: cousumerListHamza!)
        let cousumerListShakeel = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList
        var foundIndex = 99
        //MARK: - Start----- Just to find new User Profile ID
        if currentConsumerList.count > 0 {
            for (index, consumer) in currentConsumerList.enumerated() {
                print(consumer.rdaCustomerProfileId ?? 0)
                print(consumer.rdaCustomerAccInfoId ?? 0)
                if let consumerListLocalShakeel = cousumerListShakeel {
                    var isNotFoundAndNewUserProfileID = true
                    consumerListLocalShakeel.forEach {
                       if $0.rdaCustomerProfileID == consumer.rdaCustomerProfileId {
                            print("record found")
                            isNotFoundAndNewUserProfileID = false
                        }
                    }
                    if isNotFoundAndNewUserProfileID {
                        print("------Start-----Profile Id Not Found------")
                        tempRdaCustomerProfileID = consumer.rdaCustomerProfileId ?? 0
                        tempRdaCustomerAccInfoId = consumer.rdaCustomerAccInfoId
                        print("------End-----Profile Id Not Found------")
                        foundIndex = index
                    }
                }
            }
        }
        //MARK: - Start-----If user profile id found Replace in new user Request data
//        newUserInfo.rdaCustomerAccInfoId = tempRdaCustomerAccInfoId
//        newUserInfo.rdaCustomerAccInfoId = tempRdaCustomerProfileID
        
        if foundIndex != 99 {
            currentConsumerList[foundIndex] = BasicInfoConsumerListInputModel()!
            currentConsumerList[foundIndex].isPrimary = false
            currentConsumerList[foundIndex].isPrimaryRegistered = false
        }
        else {
            foundIndex = 0
            currentConsumerList[foundIndex].isPrimary = true
        }
        currentConsumerList[foundIndex].rdaCustomerAccInfoId = tempRdaCustomerAccInfoId
        currentConsumerList[foundIndex].rdaCustomerProfileId = tempRdaCustomerProfileID
        currentConsumerList[foundIndex].genderId = modelRegistrationSteper.genderId == 0 ? nil : newUserInfo.genderId

        return currentConsumerList
    }
    
    
    
}



//class CNICManualVerificationVC: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}


extension CNICManualVerificationVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        if textField == textFieldPhoneNumber {
            textField.text = formatCnicNumber(with: "XXXX-XXXXXXX", cnic: newString)
        }
        else if textField == cnicTextField {
            textField.text = formatPhoneNumber(with: "XXXXX-XXXXXXX-X", phone: newString)
        }
        return false
    }
}
/// mask example: `+X (XXX) XXX-XXXX`
func formatPhoneNumber(with mask: String, phone: String) -> String {
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
/// mask example: `XXXXX-XXXXXXX-X`
func formatCnicNumber(with mask: String, cnic: String) -> String {
    let numbers = cnic.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
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


extension String {
    /// mask example: `XXXXXXXXXXXXX`
    func removeMasking() -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        let masking = "XXXXXXXXXXXXXXXXX"
        var index = numbers.startIndex // numbers iterator
        // iterate over the mask characters until the iterator of numbers ends
        for ch in masking where index < numbers.endIndex {
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




extension UITextFieldDelegate {
    func doneButtonTapped3() {
        
    }
}
extension UITextField {
    @IBInspectable var placeHolderColor2: UIColor? {
        get {
            return self.placeHolderColor2
        }
        set {
            //Different colors in placeholder UITextField
            guard var placeHolderText = self.placeholder?.count ?? 0 > 0 ? self.placeholder : "" else { return}
            if placeHolderText.contains("*") {
                placeHolderText = placeHolderText.replacingOccurrences(of: "*", with: "", options: .literal, range: nil)
                // let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.lightGray]
                // let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.red]
                let attrs1 = [NSAttributedString.Key.foregroundColor : UIColor.lightGray]
                let attrs2 = [NSAttributedString.Key.foregroundColor : UIColor.red]
                let attributedString1 = NSMutableAttributedString(string: "   " + placeHolderText, attributes:attrs1)
                let attributedString2 = NSMutableAttributedString(string:"*", attributes:attrs2)
                attributedString1.append(attributedString2)
                self.attributedPlaceholder = attributedString1
            }
            else {
                let attrs1 = [NSAttributedString.Key.foregroundColor : UIColor.lightGray]
                let attributedString = NSMutableAttributedString(string: "   " + placeHolderText, attributes:attrs1)
                self.attributedPlaceholder = attributedString
            }
        }
    }
    
    @IBInspectable var doneToolbar: UIToolbar {
        //        set{
        //            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        //
        //            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        //
        //            let items = [flexSpace, doneButton]
        //            toolbar.items = items
        //            toolbar.sizeToFit()
        //        }
        get {
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped2))
            
            let items = [flexSpace, doneButton]
            toolbar.items = items
            
            toolbar.sizeToFit()
            return toolbar
        }
    }
    
    @objc func doneButtonTapped2() {
        resignFirstResponder()
    }
    
    func setPickerCustom() -> UIPickerView {
        let picker = UIPickerView()
        //Need assign delegates in UIViewController
        //picker.dataSource = self
        //picker.delegate = self
        self.frame = .zero
        self.inputView = picker
        inputAccessoryView = doneToolbar
        return picker
    }
    
    func setPickerDate() -> UIDatePicker {
        let picker = UIDatePicker()
//        if #available(iOS 15, *) {
//            picker.minimumDate = Date.now
//        } else {
//            picker.minimumDate = Date()
//        }
        //Need assign delegates in UIViewController
        //picker.dataSource = self
        //picker.delegate = self
        frame = .zero
        inputView = picker
        inputAccessoryView = doneToolbar
        //Formate Date
        picker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        return picker
    }
    
    func setPickerTime() -> UIDatePicker {
        let picker = UIDatePicker()
        //Need assign delegates in UIViewController
        //picker.dataSource = self
        //picker.delegate = self
        frame = .zero
        inputView = picker
        inputAccessoryView = doneToolbar
        //Formate Date
        picker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        return picker
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) || action == #selector(cut(_:)){
            return false
        }
        else if action == #selector(select(_:)) || action == #selector(selectAll(_:)){
            return true
        }
        
        //return super.canPerformAction(action, withSender: sender)
        
        return false
    }
    
    func setPadding() {
        let padding = CGFloat(8.0)
        let defaultRect = CGRect(x: 0, y: 0, width: padding, height: self.frame.height)
        
        //MARK:- Padding Left
        let paddingViewLeft = UIView(frame: self.leftView?.frame ?? defaultRect)
        
        if let leftView = self.leftView {
            for temp in leftView.subviews {
                paddingViewLeft.addSubview(temp)
                paddingViewLeft.frame.size.width += padding
                break
            }
        }
        else {
            //MARK:- if leftView is nill this will use for add padding
            paddingViewLeft.frame = defaultRect
        }
        self.leftView = paddingViewLeft
        paddingViewLeft.backgroundColor = .clear
        self.leftViewMode = .always
        
        //MARK:- Padding Right
        let paddingViewRight = UIView(frame: self.rightView?.frame ?? defaultRect)
        
        if let rightView = self.rightView {
            for temp in rightView.subviews {
                paddingViewRight.addSubview(temp)
                paddingViewRight.frame.size.width += padding
                temp.frame.origin.x = padding
                break
            }
        }
        else {
            //MARK:- if rightView is nill this will use for add padding
            paddingViewRight.frame = defaultRect
        }
        
        self.rightView = paddingViewRight
        paddingViewRight.backgroundColor = .clear
        self.rightViewMode = .always
    }
    
    func setPaddingLeft() {
        let padding = CGFloat(5.0)
        let defaultRect = CGRect(x: 0, y: 0, width: padding, height: self.frame.height)
        
        //MARK:- Padding Left
        let paddingViewLeft = UIView(frame: self.leftView?.frame ?? defaultRect)
        
        if let leftView = self.leftView {
            for temp in leftView.subviews {
                paddingViewLeft.addSubview(temp)
                paddingViewLeft.frame.size.width += padding
                break
            }
        }
        else {
            //MARK:- if leftView is nill this will use for add padding
            paddingViewLeft.frame = defaultRect
        }
        self.leftView = paddingViewLeft
        paddingViewLeft.backgroundColor = .clear
        self.leftViewMode = .always
    }
    
    func setPaddingRight() {
        let padding = CGFloat(5.0)
        let defaultRect = CGRect(x: 0, y: 0, width: padding, height: self.frame.height)
        
        //MARK:- Padding Right
        let paddingViewRight = UIView(frame: self.rightView?.frame ?? defaultRect)
        
        if let rightView = self.rightView {
            for temp in rightView.subviews {
                paddingViewRight.addSubview(temp)
                paddingViewRight.frame.size.width += padding
                temp.frame.origin.x = padding
                break
            }
        }
        else {
            //MARK:- if rightView is nill this will use for add padding
            paddingViewRight.frame = defaultRect
        }
        
        self.rightView = paddingViewRight
        paddingViewRight.backgroundColor = .clear
        self.rightViewMode = .always
    }
    
    func setLeftIcon(icon: String, backGroudColor: UIColor) {
        let iconImageSizePercentage = CGFloat(0.30)
        
        let frameView = UIView(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) ), height: ((self.frame.height))))
        let iconImage = UIImage(named: icon)
        frameView.backgroundColor = backGroudColor
        
        let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) * iconImageSizePercentage ), height: ((self.frame.height) * iconImageSizePercentage))) // set your Own size
        iconImageView.image = iconImage
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.backgroundColor = .clear
        
        frameView.addSubview(iconImageView)
        iconImageView.center = frameView.center
        
        leftView = frameView
        leftViewMode = .always
        tintColor = .lightGray
    }
    
    func setRightIcon(icon: String) {
        let iconImageSizePercentage = CGFloat(0.30)
        
        let frameView = UIView(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) ), height: ((self.frame.height))))
        let iconImage = UIImage(named: icon)
        frameView.backgroundColor = .clear
        
        let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) * iconImageSizePercentage), height: ((self.frame.height) * iconImageSizePercentage))) // set your Own size
        iconImageView.image = iconImage
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.backgroundColor = .clear
        
        frameView.addSubview(iconImageView)
        iconImageView.center = frameView.center
        
        rightView = frameView
        rightViewMode = .always
        tintColor = .lightGray
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(funBecomeFirstResponder))
        rightView?.addGestureRecognizer(tap)
    }
    
    func setRightIcon(icon: String, padding: Float?) {
        let padding = CGFloat(padding ?? 0.0)
        let iconImageSizePercentage = CGFloat(0.30)
        
        let frameView = UIView(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) ), height: ((self.frame.height))))
        let iconImage = UIImage(named: icon)
        frameView.backgroundColor = .clear
        
        let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) * iconImageSizePercentage), height: ((self.frame.height) * iconImageSizePercentage))) // set your Own size
        iconImageView.image = iconImage
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.backgroundColor = .clear
        
        frameView.addSubview(iconImageView)
        iconImageView.center = frameView.center
        
        //MARK:- Padding Right
        let paddingView = UIView(frame: frameView.frame)
        paddingView.frame.size.width = paddingView.frame.width + padding
        paddingView.addSubview(frameView)
        frameView.frame.origin.x = padding
        paddingView.backgroundColor = self.backgroundColor
        
        rightView = paddingView
        rightViewMode = .always
        tintColor = .lightGray
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(funBecomeFirstResponder))
        rightView?.addGestureRecognizer(tap)
    }
    func setRightIcon(icon: String, backGroudColor: UIColor) {
        let iconImageSizePercentage = CGFloat(0.30)
        
        let frameView = UIView(frame: CGRect(x: 0, y: 0, width: ((self.frame.height)), height: ((self.frame.height))))
        let iconImage = UIImage(named: icon)
        frameView.backgroundColor = backGroudColor
        
        let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) * iconImageSizePercentage ), height: ((self.frame.height) * iconImageSizePercentage))) // set your Own size
        iconImageView.image = iconImage
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.backgroundColor = .clear
        
        frameView.addSubview(iconImageView)
        iconImageView.center = frameView.center
        
        self.leftView = frameView
        self.leftViewMode = .always
        self.tintColor = .lightGray
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(funBecomeFirstResponder))
        rightView?.addGestureRecognizer(tap)
    }
    
    func setRightIconButton(icon: String) -> UIButton {
        let iconImageSizePercentage = CGFloat(0.35)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: ((self.frame.height)), height: ((self.frame.height))))
        button.backgroundColor = .clear
        let iconImage = UIImage(named: icon)
        
        let iconImageView =  UIImageView(frame: CGRect(x: 0, y: 0, width: ((self.frame.height) * iconImageSizePercentage ), height: ((self.frame.height) * iconImageSizePercentage))) // set your Own size
        iconImageView.image = iconImage
        iconImageView.contentMode = .scaleAspectFit
        
        let frameView: UIView = UIView(frame: button.frame)
        frameView.backgroundColor = .clear
        frameView.addSubview(iconImageView)
        frameView.addSubview(button)
        
        iconImageView.center = frameView.center
        
        self.rightView = frameView
        self.rightViewMode = .always
        self.tintColor = .red
        
        return button
    }
    
    @objc func funBecomeFirstResponder(sender: Any) {
        self.becomeFirstResponder()
    }
}
extension Date {
    func dateString() -> String {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        if let day = components.day, let month = components.month, let year = components.year {
            //print("\(day) \(month) \(year)")
            let selectedDate = "\(month)/\(day)/\(year)"
            
            return selectedDate
        }
        return ""
    }
}
