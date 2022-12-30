//
//  OpenAccountTwoViewController.swift
//  ABL
//
//  Created by Hamza Amin on 3/4/22.
//

import UIKit
import FingerprintSDK

class BiometricVerificationVC: UIViewController {

    
    let viewModel = BiometricVerificationViewModel()
    var fingerprintPngs : [Png]?
    var otpVerifyMode: OTPVerifyMode = .biometricVerification
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func doneTapped(_ sender: UIButton) {

        openFingerPrintScanner()
    }

    @IBAction func cancelTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func openFingerPrintScanner() {
        
        let customUI = CustomUI(
            topBarBackgroundImage: nil,
            topBarColor: PluginColorAsset.appCTABlue.color,
            topBarTextColor: UIColor.white,
            containerBackgroundColor: .green,
            scannerOverlayColor: .green,
            scannerOverlayTextColor: UIColor.white,
            instructionTextColor: UIColor.white,
            buttonsBackgroundColor: .orange,
            buttonsTextColor: UIColor.black,
            imagesColor: UIColor.white,
            isFullWidthButtons: true,
            guidanceScreenButtonText: "NEXT",
            guidanceScreenText: "jhvj",
            guidanceScreenAnimationFilePath: nil,
            showGuidanceScreen: false)

        let customDialog = CustomDialog(
            dialogImageBackgroundColor: UIColor.white,
            dialogImageForegroundColor: .green,
            dialogBackgroundColor: UIColor.white,
            dialogTitleColor: .systemBlue,
            dialogMessageColor: UIColor.black,
            dialogButtonTextColor: UIColor.white,
            dialogButtonBackgroundColor: .orange)

        let customFontFamily = CustomFontFamily(
            customFontRegular: PluginFonts.latoRegular.rawValue,
            customFontSemiBold: PluginFonts.latoBold.rawValue,
            customFontBold: PluginFonts.latoBlack.rawValue)
        let uiConfig = UIConfig(
            splashScreenLoaderIndicatorColor: UIColor.white,
            splashScreenText: "Please wait",
            splashScreenTextColor: UIColor.white,
            customUI: customUI,
            customDialog: customDialog,
            customFontFamily: customFontFamily)
        
        let fingerprintConfig = FingerprintConfig(mode: .EXPORT_WSQ, fingers: .EIGHT_FINGERS, isPackPng: true, uiConfig: uiConfig)
        let vc = FaceoffViewController.init(nibName: "FaceoffViewController", bundle: Bundle(for: FaceoffViewController.self))
        vc.fingerprintConfig = fingerprintConfig
        vc.fingerprintResponseDelegate = self
//        add(vc, to: self.view)
        self.present(vc, animated: false, completion: nil)
    }
    
    private func callBioMetricVerificationAPI(with fingerprintList: [Fingerprints]){
        
        guard let userData = DataCacheManager.shared.loadUserData(),
              let rdaCustomerProfileId: Double = userData.entityID,
              let rdaCustomerAccountInfoId: Double = userData.accountInfoID,
              let cnic = userData.username,
              let contactNumber = userData.mobileNumber,
              let areaName = userData.area,
              let accountType = userData.accountType,
              let data = VerifyBiometricNadraInputData(rdaCustomerProfileId: rdaCustomerProfileId, rdaCustomerAccountInfoId: rdaCustomerAccountInfoId, cnic: cnic, fingerprints: fingerprintList, templateType: "WSQ", contactNumber: contactNumber, areaName: areaName, accountType: accountType, latitude: nil, longitude: nil, imei: nil) else { return }
//                (rdaCustomerProfileId: "\(rdaCustomerProfileId)", rdaCustomerAccountInfoId: "\(rdaCustomerAccountInfoId)", cnic: cnic, fingerprints: fingerprintList, templateType: "WSQ", contactNumber: contactNumber, areaName: areaName, accountType: accountType)
        self.viewModel.verifyBiometricNadra(data: data)
    }
    
    private func openSelectBankingMethodVC(with fingerprintList: [Fingerprints]) {
        guard let selectBankingMethodVC = UIStoryboard.initialize(
            viewController: .selectBankingMethodVC,
            fromStoryboard: .openAccount
        ) as? SelectBankingMethodVC else { return }
        selectBankingMethodVC.fingerprintList = fingerprintList
        navigationController?.pushViewController(selectBankingMethodVC, animated: true)
    }
}

extension BiometricVerificationVC: BiometricVerificationDelegate{
    
    func biometricVerificationError(error: String) {
        print(error, "error")
        AlertManager.shared.showOKAlert(with: "Error", message: error)
    }
    
    func biometricVerificationDone(response: VerifyBiometricNadraResponseModel) {

        if let message = response.data?.responseMsg, let code = response.data?.responseCode{
            
            if code == 100{
                guard let secondVC = UIStoryboard.initialize(viewController: .biometricVerificationSuccessVC, fromStoryboard: .biometricVerification) as? BiometricVerificationSuccessVC else { return }
                navigationController?.pushViewController(secondVC, animated: true)
            }else {
                AlertManager.shared.showOKAlert(with: "Error", message: message)
            }
        }
    }
}

extension BiometricVerificationVC: FingerprintResponseDelegate {
    
    
    func onScanComplete(fingerprintResponse: FingerprintResponse) {
//Shakeel ! added
        if fingerprintResponse.response == Response.SUCCESS_WSQ_EXPORT{
            
            self.fingerprintPngs = fingerprintResponse.pngList
            var fingerprintsList = [Fingerprints]()
            if let fpPNGs = self.fingerprintPngs{
                for item in fpPNGs{
                    guard let imageString = item.binaryBase64ObjectPNG else { return }
                    guard let instance = Fingerprints(index: "\(item.fingerPositionCode)", template: imageString) else { return }
                    fingerprintsList.append(instance)
                }
            }
            switch otpVerifyMode{
            case .biometricVerification:
                callBioMetricVerificationAPI(with: fingerprintsList)
            case .cnicUpload:
                openSelectBankingMethodVC(with: fingerprintsList)
            }
            
            
        }else {
            
            AlertManager.shared.showOKAlert(with: "Faceoff Results", message: fingerprintResponse.response.message)
            
        }

        
    }
}

