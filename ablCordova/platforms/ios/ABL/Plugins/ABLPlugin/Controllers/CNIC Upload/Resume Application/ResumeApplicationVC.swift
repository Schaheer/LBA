//
//  ResumeApplicationVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 17/03/2022.
//

import UIKit

final class ResumeApplicationVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var detailCells = [GetDraftedAppsAppListModel]()
    var draftedAppsData: GetDraftedAppsVerifyOTPResponseModel?
    
    private let resumeApplicationViewModel = ResumeAaplicationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        detailCells = draftedAppsData?.appList ?? []
        tableView.reloadData()
        
        subscribeViewModel()
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        guard let selectedDraftedApp = resumeApplicationViewModel.getSelectedDraftedApp() else {
            AlertManager.shared.showOKAlert(with: "Error", message: "Please select a drafted app")
            return
        }
        
        resumeApplicationViewModel.getConsumerAccountDetail(
            rdaCustomerProfileID: selectedDraftedApp.rdaCustomerProfileID,
            rdaCustomerAccInfoID: selectedDraftedApp.rdaCustomerAccInfoID,
            customerTypeID: selectedDraftedApp.customerTypeID
        )
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
//        self.view.window?.rootViewController?.dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    private func openSelectBankingMethodVC() {
        guard let selectBankingMethodVC = UIStoryboard.initialize(
            viewController: .selectBankingMethodVC,
            fromStoryboard: .openAccount
        ) as? SelectBankingMethodVC else { return }
        
        navigationController?.pushViewController(selectBankingMethodVC, animated: true)
    }
    
    private func openSelectAccountTypeVC() {
        guard let selectAccountTypeVC = UIStoryboard.initialize(
            viewController: .selectAccountTypeVC,
            fromStoryboard: .openAccount
        ) as? SelectAccountTypeVC else { return }
        
        navigationController?.pushViewController(selectAccountTypeVC, animated: true)
    }
    
    private func openSelectPreferredAccountVC() {
        guard let selectPreferredAccountVC = UIStoryboard.initialize(
            viewController: .selectPreferredAccountVC,
            fromStoryboard: .openAccount
        ) as? SelectPreferredAccountVC else { return }
//        guard let selectedAccountTypeId = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last?.accountInformation?.accountTypeID else { return }
//        selectPreferredAccountVC.selectedAccountTypeId = selectedAccountTypeId
        navigationController?.pushViewController(selectPreferredAccountVC, animated: true)
    }
    
    private func openPersonalInformationVC() {
        guard let personalInformationVC = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC else { return }
        
        navigationController?.pushViewController(personalInformationVC, animated: true)
    }
    
    private func openOccupationVC() {
        guard let occupationVC = UIStoryboard.initialize(
            viewController: .occupationVC,
            fromStoryboard: .openAccount
        ) as? OccupationVC else { return }
        
        navigationController?.pushViewController(occupationVC, animated: true)
    }
    
    private func openServiceChannelsVC() {
        guard let serviceChannelsVC = UIStoryboard.initialize(
            viewController: .serviceChannelsVC,
            fromStoryboard: .openAccount
        ) as? ServiceChannelsVC else { return }
        
        navigationController?.pushViewController(serviceChannelsVC, animated: true)
    }
    
    private func openPictureAndSignatureVC() {
        guard let pictureAndSignatureVC = UIStoryboard.initialize(
            viewController: .pictureAndSignatureVC,
            fromStoryboard: .openAccount
        ) as? PictureAndSignatureVC else { return }
        
        navigationController?.pushViewController(pictureAndSignatureVC, animated: true)
    }
    
    private func subscribeViewModel() {
        resumeApplicationViewModel.routeToBankingMethodVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openSelectBankingMethodVC()
        }
        
        resumeApplicationViewModel.routeToAccountTypeVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openSelectAccountTypeVC()
        }
        
        resumeApplicationViewModel.routeToSelectPreferredAccountVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openSelectPreferredAccountVC()
        }
        
        resumeApplicationViewModel.routeToPersonalInformation.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openPersonalInformationVC()
        }
        
        resumeApplicationViewModel.routeToOccupationVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openOccupationVC()
        }
        
        resumeApplicationViewModel.routeToServiceChannelsVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openServiceChannelsVC()
        }
        
        resumeApplicationViewModel.routeToPictureAndSignatureVC.bind { [weak self]  shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openPictureAndSignatureVC()
        }
        
        resumeApplicationViewModel.consumerAccountDetail.bind { [weak self] response in
            guard let self = self, let response = response else { return }
            
            guard
                let draftedAppStepper = response.consumerList?.first?.stepperSections?.stepTo()
            else { return }
            
            DataCacheManager.shared.saveRegisterVerifyOTPResponse(input: response)
            switch draftedAppStepper {
            case .setupAccountBankingMode:
                self.resumeApplicationViewModel.openBankingMethodVC()
            case .setupAccountType:
                self.resumeApplicationViewModel.openAccountTypeVC()
            case .setupAccountIncome:
                self.resumeApplicationViewModel.openSelectPreferredAccountVC()
            case .personalDetailNames:
                self.resumeApplicationViewModel.openPersonalInformationVC()
            case .personalDetailAddress:
                self.resumeApplicationViewModel.openPersonalInformationVC()
            case .personalDetailEmployment:
                self.resumeApplicationViewModel.openOccupationVC()
            case .transactionalDetail:
                self.resumeApplicationViewModel.openServiceChannelsVC()
            case .documentUploader:
                self.resumeApplicationViewModel.openPictureAndSignatureVC()
            }
        }
        
        resumeApplicationViewModel.updateAccountResponse.bind { [weak self] response in
            guard let self = self, let response = response else { return }
            AlertManager.shared.showOKAlert(with: "Success", message: "Drafted app is deleted")
        }
    }
}

extension ResumeApplicationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailCells.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < detailCells.count {
            guard let detailCell = tableView.dequeueReusableCell(
                withIdentifier: "ResumeApplicationDetailCell",
                for: indexPath
            ) as? ResumeApplicationDetailCell else { return UITableViewCell() }
            
            detailCell.deleteApplication = { [weak self] in
                guard let self = self else { return }
                
                AlertManager.shared.showBasicChoiceAlert(
                    title: "Delete",
                    message: "Are you sure you want to delete this drafted app?"
                ) { _ in
                    let draftedApp = self.detailCells[indexPath.row]
                    self.resumeApplicationViewModel.updateAccount(
                        customerProfileID: draftedApp.rdaCustomerProfileID,
                        customerAccountInfoID: draftedApp.rdaCustomerAccInfoID
                    )
                }
            }
            
            detailCell.editApplication = {
                logsManager.debug("Edit application tapped")
            }
            detailCell.setupCell(with: detailCells[indexPath.row])
            return detailCell
        } else {
            guard let createNewAccountCell = tableView.dequeueReusableCell(
                withIdentifier: "ResumeApplicationCreateNewAccountCell",
                for: indexPath
            ) as? ResumeApplicationCreateNewAccountCell else { return UITableViewCell() }
            
            createNewAccountCell.createNewAccount = { [weak self] in
                guard let self = self else { return }
                self.resumeApplicationViewModel.openBankingMethodVC()
            }
            
            return createNewAccountCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < detailCells.count {
            let draftedApp = detailCells[indexPath.row]
            resumeApplicationViewModel.setSelectedDraftedApp(draftedApp: draftedApp)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < detailCells.count {
            return 230
        } else {
            return 65
        }
    }
}
