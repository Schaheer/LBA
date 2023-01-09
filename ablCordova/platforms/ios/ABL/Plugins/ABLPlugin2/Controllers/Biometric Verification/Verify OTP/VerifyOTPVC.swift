//
//  SecondVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 02/03/2022.
//

import UIKit

final class VerifyOTPVC: UIViewController {
    
    @IBOutlet weak var otpFieldView: UIView!
//    @IBOutlet weak var resendOTPLabel: UILabel!
    @IBOutlet weak var verifyButton: UIButton!
//    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var resendOTPbutton: UIButton!
    //Irfan
    @IBOutlet weak var otpMainLabel: LabelSetting!
    @IBOutlet weak var otpTimerLabel: LabelSetting!
    
    private var otpStackView = OTPStackView()
    private var timer: Timer?
    private var seconds = 300
    private let aesManager = AES(key: BaseConstants.Encryption.key128)
    
    var requestBiometricInputModel: RequestBiometricInputModel?
    private var draftedAppsData: GetDraftedAppsVerifyOTPResponseModel?
    var otpVerifyMode: OTPVerifyMode = .biometricVerification
    
    private let verifyOTPViewModel = VerifyOTPViewModel()
    var cameFromJointFlow = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if DataCacheManager.shared.loadNoOfJointApplicants() ?? 0 > 0 {
            cameFromJointFlow = true
        }
        otpFieldView.addSubview(otpStackView)
        otpStackView.delegate = self
        
        NSLayoutConstraint.activate([
            otpStackView.topAnchor.constraint(equalTo: otpFieldView.topAnchor),
            otpStackView.leadingAnchor.constraint(equalTo: otpFieldView.leadingAnchor),
            otpStackView.trailingAnchor.constraint(equalTo: otpFieldView.trailingAnchor),
            otpStackView.bottomAnchor.constraint(equalTo: otpFieldView.bottomAnchor)
        ])
        
        logsManager.debug("OTP VERIFY MODE: \(otpVerifyMode)")
        
//        resendOTPLabel.makeOTPAttributedText(
//            boldString: "Did Not Receive OTP?",
//            underlinedString: "Click Here"
//        )
        
//        verifyOTPViewModel.fireTimer()
//        addGestureRecognizers()
        
        subscribeViewModel()
        
        var labelOne = "A One Time Password (OTP) has been sent at your mobile number".localizeString()
        labelOne = labelOne + " " + (modelRegistrationSteper.phoneNumber ?? "")
        
        let labelTwo = "Please enter to proceed further".localizeString()
        labelDescription.text = labelOne + "\n" + labelTwo
    }
    
    private func startOtpTimer() {
           self.seconds = 300
           self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
       }
   
   @objc func updateTimer() {
//           print(self.seconds)
           self.otpTimerLabel.text = self.timeFormatted(self.seconds) // will show timer
           if seconds != 0 {
               seconds -= 1  // decrease counter timer
           } else {
               if let timer = self.timer {
                   timer.invalidate()
                   otpMainLabel.text = "OTP has expired. Please resend"
                   self.timer = nil
               }
           }
       }
   func timeFormatted(_ totalSeconds: Int) -> String {
       let seconds: Int = totalSeconds % 60
       let minutes: Int = (totalSeconds / 60) % 60
       return String(format: "%02d:%02d", minutes, seconds)
   }
    
    override func viewWillAppear(_ animated: Bool) {
        startOtpTimer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        verifyOTPViewModel.resetTimer()
        timer?.invalidate()
    }
    
    deinit {
        verifyOTPViewModel.resetTimer()
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        switch otpVerifyMode {
        case .cnicUpload:
            prepareCnicUploadOTPVerification()
        case .biometricVerification:
            prepareBiometricOTPVerification()
        }
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    @IBOutlet weak var labelDescription: LabelSetting!
    @IBAction func backTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resendOTPTapped(_ sender: UIButton) {
        switch otpVerifyMode {
        case .cnicUpload:
            resendCnicUploadOTP()
            timer?.invalidate()
            startOtpTimer()
        case .biometricVerification:
            resendBiometricOTP()
            timer?.invalidate()
            startOtpTimer()
        }
    }
    
    @IBAction func changeNumberTapped(_ sender: UIButton) {
//        verifyOTPViewModel.openChangeNumberVC()
        //shakeel
        openAvailabilityVC()
    }
    
    private func openAvailabilityVC() {
        guard let verifyOTPVC = UIStoryboard.initialize(
            viewController: .cnicAvailabilityVC,
            fromStoryboard: .cnicUpload
        ) as? CNICAvailabilityVC else { return }
        navigationController?.pushViewController(verifyOTPVC, animated: true)
    }
    
    private func prepareBiometricOTPVerification() {
        guard
            let rdaCustomerProfileID = DataCacheManager.shared.loadUserData()?.entityID
        else { return }
        
        let otp = otpStackView.getOTP()
        if otp.count == 6 {
            let encryptedOTP = aesManager?.encrypt(string: otp) ?? ""
            verifyOTPViewModel.verifyBiometricOTP(encryptedOTP, rdaCustomerProfileID: rdaCustomerProfileID)
        }
    }
    
    private func prepareCnicUploadOTPVerification() {
        guard
            let viewAppGenerateOTPResponse = DataCacheManager.shared.loadViewAppGenerateOTPResponse()
        else { return }
        
        let otp = otpStackView.getOTP()
        if otp.count == 6 {
            if cameFromJointFlow {
                callRegisterVerifyOTP()
            }
            else {
                let encryptedOTP = aesManager?.encrypt(string: otp) ?? ""
                verifyOTPViewModel.verifyCnicUploadOTP(
                    customerTypeID: BaseConstants.Config.customerTypeID,
                    cnicNumber: viewAppGenerateOTPResponse.idNumber,
                    mobileNumber: viewAppGenerateOTPResponse.mobileNo,
                    otp: encryptedOTP
                )
            }
        }
    }
    private func openPersonalInformationVC() {
        guard let personalInformationVC = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC else { return }
        personalInformationVC.firstChild = .personalInfoSecondVC
        navigationController?.pushViewController(personalInformationVC, animated: true)
    }
    private func openBiometricVerificationVC() {
        if DataCacheManager.shared.loadNoOfJointApplicants() ?? 0 > 0 {
            self.openPersonalInformationVC()
            return()
        }
        
        guard let biometricVerificationVC = UIStoryboard.initialize(
            viewController: .biometricVerificationVC,
            fromStoryboard: .biometricVerification
        ) as? BiometricVerificationVC else { return }
        biometricVerificationVC.otpVerifyMode = self.otpVerifyMode
        navigationController?.pushViewController(biometricVerificationVC, animated: true)
    }
    
    private func openResumeApplicationVC() {
        guard let resumeApplicationVC = UIStoryboard.initialize(
            viewController: .resumeApplicationVC,
            fromStoryboard: .cnicUpload
        ) as? ResumeApplicationVC else { return }
        resumeApplicationVC.draftedAppsData = draftedAppsData
        navigationController?.pushViewController(resumeApplicationVC, animated: true)
    }
    
    
    private func openChangeNumberVC() {
        guard let changeNumberVC = UIStoryboard.initialize(
            viewController: .changeNumberVC,
            fromStoryboard: .cnicUpload
        ) as? ChangeNumberVC else { return }
        
        navigationController?.pushViewController(changeNumberVC, animated: true)
    }
    
    @objc
    private func resendBiometricOTP() {
        verifyOTPViewModel.resendBiometricOTP(with: requestBiometricInputModel)
        startOtpTimer()
    }
    
    @objc
    private func resendCnicUploadOTP() {
        guard
            let viewAppGenerateOTPWithData = DataCacheManager.shared.loadViewAppGenerateOTPWithData()
        else { return }
        
        verifyOTPViewModel.resendCnicUploadOTP(with: viewAppGenerateOTPWithData)
    }
    
//    private func addGestureRecognizers() {
//        resendOTPLabel.addGestureRecognizer(
//            UITapGestureRecognizer(
//                target: self,
//                action: #selector(resendOTP)
//            )
//        )
//    }
    
    private func subscribeViewModel() {
        verifyOTPViewModel.didVerifyOTP.bind { [weak self] success in
            guard let self = self else { return }
            
            if success {
                self.verifyOTPViewModel.openBiometricVerificationVC()
            }
        }
        
        verifyOTPViewModel.routeToBiometricVerificationVC.bind { [weak self] shouldRoute in
            guard let self = self else { return }
            
            if shouldRoute {
                self.openBiometricVerificationVC()
            }
        }
        
        verifyOTPViewModel.routeToResumeApplicationVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openResumeApplicationVC()
        }
        
//        verifyOTPViewModel.routeToSelectBankingMethodVC.bind { [weak self] shouldRoute in
//            guard let self = self, shouldRoute else { return }
//            self.openSelectBankingMethodVC()
//        }
        
        verifyOTPViewModel.getDraftedAppsUserData.bind { [weak self] response in
            guard
                let self = self,
                let response = response,
                let appList = response.appList
            else { return }
            
            if appList.isEmpty {
                self.verifyOTPViewModel.openBiometricVerificationVC()
            } else {
                DataCacheManager.shared.saveDraftedAppsData(input: response)
                DataCacheManager.shared.setAuthHeaders(
                    for: "Authorization",
                    value: "Bearer \(response.accessToken ?? "")"
                )
                self.draftedAppsData = response
                self.verifyOTPViewModel.openResumeApplicationVC()
            }
        }
        
        verifyOTPViewModel.userData.bind { userData in
            guard let userData = userData else { return }
            
//            self.verifyOTPViewModel.resetTimer()
//            self.verifyOTPViewModel.fireTimer()
            DataCacheManager.shared.saveUserData(userData: userData)
            DataCacheManager.shared.setAuthHeaders(
                for: "Authorization",
                value: "Bearer \(userData.accessToken ?? "")"
            )
        }
        
        verifyOTPViewModel.timerIsUp.bind { [weak self] timerIsUp in
            guard let self = self else { return }
            
            if timerIsUp {
                self.verifyOTPViewModel.invalidateTimer()
            }
        }
        
//        verifyOTPViewModel.timerDisplayText.bind { [weak self] value in
//            guard let self = self, let value = value else { return }
//            self.timerLabel.text = value
//        }
        
//        verifyOTPViewModel.isResendEnabled.bind { [weak self] isEnabled in
//            guard let self = self else { return }
//            self.resendOTPLabel.isEnabled = isEnabled
//        }
        
        verifyOTPViewModel.routeToChangeNumberVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openChangeNumberVC()
        }
    }
}

extension VerifyOTPVC: OTPDelegate {
    func didChangeValidity(isValid: Bool) {
//        print(isValid)
            //Shakeel only add ! sign
        if isValid {
            verifyButton.isEnabled = true
            
            switch otpVerifyMode {
            case .cnicUpload:
                prepareCnicUploadOTPVerification()
            case .biometricVerification:
                prepareBiometricOTPVerification()
            }
        } else {
            verifyButton.isEnabled = false
        }
    }
    
    private func callRegisterVerifyOTP(){
        //        if DataCacheManager.shared.getRegisterVerifyOTPResponseModel() != nil {
        //
        //        }
        
        guard
            let viewAppGenerateOTPResponse = DataCacheManager.shared.loadViewAppGenerateOTPResponse() else { return }
        guard let viewAppGenerateResponseModel = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList else { return }
        print(viewAppGenerateResponseModel.first?.idNumber)

        var consumerListInputModelArray = [BasicInfoConsumerListInputModel]()
        let consumer = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList?.first
        
        let consumerList = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList
        print(consumer?.idNumber)
        var rdaCustomerAccInfoId = 0.0
        if let rdaid = consumer?.rdaCustomerAccInfoId as? Int {
            rdaCustomerAccInfoId = Double(rdaid)
        }
        else if let rdaid = consumer?.rdaCustomerAccInfoId as? Double {
            rdaCustomerAccInfoId = rdaid
        }
        else if let rdaid = consumer?.rdaCustomerAccInfoId as? String {
            rdaCustomerAccInfoId = Double(rdaid)!
        }
//        guard let consumerListInputModelll = ConsumerListInputModel(
//            cnicNumber: viewAppGenerateOTPResponse.idNumber ?? "",
//            mobileNumber: viewAppGenerateOTPResponse.mobileNo ?? "",
//            isPrimary: viewAppGenerateOTPResponse.isPrimary ?? false,
//            customerTypeID: BaseConstants.Config.customerTypeID,
//            customerBranch: consumer?.customerBranch ?? "",
//            bankingModeID: consumer?.accountInformation?.bankingModeID, //selectBankingMethodViewModel.getBankingModeID(),
//            dateOfBirth: viewAppGenerateOTPResponse.dateOfBirth ?? "",
//            dateOfIssue: viewAppGenerateOTPResponse.dateOfIssue ?? "",
//            isPrimaryRegistered: false,
//            rdaCustomerAccInfoId:  rdaCustomerAccInfoId,
//            attachments: [[String : Any]]()
//        ) else { return }
        
        
        guard let basicInfoConsumerListInput = BasicInfoConsumerListInputModel(
                    rdaCustomerAccInfoId: rdaCustomerAccInfoId,
        //            rdaCustomerProfileId: currentUser.rdaCustomerProfileID as? Double,
                    isPrimary: viewAppGenerateOTPResponse.isPrimary ?? false,
                    isPrimaryRegistered: false,
                    customerTypeId: BaseConstants.Config.customerTypeID,
                    mobileNo: viewAppGenerateOTPResponse.mobileNo ?? "",
                    dateOfBirth: viewAppGenerateOTPResponse.dateOfBirth ?? "",
                    dateOfIssue: viewAppGenerateOTPResponse.dateOfIssue ?? "",
                    idNumber: viewAppGenerateOTPResponse.idNumber ?? "",
                    attachments: [[String : Any]](),
                    customerBranch: consumer?.customerBranch ?? "",
                    bankingModeId: consumer?.accountInformation?.bankingModeID
                ) else { return }
        
        
        consumerListInputModelArray.append(basicInfoConsumerListInput)
        consumerList?.forEach {
            
//            guard let consumerListInputModel = BasicInfoConsumerListInputModel(
//                cnicNumber: $0.idNumber ?? "",
//                mobileNumber: $0.mobileNo ?? "",
//                isPrimary: $0.isPrimary ?? false,
//                customerTypeID: BaseConstants.Config.customerTypeID,
//                customerBranch: $0.customerBranch ?? "",
//                bankingModeID: consumer?.accountInformation?.bankingModeID, //selectBankingMethodViewModel.getBankingModeID(),
//                dateOfBirth: $0.dateOfBirth ?? "",
//                dateOfIssue: $0.dateOfIssue ?? "",
//                isPrimaryRegistered: $0.isPrimary ?? false,
//                rdaCustomerAccInfoId: rdaCustomerAccInfoId,
//                attachments: [[String : Any]]()
//            ) else { return }
//
            guard let basicInfoConsumerListInput = BasicInfoConsumerListInputModel(
                        rdaCustomerAccInfoId: rdaCustomerAccInfoId,
            //            rdaCustomerProfileId: currentUser.rdaCustomerProfileID as? Double,
                        isPrimary: $0.isPrimary ?? false,
                        isPrimaryRegistered: $0.isPrimary ?? false,
                        customerTypeId: BaseConstants.Config.customerTypeID,
                        mobileNo: $0.mobileNo ?? "",
                        dateOfBirth: $0.dateOfBirth ?? "",
                        dateOfIssue: $0.dateOfIssue ?? "",
                        idNumber: $0.idNumber ?? "",
                        attachments: [[String : Any]](),
                        customerBranch: $0.customerBranch ?? "",
                        bankingModeId: consumer?.accountInformation?.bankingModeID
                    ) else { return }
            
            consumerListInputModelArray.append(basicInfoConsumerListInput)
        }
        
//        print(DataCacheManager.shared.loadNoOfJointApplicants())
//        print(consumer)
//        print(DataCacheManager.shared.loadRegisterConsumerAccountInfoResponse())
//        print(consumerListInputModelArray)
        
        //TODO: add data of primary and all the secondary applicants in consumerList Array
        guard let registerVerifyOTPInput = RegisterVerifyOTPInputModel(consumerList: consumerListInputModelArray, noOfJointApplicants: DataCacheManager.shared.loadNoOfJointApplicants() ?? 0, bioMetricVerificationNadraMobileReq: nil, channelId: BaseConstants.Config.channelID, customerTypeId: BaseConstants.Config.customerTypeID) else { return }

        registerVerifyOTP(input: registerVerifyOTPInput)
    }
    
    func registerVerifyOTP(input: RegisterVerifyOTPInputModel?) {
        guard let input = input else { return }
        
        APIManager.shared.registerVerifyOTP(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                var registerVerifyOTPResponse: RegisterVerifyOTPResponseModel = value
                DataCacheManager.shared.saveRegisterVerifyOTPResponse(input: registerVerifyOTPResponse)
//                DataCacheManager.shared.saveRegisterVerifyOTPResponseModel(registerVerifyOTPResponseModel: value)
                self.openPersonalInformationVC()
            case .failure(let error):
                var errorMessage: String? = error.errorDescription
                self.showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: errorMessage ?? "")
            }
        }
    }
}
