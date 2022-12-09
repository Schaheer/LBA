//
//  TransactionalAlertsVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/05/2022.
//

import UIKit
import BetterSegmentedControl

final class TransactionalAlertsVC: UIViewController {
    
    @IBOutlet weak var electronicSOASegment: BetterSegmentedControl!
    @IBOutlet weak var transactionalAlertSegment: BetterSegmentedControl!
    @IBOutlet weak var smsButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    private let transactionalAlertsViewModel = TransactionalAlertsViewModel()
    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegments()
        subscribeViewModel()
    }
    
    @IBAction func electronicSOATapped(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            transactionalAlertsViewModel.setESOA(eSOA: 0)
        } else {
            transactionalAlertsViewModel.setESOA(eSOA: 1)
        }
    }
    
    @IBAction func transactionalAlertTapped(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            transactionalAlertsViewModel.setTransactionalAlerts(transactionalAlerts: 0)
        } else {
            transactionalAlertsViewModel.setTransactionalAlerts(transactionalAlerts: 1)
        }
    }
    
    @IBAction func smsButtonTapped(_ sender: UIButton) {
        smsButton.backgroundColor = PluginColorAsset.alliedBlue.color
        smsButton.tintColor = .white
        smsButton.borderColor = .clear
        smsButton.borderWidth = 0
        
        emailButton.backgroundColor = .clear
        emailButton.tintColor = PluginColorAsset.appCTABlue.color
        emailButton.borderColor = PluginColorAsset.appCTABlue.color
        emailButton.borderWidth = 1
        
        transactionalAlertsViewModel.setTransactionalAlertID(
            id: BaseConstants.Config.smsTransactionalAlertID
        )
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        emailButton.backgroundColor = PluginColorAsset.alliedBlue.color
        emailButton.tintColor = .white
        emailButton.borderColor = .clear
        emailButton.borderWidth = 0
        
        smsButton.backgroundColor = .clear
        smsButton.tintColor = PluginColorAsset.appCTABlue.color
        smsButton.borderColor = PluginColorAsset.appCTABlue.color
        smsButton.borderWidth = 1
        
        transactionalAlertsViewModel.setTransactionalAlertID(
            id: BaseConstants.Config.emailTransactionalAlertID
        )
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let eSOA = transactionalAlertsViewModel.getESOA()
        let transactionalAlerts = transactionalAlertsViewModel.getTransactionalAlerts()
        let transactionalAlertID = transactionalAlertsViewModel.getTransactionalAlertID()
        
        guard
            let registerConsumerAccountInfoResponse = DataCacheManager.shared.loadRegisterConsumerAccountInfoResponse()
        else { return }
        
        transactionalAlertsViewModel.registerConsumerAccountInfo(
            rdaCustomerAccountInfoID: registerConsumerAccountInfoResponse.data?.rdaCustomerAccInfoID,
            rdaCustomerID: registerConsumerAccountInfoResponse.data?.rdaCustomerID,
            customerTypeID: registerConsumerAccountInfoResponse.data?.customerTypeID,
            eSOAInd: eSOA,
            transAlertInd: transactionalAlerts,
            transactionalAlertID: transactionalAlertID,
            genderId: modelRegistrationSteper.genderId
        )
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        if let count = self.parent?.children.count {
            if count > 1 {
                self.delegate?.removeChild()
                self.parent?.children.last?.remove()
            } else {
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func setupSegments() {
        electronicSOASegment.segments = LabelSegment.segments(
            withTitles: ["No", "Yes"],
            normalTextColor: .white,
            selectedTextColor: UIColor(
                red: 0.92,
                green: 0.29,
                blue: 0.15,
                alpha: 1.00
            )
        )
        
        transactionalAlertSegment.segments = LabelSegment.segments(
            withTitles: ["Not Required", "Required"],
            normalTextColor: .white,
            selectedTextColor: UIColor(
                red: 0.92,
                green: 0.29,
                blue: 0.15,
                alpha: 1.00
            )
        )
    }
    
    private func subscribeViewModel() {
        transactionalAlertsViewModel.registerConsumerAccountInfoResponse.bind { [weak self] response in
            guard let self = self, let response = response else { return }
            guard
                let status = response.message?.status,
                let description = response.message?.description?.lowercased()
            else { return }
            
            if status == "200" && description == "success" {
                DataCacheManager.shared.saveRegisterConsumerAccountInfoResponse(input: response)
                self.delegate?.addChild(vc: .nextOfKinVC, fromViewController: "")
            }
        }
        
        transactionalAlertsViewModel.errorMessage.bind { error in
            guard let error = error else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: error)
        }
    }
}
