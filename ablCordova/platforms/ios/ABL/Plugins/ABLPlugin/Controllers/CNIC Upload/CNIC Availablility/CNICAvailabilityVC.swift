//
//  CNICAvailabilityVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 14/03/2022.
//

import UIKit
import DropDown
import BetterSegmentedControl

final class CNICAvailabilityVC: UIViewController {
    
    @IBOutlet weak var cnicNumberLabel: UILabel!
    @IBOutlet weak var cnicNumberTextField: UITextField!
    @IBOutlet weak var cnicNumberView: UIView!
    
    @IBOutlet weak var clickHereLink: LabelSetting!
    
    @IBAction func buttonUrdu(_ sender: Any) {
        funChangeAppLanguageAndSide(to: "ur", vc: self)
    }
    @IBOutlet weak var buttonUrdu: UIButton!
    
    @IBAction func buttonEnglish(_ sender: Any) {
        funChangeAppLanguageAndSide(to: "en", vc: self)
    }
    
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    @IBOutlet weak var nextButton: ButtonSetting!
    @IBOutlet weak var mobileNetworkLabel: UILabel!
    @IBOutlet weak var mobileNetworkTitleLabel: UILabel!
    @IBOutlet weak var mobileNetworkView: UIView!
    
    @IBOutlet weak var portedSwitch: UISwitch!
    @IBOutlet weak var portedSegment: BetterSegmentedControl!
    
    private let mobileNetworkDropdown = DropDown()
    private let cnicAvailabilityViewModel = CNICAvailabilityViewModel()
    private var selectedMobileNetworkID: Double?
    private var mobileNetworks = [MobileNetworkDataModel]()
    
    private let notificationCenter = NotificationCenter.default
    var cameFromJointFlow = false
    
    override func viewWillAppear(_ animated: Bool) {
        cnicNumberTextField.text = nil
        mobileNumberTextField.text = nil
        modelRegistrationSteper = RegistrationSteperModel()
        //Irfan
        setupGestureRecognizers()
        let consumer = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last
        
        print(consumer)
        print(DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList)
        print(DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.count)
        print(DataCacheManager.shared.loadNoOfJointApplicants())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileNumberTextField.delegate = self
        cnicNumberTextField.delegate = self
        portedSegment.segments = LabelSegment.segments(
            withTitles: ["No", "Yes"],
            normalBackgroundColor: PluginColorAsset.otpFieldBorder.color,
            normalTextColor: .white,
            selectedBackgroundColor: PluginColorAsset.appOrange.color,
            selectedTextColor: .white
        )
        
        cnicNumberLabel.makeAttributedText(stringToColor: "*")
        mobileNumberLabel.makeAttributedText(stringToColor: "*")
        mobileNetworkLabel.makeAttributedText(stringToColor: "*")
        
        mobileNetworkView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(selectMobileNetworkTapped)
            )
        )
        
        setupDropdown()
        subscribeViewModel()
        
        notificationCenter.addObserver(
            self,
            selector: #selector(additionalApplicantFlow),
            name: .additionalApplicant,
            object: nil
        )
        
        cnicAvailabilityViewModel.setShouldGenerateOTP(shouldGenerate: true)
    }
    
    deinit {
        notificationCenter.removeObserver(
            self,
            name: .additionalApplicant,
            object: nil
        )
    }
    //Irfan
    private func setupGestureRecognizers() {
        
        let clickHere = UITapGestureRecognizer(target: self, action: #selector(openclickHereLink))
        clickHereLink.isUserInteractionEnabled = true
        clickHereLink.addGestureRecognizer(clickHere)

    }
        //Irfan
    @objc private func openclickHereLink() {
        let clickHere: String = "https://apps.apple.com/pk/app/myabl-wallet/id1455479217"
        if let appURL = URL(string: clickHere){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL)
                
            }
            
        }
    }
    
    @IBAction func toggleSwich(_ sender: UISwitch) {
        if sender.isOn {
            openPortedPopupVC()
        }
    }
    
    @IBAction func toggleSegmentControl(_ sender: BetterSegmentedControl) {
        if sender.index == 1 {
            openPortedPopupVC()
        }
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if cnicNumberView.isHidden {
            if mobileNumberTextField.text?.count == 0{
                AlertManager.shared.showOKAlert(with: "Alert!", message: "Please enter Mobile Number first")
            }else{
                cnicAvailabilityViewModel.viewAppGenerateOTP(
                    customerTypeID: 106501,
                    mobileNumber: mobileNumberTextField.text ?? "",
                    generateOTP: false
                )
            }
        } else {
            if modelRegistrationSteper.cnicNumber != cnicNumberTextField.text ?? "" {
                
                self.showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: "Provided CNIC is not matched")
                
                DispatchQueue.main.async {
                }
                
                return
            }
            cnicAvailabilityViewModel.viewAppGenerateOTPWithCNIC(
                customerTypeID: 106501,
                mobileNumber: mobileNumberTextField.text,
                generateOTP: cnicAvailabilityViewModel.getShouldGenerateOTP(),
                cnicNumber: cnicNumberTextField.text ?? "",
                isPortedMobileNetwork: (portedSegment.index == 1) ? true : false
            )
        }
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    private func openCNICVerificationVC() {
        guard let cnicVerificationVC = UIStoryboard.initialize(
            viewController: .cnicVerificationVC,
            fromStoryboard: .cnicUpload
        ) as? CNICVerificationVC else { return }
        
        cnicVerificationVC.mobileNumber = mobileNumberTextField.text
        cnicVerificationVC.isPortedMobileNetwork = (portedSegment.index == 1) ? true : false
        cnicVerificationVC.cameFromJointFlow = cameFromJointFlow
        navigationController?.pushViewController(cnicVerificationVC, animated: true)
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
    
    private func openPortedPopupVC() {
        guard let portedPopupVC = UIStoryboard.initialize(
            viewController: .portedPopupVC,
            fromStoryboard: .cnicUpload
        ) as? PortedPopupVC else { return }
        
        portedPopupVC.portedMobileNetwork = { [weak self] in
            guard let self = self else { return }
//            self.portedSwitch.setOn(true, animated: true)
            self.portedSegment.setIndex(1)
        }
        
        present(portedPopupVC, animated: true)
    }
    
    @objc
    private func selectMobileNetworkTapped() {
        mobileNetworkDropdown.show()
    }
    
    private func subscribeViewModel() {
        cnicAvailabilityViewModel.viewAppGenerateOTPResponse.bind { [weak self] response in
            guard let self = self, let response = response else { return }
            guard let alreadyExist = response.alreadyExist else {
                self.cnicAvailabilityViewModel.openCNICVerificationVC()
                return
            }
            if alreadyExist == false {
                self.cnicAvailabilityViewModel.openCNICVerificationVC()
            } else {
                //Shakeel 11Nov22
                modelRegistrationSteper.cnicNumber = response.idNumber
//                self.cnicNumberTextField.text = response.idNumber
                self.cnicNumberView.isHidden = false
            }
        }
        
        cnicAvailabilityViewModel.viewAppGenerateOTPWithDataResponse.bind { [weak self] response in
            
            guard let self = self, let response = response else { return }
            
            // These two functions are used together, the first appends the response and the second saves the array in user defaults.
            //            DataCacheManager.shared.appendViewAppGenerateOTPResponse(response: response)
            //            DataCacheManager.shared.saveViewAppGenerateOTPResponseArray()
            
            //            self.cnicAvailabilityViewModel.openVerifyOTPVC()
            DataCacheManager.shared.saveViewAppGenerateOTPResponse(input: response)
            
            if !self.cameFromJointFlow {
                self.cnicAvailabilityViewModel.openVerifyOTPVC()
            } else {
                self.cnicAvailabilityViewModel.openPersonalInformationVC()
            }
            
        }
        
        cnicAvailabilityViewModel.mobileNetworks.bind { [weak self] mobileNetwork in
            guard let self = self, let mobileNetwork = mobileNetwork else { return }
            self.mobileNetworks = mobileNetwork.data ?? []
            self.mobileNetworkDropdown.dataSource = self.mobileNetworks.map { $0.name ?? "N/A" }
        }
        
        cnicAvailabilityViewModel.routeToCNICVerification.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openCNICVerificationVC()
        }
        
        cnicAvailabilityViewModel.routeToVerifyOTP.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openVerifyOTPVC()
        }
        
        cnicAvailabilityViewModel.routeToPersonalInformationVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openPersonalInformationVC()
        }
        
        cnicAvailabilityViewModel.errorMessage.bind { error in
            guard let error = error else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: error)
        }
    }
    
    @objc
    func additionalApplicantFlow() {
        cnicAvailabilityViewModel.setShouldGenerateOTP(shouldGenerate: false)
        
//        DataCacheManager.shared.saveShouldGenerateOTP(input: false)
    }
    
    private func setupDropdown() {
        mobileNetworkDropdown.anchorView = mobileNetworkView
        mobileNetworkDropdown.direction = .bottom
        mobileNetworkDropdown.bottomOffset = CGPoint(
            x: 0,
            y: mobileNetworkDropdown.anchorView?.plainView.bounds.height ?? 0
        )
        
        mobileNetworkDropdown.selectionAction = { [unowned self] index, item in
            logsManager.debug("Selected item \(item) at index \(index)")
            self.mobileNetworkTitleLabel.text = item
            self.selectedMobileNetworkID = mobileNetworks[index].id
        }
    }
}

//irfan
extension CNICAvailabilityVC : UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text else { return false }

        let newString = (text as NSString).replacingCharacters(in: range, with: string)

        if textField == cnicNumberTextField {

            textField.text = formatCnicNumber(with: "XXXXX-XXXXXXX-X", cnic: newString)

        }

        else if textField == mobileNumberTextField {

            textField.text = formatPhoneNumber(with: "XXXX-XXXXXXX", phone: newString)

        }

        

        return false

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

    

    /// mask example: `+X (XXX) XXX-XXXX`

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

    

}
