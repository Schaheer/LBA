//
//  UserAPIManager.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import Foundation
import Alamofire

final class APIManager: BaseHTTPClient {
    
    static let shared: APIManager = {
        return APIManager()
    }()
    
    // MARK: - APIEndPoints
    
    enum APIEndPoint: String {
        case requestBiometric = "public/bio-metric-verification"
        case verifyBiometricOTP = "verify-otp-bio-metric-verification"
        case biometricVerificationNadra = "bio-metric-verification-nadra"
        case viewAppsGenerateOTP = "public/view-apps-generate-otp"
        case saveKYC = "save-kyc"
        case getDraftedAppsVerifyOTP = "public/get-drafted-apps-verify-otp"
        case codeLookup = "public/lookup/code"
        case getBranches = "public/lookup/city/branch"
        case registerVerifyOTP = "register-verify-otp"
        case registerConsumerAccountInfo = "register-consumer-account-info"

        case consumerAccountDetail = "consumer-account-detail"
        case updateAccount = "public/update-account"
        case changeMobileNumber = "public/change-mobile-no"

        case registerConsumerBasicInfo = "register-consumer-basic-info"
        case registerConsumerAddress = "register-consumer-address"
        case saveAttachment = "save-attachment"
        case registerFatcaInfo = "register-consumer-fatca-info"

        case countryLookup = "public/lookup/country"
        case accountsLookup = "public/lookup/accounts"
    }
    
    // MARK: - Completion Typealiases
    
    typealias requestBiometricCompletion = (AFDataResponse<RequestBiometricResponseModel>) -> Void
    typealias verifyBiometricOTPCompletion = (AFDataResponse<VerifyBiometricOTPResponseModel>) -> Void
    typealias biometricVerificationNadraCompletion = (AFDataResponse<VerifyBiometricNadraResponseModel>) -> Void
    typealias viewAppsGenerateOTPCompletion = (AFDataResponse<ViewAppGenerateOTPResponseModel>) -> Void
    typealias saveKYCCaomletion = (AFDataResponse<SaveKYCResponseModel>) -> Void
    typealias getDraftedAppsVerifyOTPCompletion = (AFDataResponse<GetDraftedAppsVerifyOTPResponseModel>) -> Void
    typealias getMobileNetworksCompletion = (AFDataResponse<MobileNetworkResponseModel>) -> Void
    typealias getBranchesCompletion = (AFDataResponse<BranchResponseModel>) -> Void
    typealias registerVerifyOTPCompletion = (AFDataResponse<RegisterVerifyOTPResponseModel>) -> Void
    typealias registerConsumerAccountInfoCompletion = (AFDataResponse<RegisterConsumerAccountInfoResponseModel>) -> Void
    typealias purposeOfAccountListCompletion = (AFDataResponse<PurposeOfAccountResponseModel>) -> Void

    typealias consumerAccountDetailCompletion = (AFDataResponse<RegisterVerifyOTPResponseModel>) -> Void
    typealias updateAccountCompletion = (AFDataResponse<UpdateAccountResponseModel>) -> Void
    typealias changeMobileNumberCompletion = (AFDataResponse<ChangeNumberResponseModel>) -> Void

    typealias registerConsumerBasicInfoCompletion = (AFDataResponse<RegisterConsumerBasicInfoResponseModel>) -> Void
    typealias registerConsumerEmailCompletion = (AFDataResponse<RegisterConsumerEmailResponseModel>) -> Void
    typealias registerConsumerAddressCompletion = (AFDataResponse<RegisterConsumerAddressResponseModel>) -> Void
    typealias getOccupationsListCompletion = (AFDataResponse<OccupationsListResponseModel>) -> Void
    typealias registerConsumerEmploymentDetailsCompletion = (AFDataResponse<RegisterConsumerEmploymentDetailsResponseModel>) -> Void
    typealias setupConsumerTransactionDetailsCompletion = (AFDataResponse<ConsumerTransactionDetailsResponseModel>) -> Void
    typealias saveAttachmentCompletion = (AFDataResponse<SaveAttachmentResponseModel>) -> Void
    typealias registerPicAndSignCompletion = (AFDataResponse<RegisterPicAndSignResponseModel>) -> Void
    typealias registerFACTAInfoCompletion = (AFDataResponse<RegisterFACTAInfoResponseModel>) -> Void
    typealias taxNotAvailableCompletion = (AFDataResponse<CodeTypeResponseModel>) -> Void
    typealias additionalApplicantRelationshipsCompletion = (AFDataResponse<CodeTypeResponseModel>) -> Void
    typealias codeLookupCompletion = (AFDataResponse<CodeTypeResponseModel>) -> Void
    typealias countryLookupCompletion = (AFDataResponse<CountryLookupResponseModel>) -> Void
    typealias MailAddressPrefernceCompletion = (AFDataResponse<RegisterMailAddressResponseModel>) -> Void
    typealias RegisterNationalityResponseCompletion = (AFDataResponse<RegisterNationalityResponseModel>) -> Void
//    typealias countryLookupCompletion = (AFDataResponse<CountryLookupResponseModel>) -> Void

    
    // MARK: - Methods
    
    func requestBiometric(
        input: RequestBiometricInputModel,
        completion: @escaping requestBiometricCompletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.requestBiometric.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func verifyBiometricOTP(
        input: VerifyBiometricOTPInputModel,
        completion: @escaping verifyBiometricOTPCompletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.verifyBiometricOTP.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func verifyBiometricNadra(
        input: VerifyBiometricNadraInputModel,
        completion: @escaping biometricVerificationNadraCompletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.biometricVerificationNadra.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func viewAppsGenerateOTP(
        input: ViewAppGenerateOTPInputModel,
        completion: @escaping viewAppsGenerateOTPCompletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.viewAppsGenerateOTP.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func saveKYC(
        input: SaveKYCInputModel,
        completion: @escaping saveKYCCaomletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.saveKYC.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func getDraftedAppsVerifyOTP(
        input: GetDraftedAppsVerifyOTPInputModel,
        completion: @escaping getDraftedAppsVerifyOTPCompletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.getDraftedAppsVerifyOTP.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func getMobileNetworks(
        input: MobileNetworkInputModel,
        completion: @escaping getMobileNetworksCompletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.common.rawValue + APIEndPoint.codeLookup.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func getBranches(input: BranchInputModel, completion: @escaping getBranchesCompletion) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.common.rawValue + APIEndPoint.getBranches.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func registerVerifyOTP(
        input: RegisterVerifyOTPInputModel,
        completion: @escaping registerVerifyOTPCompletion
    ) {
        clearParameters()
        print(input.consumerList?.first!.rdaCustomerAccInfoId)
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.registerVerifyOTP.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func registerConsumerAccountInfo(
        input: RegisterConsumerAccountInfoInputModel,
        completion: @escaping registerConsumerAccountInfoCompletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.registerConsumerAccountInfo.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func getPurposeOfAccountList(
        input: PurposeOfAccountInputModel,
        completion: @escaping purposeOfAccountListCompletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.common.rawValue + APIEndPoint.codeLookup.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    

    func getConsumerAccountDetail(
        input: ConsumerAccountDetailInputModel,
        completion: @escaping consumerAccountDetailCompletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()

        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.consumerAccountDetail.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }

    func registerConsumerBasicInfo(
        input: RegisterConsumerBasicInfoInputModel,
        completion: @escaping registerConsumerBasicInfoCompletion

    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()

        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.registerConsumerBasicInfo.rawValue

        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    

    func updateAccount(
        input: UpdateAccountInputModel,
        completion: @escaping updateAccountCompletion
    ) {
        clearParameters()
        
        parameters  = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.updateAccount.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    func registerConsumerEmail(
        input: RegisterConsumerEmailInputModel,
        completion: @escaping registerConsumerEmailCompletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.registerConsumerBasicInfo.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func registerConsumerAddress(
        input: RegisterConsumerAddressInputModel,
        completion: @escaping registerConsumerAddressCompletion
    ) {
        clearParameters()
        
        parameters = input.params
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.registerConsumerAddress.rawValue

        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
        
//        parametersArrayJSON = [input].toJSON()
//        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.registerConsumerBasicInfo.rawValue
//
//        logsManager.debug("Array payload: \(parametersArrayJSON)")
//
//        executePostWithArrayJSONInput(
//            endPoint: endPoint,
//            ignoreBaseURL: false,
//            isDebugging: true,
//            showLoader: true,
//            completion: completion
//        )
    }
    
    func getOccupationsList(
        input: OccupationsListInputModel,
        completion: @escaping getOccupationsListCompletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.common.rawValue + APIEndPoint.codeLookup.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }

    func registerConsumerEmploymentDetails(
        input: RegisterConsumerEmploymentDetailsInputModel,
        completion: @escaping registerConsumerEmploymentDetailsCompletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.registerConsumerBasicInfo.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func setupConsumerTransactionDetails(
        input: SetupTransactionsInputModel,
        completion: @escaping setupConsumerTransactionDetailsCompletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.registerConsumerBasicInfo.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func saveAttachment(
        input: SaveAttachmentInputModel,
        completion: @escaping saveAttachmentCompletion
    ) {
        clearParameters()
//    http://10.100.102.124:8080/RdaConsumer/api/attachment/save-attachment
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.attachment.rawValue + APIEndPoint.saveAttachment.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    

    func changeMobileNumber(
        input: ChangeNumberInputModel,
        completion: @escaping changeMobileNumberCompletion
    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()

        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.changeMobileNumber.rawValue

        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    func savePicAndSign(
        input: RegisterPicAndSignInputModel,
        completion: @escaping registerPicAndSignCompletion

    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.registerConsumerBasicInfo.rawValue

        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func regiaterFACTAInfo(
        input: RegisterFACTAInfoInputModel,
        completion: @escaping registerFACTAInfoCompletion

    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.registerFatcaInfo.rawValue

        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }

    func registerMailAddressPreference(
        input: RegisterMailAddressInputModel,
        completion: @escaping MailAddressPrefernceCompletion

    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.registerConsumerAccountInfo.rawValue

        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }

    func registerConsumerNationality(
        input: RegisterNationalityInputModel,
        completion: @escaping RegisterNationalityResponseCompletion

    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.consumer.rawValue + APIEndPoint.registerConsumerBasicInfo.rawValue

        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
//    func taxNotAvailableReasons(
//        input: CodeTypeInputModel,
//        completion: @escaping taxNotAvailableCompletion

//    func taxNotAvailableReasons(
//        input: CodeTypeInputModel,
//        completion: @escaping taxNotAvailableCompletion
//    ) {
//        clearParameters()
//
//        parameters = input.dictionaryRepresentation()
//        let endPoint = BaseConstants.BaseURL.RDA.common.rawValue + APIEndPoint.codeLookup.rawValue
//
//        executePost(
//            endPoint: endPoint,
//            ignoreBaseURL: false,
//            isDebugging: true,
//            showLoader: true,
//            completion: completion
//        )
//    }
    
    func lookupInformation(
        input: CodeTypeInputModel,
        completion: @escaping codeLookupCompletion

    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.common.rawValue + APIEndPoint.codeLookup.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func getAllAccounte(
        input: GetAllAccountsInputModel,
        completion: @escaping codeLookupCompletion

    ) {
        clearParameters()
        
        parameters = input.dictionaryRepresentation()
        let endPoint = BaseConstants.BaseURL.RDA.common.rawValue + APIEndPoint.accountsLookup.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
    func countryLookup(completion: @escaping countryLookupCompletion) {
        clearParameters()
        
        let endPoint = BaseConstants.BaseURL.RDA.common.rawValue + APIEndPoint.countryLookup.rawValue
        
        executePost(
            endPoint: endPoint,
            ignoreBaseURL: false,
            isDebugging: true,
            showLoader: true,
            completion: completion
        )
    }
    
}



