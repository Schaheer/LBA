//
//  CNICManualVerificationVC.swift
//  ABL
//
//  Created by Hamza Amin on 6/16/22.
//

import UIKit

final class CNICManualVerificationVC: UIViewController {
    
    // MARK: - Class Outlets
    
    @IBOutlet weak var cnicTextField: UITextField!
    @IBOutlet weak var expiryDateTextField: UITextField!

    
    private let cnicVerificationViewModel = CNICVerificationViewModel()
    private let selectBankingMethodViewModel = SelectBankingMethodViewModel()
    
    var mobileNumber: String?
//    var isPortedMobileNetwork: Bool?
//    lazy var jointAccountSecondaryApplicant = false
//
//    private var frontSideCNICData: Data?
//    private var backSideCNICData: Data?
    var cameFromJointFlow = false
    override func viewWillAppear(_ animated: Bool) {
        let consumer = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last
        
        print(consumer)
        print(DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList)
        print(DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.count)
        print(DataCacheManager.shared.loadNoOfJointApplicants())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeViewModel()
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {

        cnicVerificationViewModel.viewAppGenerateOTPWithoutAttachment(
            customerTypeID: BaseConstants.Config.customerTypeID,
            mobileNumber: mobileNumber,
            generateOTP: true,
            idNumber: cnicTextField.text,
            dateofExpiry: expiryDateTextField.text)
        
    }
    
    private func callRegisterVerifyOTP(){
        
        guard let viewAppGenerateResponseModel = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList else { return }
        
        var consumerListInputModelArray = [BasicInfoConsumerListInputModel]()
        consumerListInputModelArray = getListOfConsumers(newUserInfo: BasicInfoConsumerListInputModel()!)

        //TODO: add data of primary and all the secondary applicants in consumerList Array
        guard let registerVerifyOTPInput = RegisterVerifyOTPInputModel(
            consumerList: consumerListInputModelArray,
            noOfJointApplicants: 0,
            bioMetricVerificationNadraMobileReq: nil,
            channelId: BaseConstants.Config.channelID,
            customerTypeId: BaseConstants.Config.customerTypeID
        ) else { return }

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
    
    private func openPersonalInformationVC() {
        guard let personalInformationVC = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC else { return }
                
        navigationController?.pushViewController(personalInformationVC, animated: true)
    }

    
    private func subscribeViewModel() {
        cnicVerificationViewModel.openAccountUserData.bind { [weak self] response in
            guard let self = self, let response = response else { return }
            
            // These two functions are used together, the first appends the response and the second saves the array in user defaults.
            //            DataCacheManager.shared.appendViewAppGenerateOTPResponse(response: response)
            //            DataCacheManager.shared.saveViewAppGenerateOTPResponseArray()
            
            DataCacheManager.shared.saveViewAppGenerateOTPResponse(input: response)
            
            if !self.cameFromJointFlow {
                self.cnicVerificationViewModel.openVerifyOTPVC()
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
        return currentConsumerList
    }
    
    
    
}



//class CNICManualVerificationVC: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
