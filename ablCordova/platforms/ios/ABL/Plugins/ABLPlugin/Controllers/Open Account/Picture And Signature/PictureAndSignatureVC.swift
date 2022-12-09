//
//  PictureAndSignatureVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/03/2022.
//

import UIKit
import BetterSegmentedControl
import DropDown

final class PictureAndSignatureVC: UIViewController {
    
    @IBOutlet weak var singleAccountView: UIView!
    @IBOutlet weak var singleAccountRadio: UIImageView!
    
<<<<<<< HEAD
    @IBAction func segmentJointAccount(_ sender: BetterSegmentedControl) {
        if sender.index == 1 {
            viewSelectNatureOfAccount.isHidden = false
            natureOfAccountLocal = .joint
            picAndSignViewModel.jointAccountTapped()
            self.joint()
        }
        else {
            viewSelectNatureOfAccount.isHidden = true
            natureOfAccountLocal = .single
            picAndSignViewModel.singleAccountTapped()
            self.single()
        }
    }
=======
>>>>>>> e3b24a2 (Bug Fixing)
    @IBOutlet weak var jointAccountView: UIView!
    
    @IBOutlet weak var selectAdditionalApplicantView: UIView!
    @IBOutlet weak var additionalApplicantLabel: UILabel!
    
    @IBOutlet weak var jointAccountRadio: UIImageView!
    
    @IBOutlet weak var minorAccountView: UIView!
    @IBOutlet weak var minorAccountRadio: UIImageView!
    @IBOutlet weak var livePhotoPreviewImageView: UIImageView!
    @IBOutlet weak var signaturePreviewImageView: UIImageView!
    
    @IBOutlet weak var additionalApplicantListView: CustomUIView!
    
    private var picAndSignViewModel = PicAndSignViewModel()
    
    private var pictureImagePicker = UIImagePickerController()
    private var signImagePicker = UIImagePickerController()
    
    private var livePictureData: Data?
    private var signData: Data?
    
    private let dropDown = DropDown()
    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    
    var natureOfAccountLocal = NatureOfAccount.single
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoadLocal()
<<<<<<< HEAD
        viewProofOfIncome.isHidden = true
        self.selectAdditionalApplicantView.isHidden = false

        if modelRegistrationSteper.proofOfIncomeInd == 1 {
            viewProofOfIncome.isHidden = false
        }
        if modelRegistrationSteper.isJointAccount {
            segmentJointAccount.setIndex(modelRegistrationSteper.isJointAccount ? 1 : 0)
        }
=======
>>>>>>> e3b24a2 (Bug Fixing)
    }
    override func viewWillAppear(_ animated: Bool) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropdown()
        dropDown.dataSource = [
            "1 Additional Applicant",
            "2 Additional Applicants",
            "3 Additional Applicants",
            "4 Additional Applicants",
            "5 Additional Applicants"
        ]
        
        livePhotoPreviewImageView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(takePictureTapped(_:))
            )
        )
        signaturePreviewImageView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(uploadSignTapped(_:))
            )
        )
        subscribeViewModel()
        setupGestureRecognizers()
    }
    
    override func viewDidLayoutSubviews() {
        //        setupViews()
    }
    
    func viewDidLoadLocal(){
        var tempNoOfParticipant = ""
        if modelRegistrationSteper.picAndSignViewModel != nil {
            tempNoOfParticipant = modelRegistrationSteper.additionalApplicant!
            print(tempNoOfParticipant as Any)
            
            let tempViewModel = modelRegistrationSteper.picAndSignViewModel!
            if let natureOfAccount = tempViewModel.getNatureOfAccount() {
                print(natureOfAccount)
                switch natureOfAccount {
                case .single:
                    natureOfAccountLocal = .single
                    picAndSignViewModel.singleAccountTapped()
                    self.single()
                case .joint:
                    natureOfAccountLocal = .joint
                    picAndSignViewModel.jointAccountTapped()
                    self.joint()
                case .minor:
                    natureOfAccountLocal = .minor
                    self.minor()
                    picAndSignViewModel.minorAccountTapped()
                }
            }
            
            if modelRegistrationSteper.signaturePreviewImage != nil {
                self.signaturePreviewImageView.image = modelRegistrationSteper.signaturePreviewImage
            }
            if modelRegistrationSteper.livePhotoPreviewImage != nil {
                self.livePhotoPreviewImageView.image = modelRegistrationSteper.livePhotoPreviewImage
            }
            if modelRegistrationSteper.additionalApplicantNo != nil {
                additionalApplicantLabel.text = tempNoOfParticipant
                if tempNoOfParticipant != "" {
                    modelRegistrationSteper.additionalApplicant = tempNoOfParticipant
                }
            }
        }
        
        
    }
    
    
    @IBAction func backBtnTapped(_ sender: UIButton){
        if let count = self.parent?.children.count{
            if count > 1 {
                self.delegate?.removeChild()
                self.parent?.children.last?.remove()
            }else{
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func validationError() -> Bool {
        if segmentJointAccount.index == 1 {
            if additionalApplicantLabel.text == "Select additional applicants" {
                self.showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: "Please select additional applicants")
                return true
            }
        }
        
        if modelRegistrationSteper.proofOfIncomeInd == 1 && imageProofOfIncome.tag != 1 {
            self.showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: "Please upload proof of income")
            return true
        }
        
        //False means no error
        return false
    }
    @IBAction func nextBtnTapped(_ sender: UIButton) {
<<<<<<< HEAD
        if validationError() {
            return()
        }
        modelRegistrationSteper.isJointAccount = segmentJointAccount.index == 1 ? true : false
=======
        
>>>>>>> e3b24a2 (Bug Fixing)
        if let natureOfAccount = picAndSignViewModel.getNatureOfAccount() {
            
            guard let consumer = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.first, let rdaCustomerProfileID = consumer.rdaCustomerProfileID else {
                return
            }
            
            
            if natureOfAccount != .joint {
                logsManager.debug(natureOfAccount.rawValue)
                picAndSignViewModel.saveNatureOfAccount(
                    rdaCustomerProfileId: consumer.rdaCustomerProfileID,
                    rdaCustomerAccInfoId: consumer.accountInformation?.rdaCustomerAccInfoID,
                    rdaCustomerId: consumer.accountInformation?.rdaCustomerID,
                    customerTypeId: BaseConstants.Config.customerTypeID,
                    //                        customerTypeId: consumer.customerTypeID,
                    natureOfAccountId: natureOfAccount.code,
                    noOfJointApplicatns: 0,
                    nameOnPhysicalATM: consumer.fullName
                )
            } else {
                let noOfJointApplicants = picAndSignViewModel.getNoOfJointApplicants()
                DataCacheManager.shared.saveNoOfJointApplicants(input: noOfJointApplicants)
                
                //                if noOfJointApplicants > 0 {
                logsManager.debug(natureOfAccount.rawValue, noOfJointApplicants)
                picAndSignViewModel.saveNatureOfAccount(
                    rdaCustomerProfileId: consumer.rdaCustomerProfileID,
                    rdaCustomerAccInfoId: consumer.accountInformation?.rdaCustomerAccInfoID,
                    rdaCustomerId: consumer.accountInformation?.rdaCustomerID,
                    customerTypeId: BaseConstants.Config.customerTypeID,
                    //                        customerTypeId: consumer.customerTypeID,
                    natureOfAccountId: natureOfAccount.code,
                    noOfJointApplicatns: Int(noOfJointApplicants),
                    nameOnPhysicalATM: String(rdaCustomerProfileID) // rdaCustomerProfileID of primary applicant
                )
                //                } else {
                // move to
                modelRegistrationSteper.picAndSignViewModel = picAndSignViewModel
                openAdditionalDetailsVC()
                //                    AlertManager.shared.showOKAlert(with: "Error", message: "Please select number of joint applicants")
                //                }
            }
            
        } else {
            AlertManager.shared.showOKAlert(with: "Error", message: "Please select the nature of account")
        }
        
        
    }
    
    @objc private func takePictureTapped(_ sender: UIButton){
        
        pictureImagePicker = UIImagePickerController()
        //        pictureImagePicker.sourceType = .camera
        pictureImagePicker.sourceType = .photoLibrary
        
        pictureImagePicker.allowsEditing = true
        pictureImagePicker.delegate = self
        present(pictureImagePicker, animated: true)
        
    }
    
    @objc private func uploadSignTapped(_ sender: UIButton){
        
        signImagePicker = UIImagePickerController()
        //        signImagePicker.sourceType = .camera
        pictureImagePicker.sourceType = .photoLibrary
        
        signImagePicker.allowsEditing = true
        signImagePicker.delegate = self
        present(signImagePicker, animated: true)
        
    }
    
    private func subscribeViewModel() {
        
        picAndSignViewModel.saveAttachmentResponse.bind { [weak self]  response  in
            
        }
        picAndSignViewModel.registerPicAndSignResponse.bind { [weak self]  response  in
            
            guard let status = response?.message?.status, let description = response?.message?.description?.lowercased() else { return }
            if status == "200" && description.lowercased() == "success"{
                //TODO: check if no of applicants
                modelRegistrationSteper.picAndSignViewModel = self?.picAndSignViewModel
                self?.openReviewDetailsVC()
                
            }
        }
        
        picAndSignViewModel.errorMessage.bind {  error in
            guard let error = error else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: error)
        }
        
        picAndSignViewModel.natureOfAccount.bind { [weak self]  natureOfAccount in
            guard let self = self, let natureOfAccount = natureOfAccount else { return }
            switch natureOfAccount {
            case .single:
                self.single()
            case .joint:
                self.joint()
            case .minor:
                self.minor()
            }
        }
        picAndSignViewModel.dropDownTapped.bind { [weak self]  isTapped in
            guard let self = self, isTapped else { return }
            self.dropDown.show()
        }
    }
    
    func single() {
        self.singleAccountRadio.image = PluginImageAsset.radioFilled.image
        self.jointAccountRadio.image = PluginImageAsset.radioUnfilled.image
        self.selectAdditionalApplicantView.isHidden = true
        self.minorAccountRadio.image = PluginImageAsset.radioUnfilled.image
        self.additionalApplicantLabel.text = "Select additional applicants"
        modelRegistrationSteper.additionalApplicant = "Select additional applicants"
        natureOfAccountLocal = .single
        DataCacheManager.shared.saveNoOfJointApplicants(input: 0)
    }
    func joint() {
        self.singleAccountRadio.image = PluginImageAsset.radioUnfilled.image
        self.jointAccountRadio.image = PluginImageAsset.radioFilled.image
        self.selectAdditionalApplicantView.isHidden = false
        self.minorAccountRadio.image = PluginImageAsset.radioUnfilled.image
        self.additionalApplicantLabel.text = "Select additional applicants"
        modelRegistrationSteper.additionalApplicant = "Select additional applicants"
        natureOfAccountLocal = .joint
    }
    func minor() {
        self.singleAccountRadio.image = PluginImageAsset.radioUnfilled.image
        self.jointAccountRadio.image = PluginImageAsset.radioUnfilled.image
        self.selectAdditionalApplicantView.isHidden = true
        self.minorAccountRadio.image = PluginImageAsset.radioFilled.image
        self.additionalApplicantLabel.text = "Select additional applicants"
        modelRegistrationSteper.additionalApplicant = "Select additional applicants"
        natureOfAccountLocal = .minor
    }
    
    private func openReviewDetailsVC() {
        guard let reviewDetailsVC = UIStoryboard.initialize(
            viewController: .reviewDetailsVC,
            fromStoryboard: .openAccount
        ) as? ReviewDetailsVC else { return }
        
        switch natureOfAccountLocal {
        case .single: break
           // navigationController?.pushViewController(reviewDetailsVC, animated: true)
        case .joint: break
            
        case .minor: break
            //navigationController?.pushViewController(reviewDetailsVC, animated: true)
        }
        
        
        guard let personalInformationBaseVC = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC else { return }
        
        //        switch selectPreferredAccountViewModel.getAccountVariantID(){
////        case .asaanDigitalAccount:
////            personalInformationBaseVC.firstChild = .personalInfoSecondVC
////        case .asaanDigitalRemittanceAccount:
////            personalInformationBaseVC.firstChild = .taxResidentDetailVC
//        case .freelancerDigitalAccount:
//            personalInformationBaseVC.firstChild = .fatcaVC
////        case .currentAccount:
////            personalInformationBaseVC.firstChild = .personalInfoSecondVC
//        default:
//            personalInformationBaseVC.firstChild = .personalInfoSecondVC
////            logsManager.debug("Default case")
//        }
        //MARK: - if user is pramary so joint account button will b show otherwise hide
        //if account category is single then check from below mention account with OR condition
        
        
        
        guard let personalInformationBaseVC = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC else { return }

        
        var results = [Int]()
        for i in (108243 ..< 108255) {
            results.append(i)
        }
//        print(results)
//        print(accountVariantID)
//        print(AccountVariant.currentAccount.id)
//        print(AccountVariant.currentAccount)
        //Shakeel
        //don't show residential address screen from ACCOUNT_VARIANT_ID 108243 to 108253
        //go directly to nationality in this scenario
        //never go to employment screen directly
        
        
//        edit ka case is me handle karna ha in sy pehlay
        var isJointAccount = modelRegistrationSteper.isJointAccount
        let accountVariantID = modelRegistrationSteper.selectPreferredAccountViewModel?.getAccountVariantID()
        if !isJointAccount {
            if (results.first{$0  == Int(accountVariantID?.rawValue ?? 0)} != nil) {
                guard let reviewDetailsVC = UIStoryboard.initialize(
                    viewController: .reviewDetailsVC,
                    fromStoryboard: .openAccount
                ) as? ReviewDetailsVC else { return }
                navigationController?.pushViewController(reviewDetailsVC, animated: true)

            }
            else {
                self.delegate?.addChild(vc: .fatcaDetailsVC, fromViewController: "")
            }
        }
        else {
            let consumer = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last
            
            print(consumer)
            print(DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList)
            print(DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.count)
            
            
        }
       
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //Android Check
//        if (getIntent().hasExtra(Config.INDEX)) {
//            openActivity(ReviewDocumentActivity.class);
//        } else {
//            int selectedJointApplicant = consumerList.get(0).getAccountInformation().getNoOfJointApplicatns();
//            if (selectedJointApplicant == 0 || index == selectedJointApplicant) {
//
//                if (getIntFromPref(Config.ACCOUNT_VARIANT_ID) == Config.ASAAN_DIGITAL_ACCOUNT ||
//                        getIntFromPref(Config.ACCOUNT_VARIANT_ID) == Config.REMITTANCE_ACCOUNT
//                    ||
//                        getIntFromPref(Config.ACCOUNT_VARIANT_ID) == Config.ASAAN_DIGITAL_REMITTANCE_SAVING_ACCOUNT ||
//                    getIntFromPref(Config.ACCOUNT_VARIANT_ID) == Config.FREELANCE_DIGITAL_SAVING_ACCOUNT ||
//                    getIntFromPref(Config.ACCOUNT_VARIANT_ID) == Config.FREELANCE_ACCOUNT ||
//
//
//
//
//                        getIntFromPref(Config.ACCOUNT_VARIANT_ID) == Config.FREELANCE_FCY_ACCOUNT ||
//                        getIntFromPref(Config.ACCOUNT_VARIANT_ID) == Config.ALLIED_ISLAMIC_ASAAN_DIGITAL_ACCOUNT ||
//                        getIntFromPref(Config.ACCOUNT_VARIANT_ID) == Config.ALLIED_AITEBAR_ASAAN_DIGITAL_ACCOUNT ||
//                        getIntFromPref(Config.ACCOUNT_VARIANT_ID) == Config.FREELANCE_DIGITAL_ISLAMIC_ACCOUNT ||
//                        getIntFromPref(Config.ACCOUNT_VARIANT_ID) == Config.ALLIED_AITEBAR_FREELANCE_DIGITAL_ACCOUNT) {
//                    openActivity(ReviewDocumentActivity.class);
//                } else {
//                    openActivity(FatcaDetailsActivity.class);
//                }
//            } else {
//                openAdditionalApplicantActivity();
//            }
//        }
        
        
        
        
        
        
    }
    
    private func openAdditionalDetailsVC() {
//        guard let additionalDetailsVC = UIStoryboard.initialize(
//            viewController: .additionalApplicantDetailsVC,
//            fromStoryboard: .openAccount
//        ) as? AdditionalApplicantDetailsVC else { return }
        let additionalDetailsVC = UIStoryboard.initialize(
            viewController: .additionalApplicantDetailsVC,
            fromStoryboard: .openAccount
        ) as! AdditionalApplicantDetailsVC
        switch natureOfAccountLocal {
        case .single:
            break
        case .joint:
            self.navigationController?.pushViewController(additionalDetailsVC, animated: true)
        case .minor:
            break
        }
        
    }
    
    
    private func setupGestureRecognizers() {
        singleAccountView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: picAndSignViewModel,
                action: #selector(picAndSignViewModel.singleAccountTapped)
            )
        )
        
        jointAccountView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: picAndSignViewModel,
                action: #selector(picAndSignViewModel.jointAccountTapped)
            )
        )
        
        minorAccountView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: picAndSignViewModel,
                action: #selector(picAndSignViewModel.minorAccountTapped)
            )
        )
        
        additionalApplicantListView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: picAndSignViewModel,
                action: #selector(picAndSignViewModel.openDropdown)
            )
        )
    }
    
    private func setupDropdown() {
        dropDown.anchorView = additionalApplicantListView
        dropDown.direction = .top
        dropDown.dropDownHeight = 250
        dropDown.topOffset = CGPoint(
            x: 0,
            y: -(dropDown.anchorView?.plainView.bounds.height ?? 0)
        )
        dropDown.selectionAction = { [unowned self] index, item in
            logsManager.debug("Selected item \(item) at index \(index)")
            self.additionalApplicantLabel.text = item
            let noOfJointApplicants = item.components(separatedBy: " ").first
            modelRegistrationSteper.additionalApplicant = item
            modelRegistrationSteper.additionalApplicantNo = Int(noOfJointApplicants ?? "0") ?? 0
            self.picAndSignViewModel.setNoOfJointApplicants(applicants: Int(noOfJointApplicants ?? "0") ?? 0)
        }
    }
}


extension PictureAndSignatureVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        if picker == pictureImagePicker {
            livePhotoPreviewImageView.backgroundColor = .white
            livePhotoPreviewImageView.image = image
            
            modelRegistrationSteper.livePhotoPreviewImage = image
            livePictureData = image.jpegData(compressionQuality: 1)
            
            picAndSignViewModel.saveAttachment(
                attachmentTypeId: BaseConstants.AttachmentTypeIDs.livePhotoID,
                entityId: 443,
                fileName: "Live Photo",
                mimeType: "",
                path: "",
                base64Content: livePictureData?.base64EncodedString(),
                rdaCustomerAccInfoId: DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last?.accountInformation?.rdaCustomerAccInfoID)
        } else {
            signaturePreviewImageView.backgroundColor = .white
            signaturePreviewImageView.image = image
            modelRegistrationSteper.signaturePreviewImage = image
            signData = image.jpegData(compressionQuality: 1)
            picAndSignViewModel.saveAttachment(
                attachmentTypeId: BaseConstants.AttachmentTypeIDs.signatureTypeID,
                entityId: 443,
                fileName: "Signature",
                mimeType: "",
                path: "",
                base64Content: signData?.base64EncodedString(),
                rdaCustomerAccInfoId: DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last?.accountInformation?.rdaCustomerAccInfoID)
        }
    }
}
<<<<<<< HEAD

extension PictureAndSignatureVC: UIDocumentMenuDelegate, UIDocumentPickerDelegate {
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
        do {
            proofOfIncomeFileData = try Data(contentsOf: myURL)
            modelRegistrationSteper.proofOfIncomeFileData = proofOfIncomeFileData
            modelRegistrationSteper.proofOfIncomeFileName = myURL.lastPathComponent
            imageProofOfIncome.isHidden = false
            imageProofOfIncome.tag = 1
            viewProofOfIncomePicutre.isHidden = false
        } catch {
            print("Unable to load data: \(error)")
        }
    }
    
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
    }
}
=======
>>>>>>> e3b24a2 (Bug Fixing)
