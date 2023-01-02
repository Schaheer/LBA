//
//  PictureAndSignatureVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/03/2022.
//

import UIKit
import BetterSegmentedControl
import DropDown
import MobileCoreServices
import UniformTypeIdentifiers

final class PictureAndSignatureVC: UIViewController, CustomPopupDemoVCDelegate {
    
    @IBOutlet weak var viewProofOfIncome: UIView!
    @IBOutlet weak var imageProofOfIncome: UIImageView!
    @IBOutlet weak var viewJointAccount: UIView!
    
    @IBOutlet weak var singleAccountView: UIView!
    @IBOutlet weak var singleAccountRadio: UIImageView!
    @IBOutlet weak var viewSelectNatureOfAccount: CustomUIView!
    @IBOutlet weak var segmentJointAccount: BetterSegmentedControl!
    
    @IBAction func buttonEye(_ sender: Any) {
        let message  = "In case of joint account, entier details of joint applicant along with documentation is required."
        openPortedPopupVC(viewController: self, message: message)
    }
    @IBAction func segmentJointAccount(_ sender: BetterSegmentedControl) {
        if DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList?.count ?? 0 > 0 {
        }
        else {
            DataCacheManager.shared.saveNoOfJointApplicants(input: 0)
        }
        
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
    @IBOutlet weak var jointAccountView: UIView!
    
    @IBOutlet weak var selectAdditionalApplicantView: UIView!
    @IBOutlet weak var additionalApplicantLabel: UILabel!
    
    @IBOutlet weak var jointAccountRadio: UIImageView!
    
    @IBOutlet weak var minorAccountView: UIView!
    @IBOutlet weak var minorAccountRadio: UIImageView!
    @IBOutlet weak var livePhotoPreviewImageView: UIImageView!
    @IBOutlet weak var signaturePreviewImageView: UIImageView!
    @IBOutlet weak var additionalApplicantListView: CustomUIView!
    @IBOutlet weak var viewProofOfIncomePicutre: UIView!
    
    
    private var picAndSignViewModel = PicAndSignViewModel()
    
    private var pictureImagePicker = UIImagePickerController()
    private var signImagePicker = UIImagePickerController()
    
    private var livePictureData: Data?
    private var signData: Data?
    private var proofOfIncomeFileData: Data?
    
    private var isJointFlow = false
    private var noOfJointApplicant: Int?
    private let dropDown = DropDown()
    
    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    var isEditFromReviewDetailsViewController = false
    var forViewController = ""
    var natureOfAccountLocal = NatureOfAccount.single
    override func viewDidAppear(_ animated: Bool) {
        viewDidAppearLocal()
        viewProofOfIncome.isHidden = true
        self.selectAdditionalApplicantView.isHidden = false
        
        if modelRegistrationSteper.proofOfIncomeInd == 1 {
            viewProofOfIncome.isHidden = false
        }
        if modelRegistrationSteper.isJointAccount {
            segmentJointAccount.setIndex(modelRegistrationSteper.isJointAccount ? 1 : 0)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList?.count ?? 0 > 0 {
            
            //            viewJointAccount.isHidden = true
            //            modelRegistrationSteper.isJointAccount = true
            //            natureOfAccountLocal = .joint
            //            picAndSignViewModel.jointAccountTapped()
            //            self.joint()
            //            picAndSignViewModel.setNoOfJointApplicants(applicants: DataCacheManager.shared.loadNoOfJointApplicants() ?? 0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageProofOfIncome.isHidden = true
        viewProofOfIncomePicutre.isHidden = true
        
        segmentJointAccount.segments = LabelSegment.segments(
            withTitles: ["No".localizeString(), "Yes".localizeString()],
            normalTextColor: .white,
            selectedTextColor: UIColor(
                red: 0.92,
                green: 0.29,
                blue: 0.15,
                alpha: 1.00
            )
        )
        viewSelectNatureOfAccount.isHidden = true
        
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
        viewProofOfIncome.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(uploadDocumentTapped(_:))
            )
        )
        subscribeViewModel()
        setupGestureRecognizers()
        let consumer = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last
        //        print(consumer)
        //        print(DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList)
        //        print(DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.count)
        
        if DataCacheManager.shared.loadNoOfJointApplicants() ?? 0 > 0 {
            isJointFlow = true
            viewJointAccount.isHidden = true
            natureOfAccountLocal = .joint
            modelRegistrationSteper.isJointAccount = true
            picAndSignViewModel.jointAccountTapped()
            self.joint()
            noOfJointApplicant = DataCacheManager.shared.loadNoOfJointApplicants() ?? 0
            print(noOfJointApplicant)
            picAndSignViewModel.setNoOfJointApplicants(applicants: DataCacheManager.shared.loadNoOfJointApplicants() ?? 0)
        }
        else {
            natureOfAccountLocal = .single
            picAndSignViewModel.singleAccountTapped()
            self.single()
        }
        getConsumerAccountDetails()
    }
    
    override func viewDidLayoutSubviews() {
        //        setupViews()
    }
    
    
    func continueToCamera() {
        pictureImagePicker = UIImagePickerController()
//        pictureImagePicker.sourceType = .camera
        pictureImagePicker.sourceType = .photoLibrary
        
        pictureImagePicker.allowsEditing = true
        pictureImagePicker.delegate = self
        present(pictureImagePicker, animated: true)
    }
    
    func viewDidAppearLocal() {
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
        if noOfJointApplicant ?? 0 > 0 {
            return false
        }
        else {
            if segmentJointAccount.index == 1 {
                if additionalApplicantLabel.text == "Select additional applicants".localizeString() {
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
        return true
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        if validationError() {
            return()
        }
        if isJointFlow  {
            jointFlow()
            return()
        }
        
        modelRegistrationSteper.isJointAccount = segmentJointAccount.index == 1 ? true : false
        if let natureOfAccount = picAndSignViewModel.getNatureOfAccount() {
            if natureOfAccount != .joint {
                singleFlow()
            } else {
                jointFlow()
            }
            
        } else {
            AlertManager.shared.showOKAlert(with: "Error", message: "Please select the nature of account")
        }
    }
    
    private func jointFlow() {
        isJointFlow = true
        let natureOfAccount = picAndSignViewModel.getNatureOfAccount()!
        let currentUser = getCurrentUser()
        
        logsManager.debug(natureOfAccount.rawValue, noOfJointApplicant as Any)
        picAndSignViewModel.saveNatureOfAccount(
            rdaCustomerProfileId: currentUser.rdaCustomerProfileID,
            rdaCustomerAccInfoId: currentUser.rdaCustomerAccInfoId as? Double,
            rdaCustomerId: currentUser.accountInformation?.rdaCustomerID,
            customerTypeId: BaseConstants.Config.customerTypeID,
            //                        customerTypeId: consumer.customerTypeID,
            natureOfAccountId: natureOfAccount.code,
            noOfJointApplicatns: Int(noOfJointApplicant ?? 0),
            nameOnPhysicalATM: String(getPrimaryUser().rdaCustomerProfileID!) // rdaCustomerProfileID of primary applicant
        )
        // move to
        modelRegistrationSteper.picAndSignViewModel = picAndSignViewModel
    }
    
    @IBAction func infoAccountPressed(_ sender: Any) {
        let message  = "In case of joint account entire details of joint applicant along with documentation is required.".localizeString()
        openPortedPopupVC(viewController: self, message: message)
    }
    
    
    func singleFlow() {
        isJointFlow = false
        let natureOfAccount = picAndSignViewModel.getNatureOfAccount()!
        var currentUser = getCurrentUser()
        logsManager.debug(natureOfAccount.rawValue)
        picAndSignViewModel.saveNatureOfAccount (
            rdaCustomerProfileId: currentUser.rdaCustomerProfileID,
            rdaCustomerAccInfoId: currentUser.accountInformation?.rdaCustomerAccInfoID,
            rdaCustomerId: currentUser.accountInformation?.rdaCustomerID,
            customerTypeId: BaseConstants.Config.customerTypeID,
            //                        customerTypeId: consumer.customerTypeID,
            natureOfAccountId: natureOfAccount.code,
            noOfJointApplicatns: 0,
            nameOnPhysicalATM: currentUser.fullName
        )
    }
    @objc private func takePictureTapped(_ sender: UIButton){
        
        guard let customPopupDemoVC = UIStoryboard.initialize(
            viewController: .CustomPopupDemoVC,
            fromStoryboard: .cnicUpload
        ) as? CustomPopupDemoVC else { return }
        
        customPopupDemoVC.delegate = self
        self.present(customPopupDemoVC, animated: true)
    }
    
    @objc private func uploadSignTapped(_ sender: UIButton){
        
        signImagePicker = UIImagePickerController()
        //        signImagePicker.sourceType = .camera
        pictureImagePicker.sourceType = .photoLibrary
        
        signImagePicker.allowsEditing = true
        signImagePicker.delegate = self
        present(signImagePicker, animated: true)
        
    }
    
    @objc private func uploadDocumentTapped(_ sender: UIButton){
        let docsTypes = ["public.text",
                         "com.apple.iwork.pages.pages",
                         "public.data",
                         "kUTTypeItem",
                         "kUTTypeContent",
                         "kUTTypeCompositeContent",
                         "kUTTypeData",
                         "public.database",
                         "public.calendar-event",
                         "public.message",
                         "public.presentation",
                         "public.contact",
                         "public.archive",
                         "public.disk-image",
                         "public.plain-text",
                         "public.utf8-plain-text",
                         "public.utf16-external-plain-​text",
                         "public.utf16-plain-text",
                         "com.apple.traditional-mac-​plain-text",
                         "public.rtf",
                         "com.apple.ink.inktext",
                         "public.html",
                         "public.xml",
                         "public.source-code",
                         "public.c-source",
                         "public.objective-c-source",
                         "public.c-plus-plus-source",
                         "public.objective-c-plus-​plus-source",
                         "public.c-header",
                         "public.c-plus-plus-header",
                         "com.sun.java-source",
                         "public.script",
                         "public.assembly-source",
                         "com.apple.rez-source",
                         "public.mig-source",
                         "com.apple.symbol-export",
                         "com.netscape.javascript-​source",
                         "public.shell-script",
                         "public.csh-script",
                         "public.perl-script",
                         "public.python-script",
                         "public.ruby-script",
                         "public.php-script",
                         "com.sun.java-web-start",
                         "com.apple.applescript.text",
                         "com.apple.applescript.​script",
                         "public.object-code",
                         "com.apple.mach-o-binary",
                         "com.apple.pef-binary",
                         "com.microsoft.windows-​executable",
                         "com.microsoft.windows-​dynamic-link-library",
                         "com.sun.java-class",
                         "com.sun.java-archive",
                         "com.apple.quartz-​composer-composition",
                         "org.gnu.gnu-tar-archive",
                         "public.tar-archive",
                         "org.gnu.gnu-zip-archive",
                         "org.gnu.gnu-zip-tar-archive",
                         "com.apple.binhex-archive",
                         "com.apple.macbinary-​archive",
                         "public.url",
                         "public.file-url",
                         "public.url-name",
                         "public.vcard",
                         "public.image",
                         "public.fax",
                         "public.jpeg",
                         "public.jpeg-2000",
                         "public.tiff",
                         "public.camera-raw-image",
                         "com.apple.pict",
                         "com.apple.macpaint-image",
                         "public.png",
                         "public.xbitmap-image",
                         "com.apple.quicktime-image",
                         "com.apple.icns",
                         "com.apple.txn.text-​multimedia-data",
                         "public.audiovisual-​content",
                         "public.movie",
                         "public.video",
                         "com.apple.quicktime-movie",
                         "public.avi",
                         "public.mpeg",
                         "public.mpeg-4",
                         "public.3gpp",
                         "public.3gpp2",
                         "public.audio",
                         "public.mp3",
                         "public.mpeg-4-audio",
                         "com.apple.protected-​mpeg-4-audio",
                         "public.ulaw-audio",
                         "public.aifc-audio",
                         "public.aiff-audio",
                         "com.apple.coreaudio-​format",
                         "public.directory",
                         "public.folder",
                         "public.volume",
                         "com.apple.package",
                         "com.apple.bundle",
                         "public.executable",
                         "com.apple.application",
                         "com.apple.application-​bundle",
                         "com.apple.application-file",
                         "com.apple.deprecated-​application-file",
                         "com.apple.plugin",
                         "com.apple.metadata-​importer",
                         "com.apple.dashboard-​widget",
                         "public.cpio-archive",
                         "com.pkware.zip-archive",
                         "com.apple.webarchive",
                         "com.apple.framework",
                         "com.apple.rtfd",
                         "com.apple.flat-rtfd",
                         "com.apple.resolvable",
                         "public.symlink",
                         "com.apple.mount-point",
                         "com.apple.alias-record",
                         "com.apple.alias-file",
                         "public.font",
                         "public.truetype-font",
                         "com.adobe.postscript-font",
                         "com.apple.truetype-​datafork-suitcase-font",
                         "public.opentype-font",
                         "public.truetype-ttf-font",
                         "public.truetype-collection-​font",
                         "com.apple.font-suitcase",
                         "com.adobe.postscript-lwfn​-font",
                         "com.adobe.postscript-pfb-​font",
                         "com.adobe.postscript.pfa-​font",
                         "com.apple.colorsync-profile",
                         "public.filename-extension",
                         "public.mime-type",
                         "com.apple.ostype",
                         "com.apple.nspboard-type",
                         "com.adobe.pdf",
                         "com.adobe.postscript",
                         "com.adobe.encapsulated-​postscript",
                         "com.adobe.photoshop-​image",
                         "com.adobe.illustrator.ai-​image",
                         "com.compuserve.gif",
                         "com.microsoft.bmp",
                         "com.microsoft.ico",
                         "com.microsoft.word.doc",
                         "com.microsoft.excel.xls",
                         "com.microsoft.powerpoint.​ppt",
                         "com.microsoft.waveform-​audio",
                         "com.microsoft.advanced-​systems-format",
                         "com.microsoft.windows-​media-wm",
                         "com.microsoft.windows-​media-wmv",
                         "com.microsoft.windows-​media-wmp",
                         "com.microsoft.windows-​media-wma",
                         "com.microsoft.advanced-​stream-redirector",
                         "com.microsoft.windows-​media-wmx",
                         "com.microsoft.windows-​media-wvx",
                         "com.microsoft.windows-​media-wax",
                         "com.apple.keynote.key",
                         "com.apple.keynote.kth",
                         "com.truevision.tga-image",
                         "com.sgi.sgi-image",
                         "com.ilm.openexr-image",
                         "com.kodak.flashpix.image",
                         "com.j2.jfx-fax",
                         "com.js.efx-fax",
                         "com.digidesign.sd2-audio",
                         "com.real.realmedia",
                         "com.real.realaudio",
                         "com.real.smil",
                         "com.allume.stuffit-archive",
                         "org.openxmlformats.wordprocessingml.document",
                         "com.microsoft.powerpoint.​ppt",
                         "org.openxmlformats.presentationml.presentation",
                         "com.microsoft.excel.xls",
                         "org.openxmlformats.spreadsheetml.sheet",
                         
                         
        ]
        let documentPicker = UIDocumentPickerViewController(documentTypes: docsTypes, in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    private func subscribeViewModel() {
        
        picAndSignViewModel.saveAttachmentResponse.bind { [weak self]  response  in
            guard let status = response?.message?.status, let description = response?.message?.description?.lowercased() else { return }
            if status == "200" && description.lowercased() == "success"{
                self?.showAlertSuccessWithPopToVC(viewController: self, title: "Success", message: "Document uploaded successfully")
            }
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
            //            self.dropDown.show()
            self.openAdditionalApplicants()
        }
    }
    
    func openAdditionalApplicants() {
        let dataSource = self.dropDown.dataSource
        self.showSelectionAlert(with: dataSource, title: "Select Delivery", isSearchViewHidden: true) { index, item in
            logsManager.debug("Selected item \(item) at index \(index)")
            self.additionalApplicantLabel.text = item
            let noOfJointApplicants = item.components(separatedBy: " ").first
            modelRegistrationSteper.additionalApplicant = item
            modelRegistrationSteper.additionalApplicantNo = Int(noOfJointApplicants ?? "0") ?? 0
            self.picAndSignViewModel.setNoOfJointApplicants(applicants: Int(noOfJointApplicants ?? "0") ?? 0)
            DataCacheManager.shared.saveNoOfJointApplicants(input: Int(noOfJointApplicants ?? "0") ?? 0)
            self.noOfJointApplicant = Int(noOfJointApplicants ?? "0") ?? 0
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
        //        DataCacheManager.shared.saveNoOfJointApplicants(input: 0)
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
        if isEditFromReviewDetailsViewController && forViewController == "ReviewDetailsVC" {
            navigationController?.popViewController(animated: true)
            return()
        }
        modelRegistrationSteper.picAndSignViewModel = picAndSignViewModel
        
        let personalInformationBaseVC = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC
        
        //        edit ka case is me handle karna ha in sy pehlay
        let accountVariantID = modelRegistrationSteper.selectPreferredAccountViewModel?.getAccountVariantID()
        if isJointFlow {
            let consumer = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList
            
            var consumerCount = consumer?.count
            var consumerCount2 = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList?.count
            
            print(consumer?.count)
            print(noOfJointApplicant)
            print(consumerCount)
            print(consumerCount2 ?? 0)
            
            if consumerCount ?? 0 >= noOfJointApplicant ?? 0 {
                print("====================1")
                self.delegate?.addChild(vc: .fatcaDetailsVC, fromViewController: "isJointFlow")
            }
            else {
                print("====================2")
                openAdditionalDetailsVC()
            }
        }
        else {
            var results = [Int]()
            for i in (108243 ..< 108255) {
                results.append(i)
            }
            if (results.first{$0  == Int(accountVariantID?.rawValue ?? 0)} != nil) {
                guard let reviewDetailsVC = UIStoryboard.initialize(
                    viewController: .reviewDetailsVC,
                    fromStoryboard: .openAccount
                ) as? ReviewDetailsVC else { return }
                
                navigationController?.pushViewController(reviewDetailsVC, animated: true)
            }
            else {
                if DataCacheManager.shared.loadNoOfJointApplicants() ?? 0 > 0 {
                    
                }
                else {
                    self.delegate?.addChild(vc: .fatcaDetailsVC, fromViewController: "")
                }
            }
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
        if isEditFromReviewDetailsViewController && forViewController == "ReviewDetailsVC" {
            navigationController?.popViewController(animated: true)
            
            return()
        }
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
        dropDown.frame.size.height = 250
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
            DataCacheManager.shared.saveNoOfJointApplicants(input: Int(noOfJointApplicants ?? "0") ?? 0)
            noOfJointApplicant = Int(noOfJointApplicants ?? "0") ?? 0
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
    
    private func getConsumerAccountDetails() {
        guard
            let consumerAccountDetails = DataCacheManager.shared.loadRegisterVerifyOTPResponse()
        else { return }
        
        let consumer = consumerAccountDetails.consumerList?.first
        getConsumerAccountDetail(
            rdaCustomerProfileID: consumer?.rdaCustomerProfileID,
            rdaCustomerAccInfoID: consumer?.accountInformation?.rdaCustomerAccInfoID,
            customerTypeID: BaseConstants.Config.customerTypeID
        )
    }
    
    private func getConsumerAccountDetail(
        rdaCustomerProfileID: Double?,
        rdaCustomerAccInfoID: Double?,
        customerTypeID: Double?
    ) {
        guard
            let rdaCustomerProfileID = rdaCustomerProfileID,
            let rdaCustomerAccInfoID = rdaCustomerAccInfoID,
            let customerTypeID = customerTypeID
        else {
            print("All fields required")
            return }
        
        guard let input = ConsumerAccountDetailInputModel(
            rdaCustomerProfileID: rdaCustomerProfileID,
            rdaCustomerAccInfoID: rdaCustomerAccInfoID,
            customerTypeID: customerTypeID
        ) else { return }
        
        APIManager.shared.getConsumerAccountDetail(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                var registerVerifyOTPResponseModel: RegisterVerifyOTPResponseModel = value
                print(registerVerifyOTPResponseModel)
                DataCacheManager.shared.saveRegisterVerifyOTPResponse(input: registerVerifyOTPResponseModel)
                DataCacheManager.shared.saveRegisterVerifyOTPResponseModel(registerVerifyOTPResponseModel: registerVerifyOTPResponseModel)
                print(DataCacheManager.shared.getRegisterVerifyOTPResponseModel())
                print(DataCacheManager.shared.getRegisterVerifyOTPResponseModel())
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
}

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
    
    func openPortedPopupVC(viewController: UIViewController, message: String) {
        guard let portedPopupVC = UIStoryboard.initialize(
            viewController: .portedPopupVC,
            fromStoryboard: .cnicUpload
        ) as? PortedPopupVC else { return }
        
        portedPopupVC.message = message
        portedPopupVC.buttonTitle = "OK".localizeString()
        portedPopupVC.portedMobileNetwork = {
            
        }
        viewController.present(portedPopupVC, animated: true)
    }
}


