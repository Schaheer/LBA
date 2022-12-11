//
//  RemitterDetailVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 27/04/2022.
//

import UIKit

final class RemitterDetailVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var fromViewController = ""
    private var remitters = [
        RemitterTextModel(nameOfRemitter: "", relationship: "")
    ]
    
    private let remitterDetailViewModel = RemitterDetailViewModel()
    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        subscribeViewModel()
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        
        if let data = DataCacheManager.shared.loadRegisterConsumerAccountInfoResponse()?.data {
            
            var pdaRemitters = [PDARemitterDetailInputModel]()
            remitters.forEach { remitter in
                guard let pdaInput = PDARemitterDetailInputModel(
                    pdaRemitterDetailID: 0,
                    accountID: data.rdaCustomerAccInfoID ?? 0,
                    remitterName: remitter.nameOfRemitter,
                    relationshipWithRemitter: remitter.relationship
                ) else { return }
                
                pdaRemitters.append(pdaInput)
            }
            
            remitterDetailViewModel.registerConsumerAccountInfo(
                rdaCustomerAccInfoID: data.rdaCustomerAccInfoID,
                rdaCustomerID: data.rdaCustomerID,
                bankingModeID: data.bankingModeID,
                customerAccountTypeID: data.customerAccountTypeID,
                customerBranch: data.customerBranch,
                customerTypeID: BaseConstants.Config.customerTypeID,
//                customerTypeID: data.customerTypeID,
                purposeOfAccountID: data.purposeOfAccountID,
                proofOfIncomeInd: (data.proofOfIncomeInd == true) ? 1 : 0,
                accountVariantID: data.accountVariantID,
                atmTypeID: data.atmTypeID,
                transAlertInd: (data.transAlertInd == true) ? 1 : 0,
                chequeBookReqInd: (data.chequeBookReqInd == true) ? 1 : 0,
                transactionalAlertID: data.transactionalAlertID,
                natureOfAccountID: data.natureOfAccountID,
                pdaRemitterDetailList: pdaRemitters,
                noOfJointApplicants: data.noOfJointApplicants,
                genderId: modelRegistrationSteper.genderId
            )
        }
        
        remitters.forEach { remitter in
            logsManager.debug(remitter.nameOfRemitter, remitter.relationship)
        }
    }
    
    private func subscribeViewModel() {
        remitterDetailViewModel.registerConsumerAccountInfoResponse.bind { [weak self] response in
            guard let self = self, let response = response else { return }
            DataCacheManager.shared.saveRegisterConsumerAccountInfoResponse(input: response)// why?
            if self.fromViewController == "FATCADetailsViewController" {
                self.delegate?.addChild(vc: .personalInformationSecondVC, fromViewController: "")
            }
            else {
                self.delegate?.addChild(vc: .serviceChannelsVC, fromViewController: "")
            }
        }
        
        remitterDetailViewModel.errorMessage.bind { error in
            guard let error = error else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: error)
        }
    }
}

extension RemitterDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remitters.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < remitters.count {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RemitterDetailCell", for: indexPath) as? RemitterDetailCell
            cell?.nameOfRemitterTextField.tag = indexPath.row
            cell?.relationshipTextField.tag = indexPath.row
            
            cell?.nameOfRemitterTextField.delegate = self
            cell?.relationshipTextField.delegate = self
            
            cell?.nameOfRemitterTextField.text = remitters[indexPath.row].nameOfRemitter
            cell?.relationshipTextField.text = remitters[indexPath.row].relationship
            
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddRemitterCell", for: indexPath) as? AddRemitterCell
            
            cell?.addRemitter = { [weak self] in
                guard let self = self else { return }
                self.remitters.append(
                    RemitterTextModel(
                        nameOfRemitter: "",
                        relationship: ""
                    )
                )
                self.tableView.reloadData()
            }
            
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < remitters.count {
            return 300
        } else {
            return 65
        }
    }
}

extension RemitterDetailVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let index = IndexPath(row: textField.tag, section: 0)
        if let cell = tableView.cellForRow(at: index) as? RemitterDetailCell {
            if textField == cell.nameOfRemitterTextField {
                remitters[textField.tag].nameOfRemitter = textField.text ?? ""
            } else if textField == cell.relationshipTextField {
                remitters[textField.tag].relationship = textField.text ?? ""
            }
        }
    }
}
