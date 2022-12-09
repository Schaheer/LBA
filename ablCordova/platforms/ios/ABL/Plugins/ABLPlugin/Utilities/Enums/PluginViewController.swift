//
//  StoryboardID.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 02/03/2022.
//

import Foundation

enum PluginViewController: String {
    
    // MARK: - Biometric Verification Storyboard
    
    case getBiometricVerificationVC = "GetBiometricVerificationVC"
    case verifyOTPVC = "VerifyOTPVC"
    case biometricVerificationVC = "BiometricVerificationVC"
    case biometricVerificationSuccessVC = "BiometricVerificationSuccessVC"
    
    
    // MARK: - CNIC Upload Storyboard
    
    case cnicAvailabilityVC = "CNICAvailabilityVC"
    case cnicVerificationVC = "CNICVerificationVC"
    case simVerificationVC = "SimVerificationVC"
    case resumeApplicationVC = "ResumeApplicationVC"
    case portedPopupVC = "PortedPopupVC"
    case changeNumberVC = "ChangeNumberVC"
    case welcomeVC = "WelcomeVC"
    case CNICManualVerificationVC = "CNICManualVerificationVC"
    
    // MARK: - Open Account Storyboard
    
    case selectBankingMethodVC = "SelectBankingMethodVC"
    case selectBranchVC = "SelectBranchVC"
    case selectPreferredAccountVC = "SelectPreferredAccountVC"
    case personalInformationBaseVC = "PersonalInformationBaseVC"
    case personalInformationFirstVC = "PersonalInformationFirstVC"
    case personalInformationSecondVC = "PersonalInformationSecondVC"
    case personalInformationThirdVC = "PersonalInformationThirdVC"
    case occupationVC = "OccupationVC"
    case serviceChannelsVC = "ServiceChannelsVC"
    case pictureAndSignatureVC = "PictureAndSignatureVC"
    case selectAccountTypeVC = "SelectAccountTypeVC"
    case reviewDetailsVC = "ReviewDetailsVC"
    case confirmationVC = "ConfirmationVC"
    case additionalApplicantDetailsVC = "AdditionalApplicantDetailsVC"
    case fatcaDetailsVC = "FATCADetailsViewController"
    
    // MARK: RemittanceAccount Account Storyboard
    case taxResidentDetailVC = "TaxResidentDetailVC"
    case remitterDetailVC = "RemitterDetailVC"
    
    // MARK: Current Account Storyboard
    case nationalityVC = "NationalityVC"
    case transactionalAlertsVC = "TransactionalAlertsVC"
    case nextOfKinVC = "NextOfKinVC"
    case currentTaxResidentDetailVC = "CurrentTaxResidentDetailVC"
    case registerPermanentAddress = "RegisterPermanentAddressViewController"
    

    
//    case currentTaxResidentDetailVC = "CurrentTaxResidentDetailVC"

    
    
    
    var id: String {
        switch self {
        case .getBiometricVerificationVC:
            return PluginViewController.getBiometricVerificationVC.rawValue
        case .verifyOTPVC:
            return PluginViewController.verifyOTPVC.rawValue
        case .biometricVerificationVC:
            return PluginViewController.biometricVerificationVC.rawValue
        case .biometricVerificationSuccessVC:
            return PluginViewController.biometricVerificationSuccessVC.rawValue
        case .cnicAvailabilityVC:
            return PluginViewController.cnicAvailabilityVC.rawValue
        case .cnicVerificationVC:
            return PluginViewController.cnicVerificationVC.rawValue
        case .simVerificationVC:
            return PluginViewController.simVerificationVC.rawValue
        case .resumeApplicationVC:
            return PluginViewController.resumeApplicationVC.rawValue
        case .portedPopupVC:
            return PluginViewController.portedPopupVC.rawValue
        case .changeNumberVC:
            return PluginViewController.changeNumberVC.rawValue
        case .selectBankingMethodVC:
            return PluginViewController.selectBankingMethodVC.rawValue
        case .selectBranchVC:
            return PluginViewController.selectBranchVC.rawValue
        case .selectPreferredAccountVC:
            return PluginViewController.selectPreferredAccountVC.rawValue
        case .personalInformationBaseVC:
            return PluginViewController.personalInformationBaseVC.rawValue
        case .personalInformationFirstVC:
            return PluginViewController.personalInformationFirstVC.rawValue
        case .personalInformationSecondVC:
            return PluginViewController.personalInformationSecondVC.rawValue
        case .personalInformationThirdVC:
            return PluginViewController.personalInformationThirdVC.rawValue
        case .occupationVC:
            return PluginViewController.occupationVC.rawValue
        case .serviceChannelsVC:
            return PluginViewController.serviceChannelsVC.rawValue
        case .pictureAndSignatureVC:
            return PluginViewController.pictureAndSignatureVC.rawValue
        case .selectAccountTypeVC:
            return PluginViewController.selectAccountTypeVC.rawValue
        case .reviewDetailsVC:
            return PluginViewController.reviewDetailsVC.rawValue
        case .confirmationVC:
            return PluginViewController.confirmationVC.rawValue
        case .additionalApplicantDetailsVC:
            return PluginViewController.additionalApplicantDetailsVC.rawValue
        case .fatcaDetailsVC:
            return PluginViewController.fatcaDetailsVC.rawValue
        case .taxResidentDetailVC:
            return PluginViewController.taxResidentDetailVC.rawValue
        case .remitterDetailVC:
            return PluginViewController.remitterDetailVC.rawValue
        case .nationalityVC:
            return PluginViewController.nationalityVC.rawValue
        case .transactionalAlertsVC:
            return PluginViewController.transactionalAlertsVC.rawValue
        case .nextOfKinVC:
            return PluginViewController.nextOfKinVC.rawValue
        case .currentTaxResidentDetailVC:
            return PluginViewController.currentTaxResidentDetailVC.rawValue
        case .registerPermanentAddress:
            return PluginViewController.registerPermanentAddress.rawValue
        case .welcomeVC:
            return PluginViewController.welcomeVC.rawValue
        case .CNICManualVerificationVC:
            return PluginViewController.CNICManualVerificationVC.rawValue

        }
    }
}

