//
//  CNICVerificationVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 15/03/2022.
//

import UIKit
import BetterSegmentedControl

final class CNICVerificationVC: UIViewController {
    
    // MARK: - Class Outlets
    
    @IBOutlet weak var cnicFrontSideLabel: UILabel!
    @IBOutlet weak var cnicFrontSideImageView: UIImageView!
    
    @IBOutlet weak var cnicBackSideLabel: UILabel!
    @IBOutlet weak var cnicBackSideImageView: UIImageView!
    
    @IBOutlet weak var cnincfromimageInstruct: UIImageView!
    @IBOutlet weak var cnincbackimageInstruct: UIImageView!
    
    private var frontSideImagePicker = UIImagePickerController()
    private var backSideImagePicker = UIImagePickerController()
    
    private let cnicVerificationViewModel = CNICVerificationViewModel()
    private let selectBankingMethodViewModel = SelectBankingMethodViewModel()
    
    var mobileNumber: String?
    var isPortedMobileNetwork: Bool?
    lazy var jointAccountSecondaryApplicant = false
    
    private var frontSideCNICData: Data?
    private var backSideCNICData: Data?
    var cameFromJointFlow = false
    
    var callBackBackButton: (() -> ())!
    
    override func viewWillAppear(_ animated: Bool) {
        if modelRegistrationSteper.cnicFrontSideImageView != nil {
            cnicFrontSideImageView.image =  modelRegistrationSteper.cnicFrontSideImageView
        }
        if modelRegistrationSteper.cnicBackSideImageView != nil {
            cnicBackSideImageView.image =  modelRegistrationSteper.cnicBackSideImageView
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cnicFrontSideLabel.makeUnderlinedAttributedText(
            underlinedString: "Front Side"
        )
        
        cnicBackSideLabel.makeUnderlinedAttributedText(
            underlinedString: "Back Side"
        )
        toggleUpload.segments = LabelSegment.segments(
            withTitles: ["No".localizeString(), "Yes".localizeString()],
            normalBackgroundColor: PluginColorAsset.otpFieldBorder.color,
            normalTextColor: .white,
            selectedBackgroundColor: PluginColorAsset.appOrange.color,
            selectedTextColor: .white
        )
        
        setupGestureRecognizers()
        subscribeViewModel()
    }
    
    func validationsError() -> Bool {
        if cnicFrontSideImageView.tag == 0 {
            showAlertSuccessWithPopToVC(viewController: self, title: "Alert", message: "Please add front cnic picture")
            return true
        }
        else if cnicBackSideImageView.tag == 0 {
            showAlertSuccessWithPopToVC(viewController: self, title: "Alert", message: "Please add back cnic picture")
            return true
        }
        return false
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if validationsError() {
            return()
        }
        //        print(frontSideCNICData?.base64EncodedString(), "frontSideCNICData?.base64EncodedString()...")
        //        print(backSideCNICData?.base64EncodedString(), "backSideCNICData?.base64EncodedString()")
                

                cnicVerificationViewModel.viewAppGenerateOTPWithAttachment(
                    customerTypeID: 106501,
                    mobileNumber:mobileNumber?.replacingOccurrences(of: "-", with: ""),
                    generateOTP: jointAccountSecondaryApplicant ? false : true,
                    cnicFront: cnicFrontSideImageView.image!.toBase64String2(),
                    cnicBack: cnicBackSideImageView.image!.toBase64String2(),
//                    cnicFront: frontSideCNICData?.base64EncodedString().replacingOccurrences(of: "\\", with: ""),
//                    cnicBack: backSideCNICData?.base64EncodedString().replacingOccurrences(of: "\\", with: ""),
                    isPortedMobileNetwork: isPortedMobileNetwork
                )
                modelRegistrationSteper.cnicFrontSideImageView = cnicFrontSideImageView.image
                modelRegistrationSteper.cnicBackSideImageView = cnicBackSideImageView.image
                
        //        guard let viewAppGenerateResponseModel = DataCacheManager.shared.loadViewAppGenerateOTPResponse() else { return }
        //
        //
        //        "rdaCustomerAccInfoId": 6332, "idNumber": "0348110473971", "dateOfBirth": "29/08/1991", "dateOfIssue": "26/07/2021", "mobileNo": "02569877444", "isPrimary": true, "isPrimaryRegistered": true, "customerTypeId": 106501, "customerBranch": "Abdul Hakim", "bankingModeId": 114201, "portedMobileNetwork": 0
                
        //        guard let consumerListInputModel = ConsumerListInputModel(
        //            cnicNumber: viewAppGenerateResponseModel.idNumber ?? "",
        //            mobileNumber: viewAppGenerateResponseModel.mobileNo ?? "",
        //            isPrimary: true,
        //            customerTypeID: BaseConstants.Config.customerTypeID,
        //            customerBranch: selectBankingMethodViewModel.getBranchName(),
        //            bankingModeID: selectBankingMethodViewModel.getBankingModeID(),
        //            dateOfBirth: viewAppGenerateResponseModel.dateOfBirth ?? "",
        //            dateOfIssue: viewAppGenerateResponseModel.dateOfIssue ?? "",
        //            isPrimaryRegistered: true,
        //            portedMobileNetwork: false
        //        ) else { return }
                

                
                //TODO: add data of primary and all the secondary applicants in consumerList Array
                

                
            }
    
    @IBAction func btnViewFront(_ sender: UIButton){
        let imageView = cnicFrontSideImageView!
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    @IBAction func btnViewBack(_ sender: UIButton){
        let imageView = cnincbackimageInstruct!
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    @IBAction func btnFrontSide(_ sender: UIButton){
        frontSideImagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            frontSideImagePicker.sourceType = .camera
        }
        else {
            frontSideImagePicker.sourceType = .photoLibrary
        }
        frontSideImagePicker.allowsEditing = true
        frontSideImagePicker.delegate = self
        present(frontSideImagePicker, animated: true)
    }
    @IBAction func btnBackSide(_ sender: UIButton){
        backSideImagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            backSideImagePicker.sourceType = .camera
        }
        else {
            backSideImagePicker.sourceType = .photoLibrary
        }
        backSideImagePicker.allowsEditing = true
        backSideImagePicker.delegate = self
        present(backSideImagePicker, animated: true)
    }
    private func callRegisterVerifyOTP(){
        var consumerListInputModelArray = [BasicInfoConsumerListInputModel]()
        consumerListInputModelArray = getListOfConsumers(newUserInfo: BasicInfoConsumerListInputModel()!)
        //TODO: add data of primary and all the secondary applicants in consumerList Array
        guard let registerVerifyOTPInput = RegisterVerifyOTPInputModel(consumerList: consumerListInputModelArray, noOfJointApplicants: 0, bioMetricVerificationNadraMobileReq: nil, channelId: BaseConstants.Config.channelID, customerTypeId: BaseConstants.Config.customerTypeID) else { return }
        
        selectBankingMethodViewModel.registerVerifyOTP(input: registerVerifyOTPInput)
        
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
//        self.view.window?.rootViewController?.dismiss(animated: true)
        callBackBackButton?()
        navigationController?.popViewController(animated: true)
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
    
    private func openCNICVerificationManualVC() {
        guard let verifyOTPVC = UIStoryboard.initialize(
            viewController: .CNICManualVerificationVC,
            fromStoryboard: .cnicUpload
        ) as? CNICManualVerificationVC else { return }
        
        verifyOTPVC.mobileNumber = self.mobileNumber?.replacingOccurrences(of: "-", with: " ")
        navigationController?.pushViewController(verifyOTPVC, animated: true)
    }
    
    private func openPersonalInformationVC() {
        guard let personalInformationVC = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC else { return }
                
        navigationController?.pushViewController(personalInformationVC, animated: true)
    }
    
    private func setupGestureRecognizers() {
        cnicFrontSideLabel.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(setupCnicFrontImagePicker)
            )
        )
        cnincbackimageInstruct.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(viewFullimg)
            )
        )
        cnincfromimageInstruct.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(viewFullimg)
            )
        )
        
        cnicBackSideLabel.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(setupCnicBackImagePicker)
            )
        )
    }
    
    @objc
    private func setupCnicFrontImagePicker() {
        frontSideImagePicker = UIImagePickerController()
        frontSideImagePicker.sourceType = .photoLibrary
//        frontSideImagePicker.sourceType = .camera
        frontSideImagePicker.allowsEditing = true
        frontSideImagePicker.delegate = self
        present(frontSideImagePicker, animated: true)
    }
    @IBOutlet weak var btnBackSide: ButtonSetting!
    @IBOutlet weak var toggleUpload: BetterSegmentedControl!
    @IBAction func toggleUpload(_ sender: Any) {
        if toggleUpload.index == 1 {
            btnBackSide.isHidden = true
            btnFrontSide.isHidden = true
//            buttonScan.isHidden = false
//            buttonScanBack.isHidden = false
            buttonUpload.isHidden = false
            buttonUploadBack.isHidden = false
        }
        else {
            btnBackSide.isHidden = false
            btnFrontSide.isHidden = false
//            buttonScan.isHidden = true
//            buttonScanBack.isHidden = true
            buttonUpload.isHidden = true
            buttonUploadBack.isHidden = true
        }
    }
    @IBOutlet weak var btnFrontSide: ButtonSetting!
    @IBOutlet weak var buttonUpload: ButtonSetting!
    @IBAction func buttonUpload(_ sender: Any) {
        frontSideImagePicker = UIImagePickerController()
        frontSideImagePicker.sourceType = .photoLibrary
        frontSideImagePicker.allowsEditing = true
        frontSideImagePicker.delegate = self
        present(frontSideImagePicker, animated: true)
    }
    @IBOutlet weak var buttonScan: ButtonSetting!
    @IBAction func buttonScan(_ sender: Any) {
        frontSideImagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            frontSideImagePicker.sourceType = .camera
        }
        else {
            frontSideImagePicker.sourceType = .photoLibrary
        }
        frontSideImagePicker.allowsEditing = true
        frontSideImagePicker.delegate = self
        present(frontSideImagePicker, animated: true)
    }
    @IBOutlet weak var buttonScanBack: ButtonSetting!
    @IBAction func buttonUploadBack(_ sender: Any) {
        frontSideImagePicker = UIImagePickerController()
        frontSideImagePicker.sourceType = .photoLibrary
        frontSideImagePicker.allowsEditing = true
        frontSideImagePicker.delegate = self
        present(backSideImagePicker, animated: true)
    }

    @IBOutlet weak var buttonUploadBack: ButtonSetting!
    @IBAction func buttonScanBack(_ sender: Any) {
        frontSideImagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            frontSideImagePicker.sourceType = .camera
        }
        else {
            frontSideImagePicker.sourceType = .photoLibrary
        }
        frontSideImagePicker.allowsEditing = true
        frontSideImagePicker.delegate = self
        present(backSideImagePicker, animated: true)
    }
    
    @objc private func viewFullimg() {
    let imageView = cnicFrontSideImageView!
    let newImageView = UIImageView(image: imageView.image)
    newImageView.frame = UIScreen.main.bounds
    newImageView.backgroundColor = .black
    newImageView.contentMode = .scaleAspectFit
    newImageView.isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
    newImageView.addGestureRecognizer(tap)
    self.view.addSubview(newImageView)
    self.navigationController?.isNavigationBarHidden = true
    self.tabBarController?.tabBar.isHidden = true
}
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    @objc
    private func setupCnicBackImagePicker() {
        backSideImagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            frontSideImagePicker.sourceType = .camera
        }
        else {
            frontSideImagePicker.sourceType = .photoLibrary
        }
        backSideImagePicker.allowsEditing = true
        backSideImagePicker.delegate = self
        present(backSideImagePicker, animated: true)
    }
    
    private func subscribeViewModel() {
        cnicVerificationViewModel.openAccountUserData.bind { [weak self] response in
            guard let self = self, let response = response else { return }
            
            // These two functions are used together, the first appends the response and the second saves the array in user defaults.
            //            DataCacheManager.shared.appendViewAppGenerateOTPResponse(response: response)
            //            DataCacheManager.shared.saveViewAppGenerateOTPResponseArray()
            
            DataCacheManager.shared.saveViewAppGenerateOTPResponse(input: response)
            
            if !self.cameFromJointFlow {
                if let _ = response.idNumber{
                    
                    //for testing
//                    self.cnicVerificationViewModel.openVerifyCNICManually()
//                    return()
                    
                    self.cnicVerificationViewModel.openVerifyOTPVC()
                    
                } else {
                    self.cnicVerificationViewModel.openVerifyCNICManually()
                    // open get id card and date of expiry manually
                }
                
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
                    self?.cnicVerificationViewModel.saveKyc(rdaCustomerAccInfoId: rdaCustomerAccountInfoId, rdaCustomerProfileId: rdaCustomerProfileId, isPrimary: false, relationCode1: relationCode, averageMonthlySalary: nil)
                }
            }
            
        }
        
        cnicVerificationViewModel.saveKYCResponseData.bind { [weak self] response in
            guard let statusCode = response?.message?.status, let message = response?.message?.description else { return }
            if statusCode == "200" && message.lowercased() == "success"{
                self?.cnicVerificationViewModel.openPersonalInformationVC()
            }
        }
        cnicVerificationViewModel.routeToManualVeificationVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openCNICVerificationManualVC()
        }
    }
    
    func openPortedPopupVC(viewController: UIViewController, message: String) {
        guard let portedPopupVC = UIStoryboard.initialize(
            viewController: .portedPopupVC,
            fromStoryboard: .cnicUpload
        ) as? PortedPopupVC else { return }
        
        portedPopupVC.message = message
        portedPopupVC.buttonTitle = "OK"
        portedPopupVC.portedMobileNetwork = {
            
        }
        viewController.present(portedPopupVC, animated: true)
    }
    
    @IBAction func cnicFrontEyeIconTapped(_ sender: Any) {
        let message  = "The picture shall be complete, clear and not blur. Maximum upload size is 5MB"
        openPortedPopupVC(viewController: self, message: message)
    }
    
    @IBAction func cnicBackEyeIconTapped(_ sender: Any) {
        let message  = "The picture shall be complete, clear and not blur. Maximum upload size is 5MB"
        openPortedPopupVC(viewController: self, message: message)
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
        currentConsumerList[foundIndex].customerTypeId = newUserInfo.customerTypeId
        currentConsumerList[foundIndex].mobileNo = newUserInfo.mobileNo
        currentConsumerList[foundIndex].dateOfBirth = newUserInfo.dateOfBirth
        currentConsumerList[foundIndex].dateOfIssue = newUserInfo.dateOfIssue
        currentConsumerList[foundIndex].idNumber = newUserInfo.idNumber
        currentConsumerList[foundIndex].attachments = newUserInfo.attachments
        currentConsumerList[foundIndex].customerBranch = newUserInfo.customerBranch
        currentConsumerList[foundIndex].bankingModeId = newUserInfo.bankingModeId
        currentConsumerList[foundIndex].genderId = modelRegistrationSteper.genderId == 0 ? nil : newUserInfo.genderId

        return currentConsumerList
    }
}

//irfan
extension CNICVerificationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
//        let image = info[.originalImage] as? UIImage
        if picker == frontSideImagePicker {
            cnicFrontSideImageView.image = image
            frontSideCNICData = image.jpeg(.low)
            cnicFrontSideImageView.tag = 1
        } else {
            cnicBackSideImageView.image = image
            backSideCNICData = image.jpeg(.low)
            cnicBackSideImageView.tag = 1
        }

    }

}

extension UIImage {
    func toBase64String2() -> String {
        //Use image name from bundle to create NSData
        //Now use image to create into NSData format
        let imageData:Data = self.jpeg(.low)!
        let base64String = imageData.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        let imgStr = base64String.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //print(imgStr)
        return imgStr!
    }
    enum JPEGQuality: CGFloat {
            case lowest  = 0
            case low     = 0.25
            case medium  = 0.5
            case high    = 0.75
            case highest = 1
        }
        func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
            return jpegData(compressionQuality: jpegQuality.rawValue)
        }
}

