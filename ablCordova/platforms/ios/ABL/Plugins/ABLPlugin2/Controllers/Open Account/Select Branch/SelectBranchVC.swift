//
//  SelectBranchVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 17/03/2022.
//

import UIKit

final class SelectBranchVC: UIViewController {
    
    private let selectBranchViewModel = SelectBranchViewModel()
    
    var bankingModeID: Double?
    var accountTypeID: Double?
    
    var isEditFromViewController = ""
    var isEditFromReviewDetailsViewController = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let bankingModeID = bankingModeID, let accountTypeID = accountTypeID {
            selectBranchViewModel.setBankingModeID(id: bankingModeID)
            selectBranchViewModel.setAccountTypeID(id: accountTypeID)
        }
        
        selectBranchViewModel.locationAuthorization()
        subscribeViewModel()
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
       openSelectPreferredAccountVC()
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    private func openSelectPreferredAccountVC() {
        guard let selectPreferredAccountVC = UIStoryboard.initialize(
            viewController: .selectPreferredAccountVC,
            fromStoryboard: .openAccount
        ) as? SelectPreferredAccountVC else { return }
        selectPreferredAccountVC.isEditFromViewController = "SelectBankingMethodVC"
        selectPreferredAccountVC.isEditFromReviewDetailsViewController = isEditFromReviewDetailsViewController
        navigationController?.pushViewController(selectPreferredAccountVC, animated: true)
    }
    
    private func subscribeViewModel() {
        selectBranchViewModel.userLocation.bind { [weak self]  location in
            guard let self = self, let location = location else { return }
            
            self.selectBranchViewModel.getBranches(
                branchName: "",
                categoryType: "C",
                latitude: "\(location.coordinate.latitude)",
                longitude: "\(location.coordinate.longitude)",
                distance: "40"
            )
        }
        
        selectBranchViewModel.locationDenied.bind {  isLocationDenied in
            guard isLocationDenied else { return }
            AlertManager.shared.showLocationAuthorizationAlert()
        }
        
        selectBranchViewModel.errorMessage.bind {  error in
            guard let error = error else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: error)
        }
        
        selectBranchViewModel.branches.bind { response in
            guard
                let allBranches = response?.branchList,
                let suggestedBranches = response?.suggestedBranchList
            else { return }
            
            logsManager.debug(allBranches)
            logsManager.debug(suggestedBranches)
        }
    }
}
