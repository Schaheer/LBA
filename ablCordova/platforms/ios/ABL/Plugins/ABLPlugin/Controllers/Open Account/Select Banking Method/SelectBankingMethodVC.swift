//
//  SelectBankingMethodVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 17/03/2022.
//

import UIKit
import GoogleMaps
import DropDown
import CoreLocation
import FingerprintSDK

final class SelectBankingMethodVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var islamicBankingMethodView: CustomUIView!
    @IBOutlet weak var conventionalBankingMethodView: CustomUIView!
    @IBOutlet weak var currentAccountView: CustomUIView!
    @IBOutlet weak var savingsAccountView: CustomUIView!
    
    @IBOutlet weak var bankingMethodContainer: UIView!
    @IBOutlet weak var accountTypeContainer: UIView!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var allBranchesView: UIView!
    @IBOutlet weak var preferredBranchLabel: UILabel!
    
    @IBOutlet weak var suggestedBranchesContainer: CustomUIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var allBranchesContainer: CustomUIView!
    
    var fingerprintList : [Fingerprints]?
    private var selectBankingMethodViewModel = SelectBankingMethodViewModel()
    private let dropDown = DropDown()
    
    private var bounds = GMSCoordinateBounds()
    
    private var branchName = ""
    private var suggestedBranches = [BranchListModel]()
    var isEditFromReviewDetailsViewController = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        selectBankingMethodViewModel.locationAuthorization()
        
        
//        mapView.delegate = selectBankingMethodViewModel
        selectBankingMethodViewModel.locationAuthorization()
        
        subscribeViewModel()
        setupGestureRecognizers()
        setupDropdown()
    }
  
    override func viewWillAppear( _ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if modelRegistrationSteper.selectBankingMethodViewModel != nil {
            let tempViewModel = modelRegistrationSteper.selectBankingMethodViewModel!
            
            let branchName =  tempViewModel.getBranchName()
            selectBankingMethodViewModel.setBranch(name: branchName)
            if branchName != "" {
                self.preferredBranchLabel.text = branchName
            }
            selectBankingMethodViewModel.bankingMethod.value = tempViewModel.bankingMethod.value
            
            switch tempViewModel.bankingMethod.value {
            case .islamic:
                self.islamicBankingMethodView.borderColor = PluginColorAsset.alliedBlue.color
                self.conventionalBankingMethodView.borderColor = PluginColorAsset.otpFieldBorder.color
            case .conventional:
                self.conventionalBankingMethodView.borderColor = PluginColorAsset.alliedBlue.color
                self.islamicBankingMethodView.borderColor = PluginColorAsset.otpFieldBorder.color
            case .none:
                break
            }
            
            self.getBranches()
            
        }
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        let bankingModeID = selectBankingMethodViewModel.getBankingModeID()
        let branch = selectBankingMethodViewModel.getBranchName()
        
        if bankingModeID != 0 && !branch.isEmpty {
            guard let viewAppGenerateResponseModel = DataCacheManager.shared.loadViewAppGenerateOTPResponse() else { return }
            let viewAppGenerateOTPWithData = DataCacheManager.shared.loadViewAppGenerateOTPWithData()

            let attachments = viewAppGenerateOTPWithData?.attachments
            let cnicFrontAttachmentInput = [
                "fileName": "CNIC FRONT",
                "base64Content": attachments?.first?.base64Content ?? "",
                "attachmentTypeId": attachments?.first?.attachmentTypeID ?? 0
            ] as [String : Any]
            let cnicBackAttachmentInput = [
                "fileName": "CNIC BACK",
                "base64Content": attachments?.last?.base64Content ?? "",
                "attachmentTypeId": attachments?.last?.attachmentTypeID ?? 0
            ] as [String : Any]
            
            guard let basicInfoConsumerListInput = BasicInfoConsumerListInputModel(
                rdaCustomerAccInfoId: modelRegistrationSteper.rdaCustomerAccInfoId,
    //            rdaCustomerProfileId: currentUser.rdaCustomerProfileID as? Double,
                isPrimary: true,
//                isPrimaryRegistered: false,
                customerTypeId: BaseConstants.Config.customerTypeID,
                mobileNo: viewAppGenerateResponseModel.mobileNo ?? "",
                dateOfBirth: viewAppGenerateResponseModel.dateOfBirth ?? "",
                dateOfIssue: viewAppGenerateResponseModel.dateOfIssue ?? "",
                idNumber: viewAppGenerateResponseModel.idNumber ?? "",
                attachments: [cnicFrontAttachmentInput, cnicBackAttachmentInput],
                customerBranch: selectBankingMethodViewModel.getBranchName(),
                bankingModeId: selectBankingMethodViewModel.getBankingModeID()
            ) else { return }
            
            let fingerprintList =  self.fingerprintList
            guard let lat = self.selectBankingMethodViewModel.getUserLocation()?.coordinate.latitude, let long = self.selectBankingMethodViewModel.getUserLocation()?.coordinate.longitude else { return }
            guard let verifyBioMetricNadraInputData = VerifyBiometricNadraInputData(rdaCustomerProfileId: nil, rdaCustomerAccountInfoId: nil, cnic: viewAppGenerateResponseModel.idNumber ?? "", fingerprints: fingerprintList, templateType: "WSQ", contactNumber: "", areaName: "", accountType: "", latitude: lat, longitude: long, imei: "") else { return }

            var consumerListInputModelArray = [BasicInfoConsumerListInputModel]()
            consumerListInputModelArray = getListOfConsumers(newUserInfo: basicInfoConsumerListInput)
            guard
                let registerVerifyOTPInput = RegisterVerifyOTPInputModel(
                    consumerList: consumerListInputModelArray,
                    noOfJointApplicants: DataCacheManager.shared.loadNoOfJointApplicants() ?? 0,
                    bioMetricVerificationNadraMobileReq: verifyBioMetricNadraInputData,
                    channelId: BaseConstants.Config.channelID,
                    customerTypeId: BaseConstants.Config.customerTypeID
                )
            else { return }
            selectBankingMethodViewModel.registerVerifyOTP(input: registerVerifyOTPInput)
        } else {
            selectBankingMethodViewModel.setErrorMessage(
                text: "Please select a Banking Method and preferred branch"
            )
        }
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func openSelectBranchVC() {
        guard let selectBranchVC = UIStoryboard.initialize(
            viewController: .selectBranchVC,
            fromStoryboard: .openAccount
        ) as? SelectBranchVC else { return }
        
        selectBranchVC.bankingModeID = selectBankingMethodViewModel.getBankingModeID()
        selectBranchVC.accountTypeID = selectBankingMethodViewModel.getAccountTypeID()
        selectBranchVC.isEditFromViewController = "SelectBankingMethodVC"
        selectBranchVC.isEditFromReviewDetailsViewController = isEditFromReviewDetailsViewController
        
        navigationController?.pushViewController(selectBranchVC, animated: true)
    }
    
    private func openSelectAccountTypeVC() {
        guard let selectAccountTypeVC = UIStoryboard.initialize(
            viewController: .selectAccountTypeVC,
            fromStoryboard: .openAccount
        ) as? SelectAccountTypeVC else { return }
        selectAccountTypeVC.selectedBankingMode = selectBankingMethodViewModel.getBankingMode()
        selectAccountTypeVC.isEditFromViewController = "SelectBankingMethodVC"
        selectAccountTypeVC.isEditFromReviewDetailsViewController = isEditFromReviewDetailsViewController
        navigationController?.pushViewController(selectAccountTypeVC, animated: true)
    }
    
//    func openFingerPrintScanner() {
//
//        let customUI = CustomUI(
//            topBarBackgroundImage: nil,
//            topBarColor: PluginColorAsset.appCTABlue.color,
//            topBarTextColor: UIColor.white,
//            containerBackgroundColor: .green,
//            scannerOverlayColor: .green,
//            scannerOverlayTextColor: UIColor.white,
//            instructionTextColor: UIColor.white,
//            buttonsBackgroundColor: .orange,
//            buttonsTextColor: UIColor.black,
//            imagesColor: UIColor.white,
//            isFullWidthButtons: true,
//            guidanceScreenButtonText: "NEXT",
//            guidanceScreenText: "jhvj",
//            guidanceScreenAnimationFilePath: nil,
//            showGuidanceScreen: false)
//
//        let customDialog = CustomDialog(
//            dialogImageBackgroundColor: UIColor.white,
//            dialogImageForegroundColor: .green,
//            dialogBackgroundColor: UIColor.white,
//            dialogTitleColor: .systemBlue,
//            dialogMessageColor: UIColor.black,
//            dialogButtonTextColor: UIColor.white,
//            dialogButtonBackgroundColor: .orange)
//
//        let customFontFamily = CustomFontFamily(
//            customFontRegular: PluginFonts.latoRegular.rawValue,
//            customFontSemiBold: PluginFonts.latoBold.rawValue,
//            customFontBold: PluginFonts.latoBlack.rawValue)
//        let uiConfig = UIConfig(
//            splashScreenLoaderIndicatorColor: UIColor.white,
//            splashScreenText: "Please wait",
//            splashScreenTextColor: UIColor.white,
//            customUI: customUI,
//            customDialog: customDialog,
//            customFontFamily: customFontFamily)
//
//        let fingerprintConfig = FingerprintConfig(mode: .EXPORT_WSQ, fingers: .EIGHT_FINGERS, isPackPng: true, uiConfig: uiConfig)
//        let vc = FaceoffViewController.init(nibName: "FaceoffViewController", bundle: Bundle(for: FaceoffViewController.self))
//        vc.fingerprintConfig = fingerprintConfig
//        vc.fingerprintResponseDelegate = self
////        add(vc, to: self.view)
//        self.present(vc, animated: false, completion: nil)
//    }
    
    private func setupGestureRecognizers() {
        islamicBankingMethodView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: selectBankingMethodViewModel,
                action: #selector(selectBankingMethodViewModel.selectIslamicBankingMethod)
            )
        )
        
        conventionalBankingMethodView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: selectBankingMethodViewModel,
                action: #selector(selectBankingMethodViewModel.selectConventionalBankingMethod)
            )
        )
        
        currentAccountView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: selectBankingMethodViewModel,
                action: #selector(selectBankingMethodViewModel.selectCurrentAccount)
            )
        )
        
        savingsAccountView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: selectBankingMethodViewModel,
                action: #selector(selectBankingMethodViewModel.selectSavingsAccount)
            )
        )
        
        allBranchesView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: selectBankingMethodViewModel,
                action: #selector(selectBankingMethodViewModel.openDropdown)
            )
        )
    }
    
    private func setupDropdown() {
        dropDown.anchorView = allBranchesView
        dropDown.direction = .top
        dropDown.width = allBranchesView.bounds.width
        dropDown.frame.size.height = 250
        dropDown.topOffset = CGPoint(
            x: 0,
            y: -(dropDown.anchorView?.plainView.bounds.height ?? 0)
        )
        
        dropDown.selectionAction = { [unowned self] index, item in
            logsManager.debug("Selected item \(item) at index \(index)")
            self.preferredBranchLabel.text = item
            self.selectBankingMethodViewModel.setBranch(name: item)
        }
    }
    
    private func subscribeViewModel() {
        selectBankingMethodViewModel.bankingMethod.bind { [weak self] bankingMethod in
            guard let self = self, let bankingMethod = bankingMethod else { return }
            
            switch bankingMethod {
            case .islamic:
                self.islamicBankingMethodView.borderColor = PluginColorAsset.alliedBlue.color
                self.conventionalBankingMethodView.borderColor = PluginColorAsset.otpFieldBorder.color
            case .conventional:
                self.conventionalBankingMethodView.borderColor = PluginColorAsset.alliedBlue.color
                self.islamicBankingMethodView.borderColor = PluginColorAsset.otpFieldBorder.color
            }
            
            self.getBranches()
        }
        
        selectBankingMethodViewModel.accountType.bind { [weak self] accountType in
            guard let self = self, let accountType = accountType else { return }
            
            switch accountType {
            case .current:
                self.currentAccountView.borderColor = PluginColorAsset.appOrange.color
                self.savingsAccountView.borderColor = PluginColorAsset.otpFieldBorder.color
            case .savings:
                self.savingsAccountView.borderColor = PluginColorAsset.appOrange.color
                self.currentAccountView.borderColor = PluginColorAsset.otpFieldBorder.color
            }
        }
        
        selectBankingMethodViewModel.routeToSelectBranchVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }

            self.openSelectBranchVC()
        }
        
        selectBankingMethodViewModel.errorMessage.bind { error in
            guard let error = error else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: error)
        }
        
        selectBankingMethodViewModel.userLocation.bind { [weak self] location in
            guard let self = self, let location = location else { return }
            self.selectBankingMethodViewModel.setUserLocation(location: location)
        }
        
        selectBankingMethodViewModel.locationDenied.bind { isLocationDenied in
            guard isLocationDenied else { return }
            AlertManager.shared.showLocationAuthorizationAlert()
        }
        
        selectBankingMethodViewModel.branches.bind { [weak self] response in
            guard
                let self = self,
                let allBranches = response?.branchList,
                let suggestedBranches = response?.suggestedBranchList
            else { return }
            self.dropDown.dataSource = allBranches.map { "\($0.branchName ?? "N/A") (\($0.branchCode ?? ""))"}
            self.suggestedBranches = suggestedBranches
            
            self.suggestedBranchesContainer.isHidden = false
            self.allBranchesContainer.isHidden = false
            self.tableView.reloadData()
        }
        
        selectBankingMethodViewModel.dropDownTapped.bind { [weak self] isTapped in
            guard let self = self, isTapped else { return }
            self.dropDown.show()
        }
        
        selectBankingMethodViewModel.registerVerifyOTPResponse.bind { [weak self] response in
            guard let self = self, let response = response else { return }
            print(response.consumerList?.first?.rdaCustomerAccInfoId)
            if let rdaId = response.consumerList?.first?.rdaCustomerAccInfoId as? Int {
                modelRegistrationSteper.rdaCustomerAccInfoId = Double(rdaId)
            }
            
            DataCacheManager.shared.saveRegisterVerifyOTPResponse(input: response)
            DataCacheManager.shared.getViewAppGenerateOTPResponseArray()
            DataCacheManager.shared.setAuthHeaders(
                for: "Authorization",
                value: "Bearer \(response.consumerList?.first?.accessToken ?? "")"
            )
            self.selectBankingMethodViewModel.openSelectAccountTypeVC()
        }
        
        selectBankingMethodViewModel.routeToSelectAccountTypeVC.bind { [weak self]  shouldRoute in
            guard let self = self, shouldRoute else { return }
            modelRegistrationSteper.selectBankingMethodViewModel = self.selectBankingMethodViewModel
//
            self.openSelectAccountTypeVC()
        }
    }
    
    private func getBranches() {
        if let location = self.selectBankingMethodViewModel.getUserLocation() {

            let bankingMode = self.selectBankingMethodViewModel.getBankingMode()
            self.selectBankingMethodViewModel.getBranches(
                branchName: "",
                categoryType: bankingMode.categoryType,
                latitude: "\(location.coordinate.latitude)",
                longitude: "\(location.coordinate.longitude)",
                distance: ""
            )
        }
    }
    //MARK: - For merging
    func getListOfConsumers(newUserInfo: BasicInfoConsumerListInputModel) -> [BasicInfoConsumerListInputModel] {
        var tempRdaCustomerProfileID = newUserInfo.rdaCustomerProfileId
        var tempRdaCustomerAccInfoId = newUserInfo.rdaCustomerAccInfoId
        var currentConsumerList = [BasicInfoConsumerListInputModel]()
        let cousumerListHamza = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList
        if cousumerListHamza?.count ?? 0 > 0 {
            currentConsumerList = getCurrentConsumerListResponseInInputModel(responseCunsumerList: cousumerListHamza!)
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
        }
        else {
            currentConsumerList.append(newUserInfo)
        }
        
        return currentConsumerList
    }
}

extension SelectBankingMethodVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestedBranches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedBranchCell", for: indexPath) as? SuggestedBranchCell
        
        cell?.setupCell(with: suggestedBranches[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let branch = suggestedBranches[indexPath.row]
        selectBankingMethodViewModel.setBranch(name: branch.branchName ?? "")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

//extension SelectBankingMethodVC: FingerprintResponseDelegate {
//
//
//    func onScanComplete(fingerprintResponse: FingerprintResponse) {
//
//        if fingerprintResponse.response == Response.SUCCESS_WSQ_EXPORT{
//
//                self.fingerprintPngs = fingerprintResponse.pngList
//                var fingerprintsList = [Fingerprints]()
//                if let fpPNGs = self.fingerprintPngs{
//                    for item in fpPNGs{
//                        guard let index = item.fingerPositionCode, let imageString = item.binaryBase64ObjectPNG else { return }
//                        guard let instance = Fingerprints(index: "\(index)", template: imageString) else { return }
//                        fingerprintsList.append(instance)
//                    }
//                }
//
//                guard let userData = DataCacheManager.shared.loadUserDataFromCache(),
//                      let rdaCustomerProfileId = userData.entityID,
//                      let rdaCustomerAccountInfoId = userData.accountInfoID,
//                      let cnic = userData.username,
//                      let contactNumber = userData.mobileNumber,
//                      let areaName = userData.area,
//                      let accountType = userData.accountType,
//                      let data = VerifyBiometricNadraInputData(rdaCustomerProfileId: "\(rdaCustomerProfileId)", rdaCustomerAccountInfoId: "\(rdaCustomerAccountInfoId)", cnic: cnic, fingerprints: fingerprintsList, templateType: "WSQ", contactNumber: contactNumber, areaName: areaName, accountType: accountType) else { return }
//                self.viewModel.verifyBiometricNadra(data: data)
//
//
//        }else {
//
//            AlertManager.shared.showOKAlert(with: "Faceoff Results", message: fingerprintResponse.response.message)
//
//        }
//
//
//    }
//}
