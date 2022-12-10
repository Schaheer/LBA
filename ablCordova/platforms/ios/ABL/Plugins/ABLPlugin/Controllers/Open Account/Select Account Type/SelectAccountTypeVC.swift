//
//  SelectAccountTypeVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 07/04/2022.
//

import UIKit
import DropDown

final class SelectAccountTypeVC: UIViewController {
    
    @IBOutlet weak var currentAccountView: CustomUIView!
    @IBOutlet weak var savingsAccountView: CustomUIView!
    
    @IBOutlet weak var purposeOfAccountView: CustomUIView!
    @IBOutlet weak var purposeOfAccountLabel: UILabel!
    
    var selectedBankingMode: BankingMethod?
    private var selectAccountTypeViewModel = SelectAccountTypeViewModel()
    private let dropDown = DropDown()
    
    var arrayPurposeOfAccountIds = [Int]()
    var isEditFromViewController = ""
    var isEditFromReviewDetailsViewController = false
    
    override func viewDidAppear(_ animated: Bool) {
        
        if modelRegistrationSteper.selectAccountTypeViewModel != nil {
            let tempViewModel = modelRegistrationSteper.selectAccountTypeViewModel!
            let purposeOfAccountId = tempViewModel.getPurposeOfAccountID()
            var indexOf = 0
            for (index, tempId) in self.arrayPurposeOfAccountIds.enumerated() {
                print(tempId)
                print(Int(purposeOfAccountId))
                print(indexOf)
                print("\(tempId)" == "\(Int(purposeOfAccountId))")
                if "\(tempId)" == "\(Int(purposeOfAccountId))" {
                    indexOf = index
                }
            }
            print(indexOf)
            let purposeOfAccount =  tempViewModel.getPurposeOfAccount(for: Int(indexOf))
            if purposeOfAccount != nil {
                self.purposeOfAccountLabel.text = purposeOfAccount?.description
                self.selectAccountTypeViewModel.setPurposeOfAccount(id: purposeOfAccount?.id ?? 0)
                self.purposeOfAccountLabel.text = purposeOfAccount?.description
            }
            let accountType = tempViewModel.getAccountType()
            let accountID = tempViewModel.getAccountTypeID()
            selectAccountTypeViewModel.accountType.value = accountType
            switch accountType {
            case .current:
                self.currentAccountView.borderColor = PluginColorAsset.alliedBlue.color
                self.savingsAccountView.borderColor = PluginColorAsset.otpFieldBorder.color
            case .savings:
                self.savingsAccountView.borderColor = PluginColorAsset.alliedBlue.color
                self.currentAccountView.borderColor = PluginColorAsset.otpFieldBorder.color
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        selectAccountTypeViewModel.getPurposeOfAccountList(codeTypeID: 1081)
        setupDropdown()
        subscribeViewModel()
        setupGestureRecognizers()
    }
    
    private func setupGestureRecognizers() {
        currentAccountView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: selectAccountTypeViewModel,
                action: #selector(selectAccountTypeViewModel.selectCurrentAccount)
            )
        )
        
        savingsAccountView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: selectAccountTypeViewModel,
                action: #selector(selectAccountTypeViewModel.selectSavingsAccount)
            )
        )
        
        purposeOfAccountView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: selectAccountTypeViewModel,
                action: #selector(selectAccountTypeViewModel.openDropdown)
            )
        )
    }
    
    private func openSelectPreferredAccountVC() {
        
        guard let selectPreferredAccountVC = UIStoryboard.initialize(
            viewController: .selectPreferredAccountVC,
            fromStoryboard: .openAccount
        ) as? SelectPreferredAccountVC else { return }
        selectPreferredAccountVC.selectedAccountTypeId = selectAccountTypeViewModel.getAccountTypeID()
        selectPreferredAccountVC.selectedBankingMode = selectedBankingMode
        modelRegistrationSteper.selectedBankingMode = selectedBankingMode
        selectPreferredAccountVC.isEditFromViewController = "SelectBankingMethodVC"
        selectPreferredAccountVC.isEditFromReviewDetailsViewController = isEditFromReviewDetailsViewController
        navigationController?.pushViewController(selectPreferredAccountVC, animated: true)
    }
    
    private func subscribeViewModel() {
        selectAccountTypeViewModel.accountType.bind { [weak self] accountType in
            guard let self = self, let accountType = accountType else { return }
            
            switch accountType {
            case .current:
                self.currentAccountView.borderColor = PluginColorAsset.alliedBlue.color
                self.savingsAccountView.borderColor = PluginColorAsset.otpFieldBorder.color
            case .savings:
                self.savingsAccountView.borderColor = PluginColorAsset.alliedBlue.color
                self.currentAccountView.borderColor = PluginColorAsset.otpFieldBorder.color
            }
        }
        
        selectAccountTypeViewModel.purposeOfAccountList.bind { [weak self] response in
            guard let self = self, let purposesOfAccount = response?.data else { return }
            self.dropDown.dataSource = purposesOfAccount.map { $0.description ?? "N/A"
            }
            self.arrayPurposeOfAccountIds = purposesOfAccount.map {
                Int($0.id ?? 0)
            }
        }
        
        selectAccountTypeViewModel.dropDownTapped.bind { [weak self] isTapped in
            guard let self = self, isTapped else { return }
            self.dropDown.show()
        }
        
        selectAccountTypeViewModel.registerConsumerAccountInfoResponse.bind { [weak self] response in
            guard let self = self, let response = response else { return }
            
            DataCacheManager.shared.saveRegisterConsumerAccountInfoResponse(input: response)
            modelRegistrationSteper.selectAccountTypeViewModel = self.selectAccountTypeViewModel
            modelRegistrationSteper.selectedBankingMode = self.selectedBankingMode
            self.selectAccountTypeViewModel.openSelectPreferredAccountVC()
        }
        
        selectAccountTypeViewModel.routeToSelectPreferredAccountVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openSelectPreferredAccountVC()
        }
    }
    
    private func setupDropdown() {
        dropDown.anchorView = purposeOfAccountView
        dropDown.direction = .bottom
        dropDown.width = purposeOfAccountView.bounds.width
//        dropDown..frame.size.height = 250
        dropDown.bottomOffset = CGPoint(
            x: 0,
            y: dropDown.anchorView?.plainView.bounds.height ?? 0
        )
        
        dropDown.selectionAction = { [unowned self] index, item in
            let purposeOfAccount = selectAccountTypeViewModel.getPurposeOfAccount(for: index)
            self.purposeOfAccountLabel.text = purposeOfAccount?.description
            self.selectAccountTypeViewModel.setPurposeOfAccount(id: purposeOfAccount?.id ?? 0)
        }
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
//        self.view.window?.rootViewController?.dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        let accountType = selectAccountTypeViewModel.getAccountTypeID()
        let purposeOfAccountID = selectAccountTypeViewModel.getPurposeOfAccountID()
        
        if accountType != 0 && purposeOfAccountID != 0 {
            guard
                let registerVerifyOTPResponse = DataCacheManager.shared.loadRegisterVerifyOTPResponse()
            else { return }
            
            let consumer = registerVerifyOTPResponse.consumerList?.first
            
            selectAccountTypeViewModel.registerConsumerAccountInfo(
                rdaCustomerAccInfoID: consumer?.accountInformation?.rdaCustomerAccInfoID,
                rdaCustomerID: consumer?.accountInformation?.rdaCustomerID,
                bankingModeID: consumer?.accountInformation?.bankingModeID,
                customerAccountTypeID: accountType,
                customerBranch: consumer?.accountInformation?.customerBranch,
                customerTypeID: BaseConstants.Config.customerTypeID,
                purposeOfAccountID: purposeOfAccountID
            )
        } else {
            AlertManager.shared.showOKAlert(with: "Error", message: "Please select account type and purpose of account.")
        }
    }
}
