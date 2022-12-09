//
//  CNICVerificationVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 15/03/2022.
//

import UIKit

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
        
        setupGestureRecognizers()
        subscribeViewModel()
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
//        print(frontSideCNICData?.base64EncodedString(), "frontSideCNICData?.base64EncodedString()...")
//        print(backSideCNICData?.base64EncodedString(), "backSideCNICData?.base64EncodedString()")
        cnicVerificationViewModel.viewAppGenerateOTPWithAttachment(
            customerTypeID: 106501,
            mobileNumber: mobileNumber,
            generateOTP: jointAccountSecondaryApplicant ? false : true,
            cnicFront: frontSideCNICData?.base64EncodedString(),
            cnicBack: backSideCNICData?.base64EncodedString(),
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
        //shakeel
        frontSideImagePicker.sourceType = .photoLibrary
//        frontSideImagePicker.sourceType = .camera
//        frontSideImagePicker.allowsEditing = true
        frontSideImagePicker.delegate = self
        present(frontSideImagePicker, animated: true)
    }
    @IBAction func btnBackSide(_ sender: UIButton){
        backSideImagePicker = UIImagePickerController()
        //shakeel

        frontSideImagePicker.sourceType = .photoLibrary

//        backSideImagePicker.sourceType = .camera
//        backSideImagePicker.allowsEditing = true
        backSideImagePicker.delegate = self
        present(backSideImagePicker, animated: true)
    }
    private func callRegisterVerifyOTP(){
        
        guard let viewAppGenerateResponseModel = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList else { return }
        var consumerListInputModelArray = [ConsumerListInputModel]()
        
        viewAppGenerateResponseModel.forEach {
            guard let consumerListInputModel = ConsumerListInputModel(
                cnicNumber: $0.idNumber ?? "",
                mobileNumber: $0.mobileNo ?? "",
                isPrimary: $0.isPrimary ?? false,
                customerTypeID: BaseConstants.Config.customerTypeID,
                customerBranch: selectBankingMethodViewModel.getBranchName(),
                bankingModeID: selectBankingMethodViewModel.getBankingModeID(),
                dateOfBirth: $0.dateOfBirth ?? "",
                dateOfIssue: $0.dateOfIssue ?? "",
                attachments: [String]()
            ) else { return }
            
            consumerListInputModelArray.append(consumerListInputModel)
        }
        //TODO: add data of primary and all the secondary applicants in consumerList Array
        guard let registerVerifyOTPInput = RegisterVerifyOTPInputModel(consumerList: consumerListInputModelArray, noOfJointApplicants: 0, bioMetricVerificationNadraMobileReq: nil, channelId: BaseConstants.Config.channelID, customerTypeId: BaseConstants.Config.customerTypeID) else { return }
        
        selectBankingMethodViewModel.registerVerifyOTP(input: registerVerifyOTPInput)
        
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true)
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
        
        verifyOTPVC.mobileNumber = self.mobileNumber
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
        //shakeel
        frontSideImagePicker.sourceType = .photoLibrary

//        frontSideImagePicker.sourceType = .camera
        frontSideImagePicker.allowsEditing = true
        frontSideImagePicker.delegate = self
        present(frontSideImagePicker, animated: true)
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
        //shakeel

        frontSideImagePicker.sourceType = .photoLibrary

//        backSideImagePicker.sourceType = .camera
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
}

//irfan
extension CNICVerificationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true)



//        guard let image = info[.editedImage] as? UIImage else {

//            print("No image found")

//            return

//        }

        let image = info[.originalImage] as? UIImage



        if picker == frontSideImagePicker {

            cnicFrontSideImageView.image = image

            frontSideCNICData = image?.jpegData(compressionQuality: 1)

        } else {

            cnicBackSideImageView.image = image

            backSideCNICData = image?.jpegData(compressionQuality: 1)

        }

    }

}
