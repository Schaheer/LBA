//
//  AdditionalApplicantDetailsVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 22/04/2022.
//

import UIKit
import DropDown

final class AdditionalApplicantDetailsVC: UIViewController {
    
    @IBOutlet weak var selectRelationshipView: CustomUIView!
    @IBOutlet weak var relationshipLabel: UILabel!
    
    private let additionalApplicantDetailsViewModel = AdditionalApplicantDetailsViewModel()
    private let dropDown = DropDown()
    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeViewModel()
        setupDropdown()
        setupGestureRecognizers()
        
        additionalApplicantDetailsViewModel.getAdditionalApplicantRelationships(
            codeTypeID: BaseConstants.Config.additionalApplicantRelationshipsLookupID
        )
        
//        getConsumerAccountDetails()
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if let selectedRelationship = additionalApplicantDetailsViewModel.getSelectedRelationship() {
            DataCacheManager.shared.saveAdditionalApplicantRelationship(input: selectedRelationship)
            NotificationCenter.default.post(name: .additionalApplicant, object: nil)
            dismissToViewController(viewController: CNICAvailabilityVC.self)
//            navigationController?.popToRootViewController(animated: true)
        } else {
            AlertManager.shared.showOKAlert(with: "Error", message: "Please select a relationship")
        }
    }
    
    private func subscribeViewModel() {
        additionalApplicantDetailsViewModel.relationships.bind { [weak self] response in
            guard let self = self, let relationships = response?.data else { return }
            self.dropDown.dataSource = relationships.map { $0.name ?? "N/A" }
        }
        
        additionalApplicantDetailsViewModel.dropdownTapped.bind { [weak self] isTapped in
            guard let self = self, isTapped else { return }
            self.dropDown.show()
        }
        
        additionalApplicantDetailsViewModel.errorMessage.bind { errorMessage in
            guard let errorMessage = errorMessage else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: errorMessage)
        }
    }
    
    private func setupDropdown() {
        dropDown.anchorView = selectRelationshipView
        dropDown.direction = .bottom
        dropDown.frame.size.height = 250
        dropDown.bottomOffset = CGPoint(
            x: 0,
            y: dropDown.anchorView?.plainView.bounds.height ?? 0
        )
        
        dropDown.selectionAction = { [unowned self] index, item in
            logsManager.debug("Selected item \(item) at index \(index)")
            self.relationshipLabel.text = item
            
            let relationship = self.additionalApplicantDetailsViewModel.getRelationship(for: index)
            self.additionalApplicantDetailsViewModel.setSelectedRelationship(data: relationship)
        }
    }
    
    private func setupGestureRecognizers() {
        selectRelationshipView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: additionalApplicantDetailsViewModel,
                action: #selector(additionalApplicantDetailsViewModel.openDropdown)
            )
        )
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

extension UIViewController {
    func dismissToViewController<T>(viewController: T) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: viewController.self as! AnyClass) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    func showAlertSuccessWithPopToVC<T>(viewController: T ,title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//
//        }))
//        self.present(alert, animated: true, completion: nil)
//
        openCustomPopup(viewController: self, titleMessage: title, message: message)
    }
    
    func openCustomPopup(viewController: UIViewController, titleMessage: String, message: String) {
        let portedPopupVC = UIStoryboard.init(name: "CNICUpload", bundle: nil).instantiateViewController(withIdentifier: "CustomPopup") as! CustomPopup

        portedPopupVC.titleString = titleMessage.localizeString()
        portedPopupVC.message = message.localizeString()
        portedPopupVC.buttonTitle = "OK".localizeString()
        portedPopupVC.portedMobileNetwork = {

        }
        viewController.present(portedPopupVC, animated: true)
    }
    
    
    
   
}
