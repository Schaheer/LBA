//
//  OccupationVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/03/2022.
//

import UIKit
import TTGTags
import DropDown

final class OccupationVC: UIViewController {
    
    @IBOutlet weak var selectOccupationView: UIView!
    @IBOutlet weak var selectOccupationLabel: UILabel!
    
    @IBOutlet weak var selectProfessionView: UIView!
    @IBOutlet weak var selectProfessionLabel: UILabel!
    @IBOutlet weak var textFieldNtn: UITextField!
    @IBOutlet weak var stackViewOccupation: UIStackView!
    @IBOutlet weak var stackViewProfession: UIStackView!
    @IBOutlet weak var avgMonthlySalaryTF: UITextField!
    
    
    var isEditFromReviewDetailsViewController = false
    var forViewController = ""
    
    private let occupationsListDropDown = DropDown()
    private let professionsListDropDown = DropDown()
    private var employmentDetailsViewModel = EmploymentDetailsViewModel()
    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoadCustom()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        employmentDetailsViewModel.getOcupationsList(codeTypeID: 1014)
        employmentDetailsViewModel.getProfessionList(codeTypeID: 1016)
        setupDropdown()
        subscribeViewModel()
        setupGestureRecognizers()
    }
    
    func viewDidLoadCustom() {
        
        if modelRegistrationSteper.employmentDetailsViewModel != nil {
            let tempViewModel = modelRegistrationSteper.employmentDetailsViewModel!
            self.employmentDetailsViewModel.setProfession(id: tempViewModel.getSelectedProfessionId())
            self.employmentDetailsViewModel.setOccupation(id: tempViewModel.getSelectedOccupationId())
            selectProfessionLabel.text = modelRegistrationSteper.profession!
            selectOccupationLabel.text = modelRegistrationSteper.occupation!
            textFieldNtn.text = modelRegistrationSteper.ntnNumber!
            avgMonthlySalaryTF.text! = modelRegistrationSteper.salaryIncome!
        }
        
    }
    
    
    var occopationDataSource = [String]()
    @objc func openOccupation() {
        let dataSource = occopationDataSource
        DispatchQueue.main.async {
            self.showSelectionAlert(with: dataSource, title: "Searched Occupation", isSearchViewHidden: true) { index, item in
                logsManager.debug("Selected item \(item) at index \(index)")
                let occupation = self.employmentDetailsViewModel.getOccupation(at: index)
                self.selectOccupationLabel.text = occupation?.description
                self.employmentDetailsViewModel.setOccupation(id: occupation?.id ?? 0)
                self.professionBasedOccupation(occupationId: occupation?.id ?? 0)
            }
        }
    }
    var professionDataSource = [String]()
    @objc func openProfession() {
        let dataSource = professionDataSource
        DispatchQueue.main.async {
            self.showSelectionAlert(with: dataSource, title: "Searched Profession", isSearchViewHidden: true) { index, item in
                logsManager.debug("Selected item \(item) at index \(index)")
                let profession = self.employmentDetailsViewModel.getProfession(at: index)
                self.selectProfessionLabel.text = profession?.description
                self.employmentDetailsViewModel.setProfession(id: profession?.id ?? 0)
            }
        }

    }
    private func setupGestureRecognizers() {
        selectOccupationView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: employmentDetailsViewModel,
                action: #selector(employmentDetailsViewModel.openOccupationsDropdown)
            )
        )

        selectProfessionView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: employmentDetailsViewModel,
                action: #selector(employmentDetailsViewModel.openProfessionsDropdown)
            )
        )
    }

    
    private func setupDropdown() {
        occupationsListDropDown.anchorView = selectOccupationView
        occupationsListDropDown.frame.origin.y = selectOccupationView.frame.maxY
        occupationsListDropDown.direction = .any
        occupationsListDropDown.width = selectOccupationView.bounds.width
        occupationsListDropDown.frame.size.height = 250
        occupationsListDropDown.bottomOffset = CGPoint(
            x: 0,
            y: occupationsListDropDown.anchorView?.plainView.bounds.height ?? 0
        )
        
        occupationsListDropDown.selectionAction = { [unowned self] index, item in
            let occupation = employmentDetailsViewModel.getOccupation(at: index)
            self.selectOccupationLabel.text = occupation?.description
            self.employmentDetailsViewModel.setOccupation(id: occupation?.id ?? 0)
            self.professionBasedOccupation(occupationId: occupation?.id ?? 0)
        }
        
        professionsListDropDown.anchorView = selectProfessionView
        professionsListDropDown.direction = .any
        professionsListDropDown.width = selectProfessionView.bounds.width
        professionsListDropDown.frame.size.height = 250
        professionsListDropDown.bottomOffset = CGPoint(
            x: 0,
            y: professionsListDropDown.anchorView?.plainView.bounds.height ?? 0
        )
        
        professionsListDropDown.selectionAction = { [unowned self] index, item in
            let profession = employmentDetailsViewModel.getProfession(at: index)
            self.selectProfessionLabel.text = profession?.description
            self.employmentDetailsViewModel.setProfession(id: profession?.id ?? 0)
        }
    }
    var relevantProfId = Int()

    private func professionBasedOccupation(occupationId: Double) {
        //for auto selection of profession, based on occupation
        //for daily wager
        print(occupationId)
        print(employmentDetailsViewModel.getSelectedOccupationId())
        //101409.0(self employeed) 101402.0(Salaried person)
        relevantProfId = Int()
        if occupationId == 101409.0 || occupationId == 101402.0 || occupationId == 101401.0 {
            stackViewProfession.isHidden = false
        }
        else {
            stackViewProfession.isHidden = true
        }
        if (employmentDetailsViewModel.getSelectedOccupationId() == 101408) {
            relevantProfId = 820;
        }
        //for house wife
        else if (employmentDetailsViewModel.getSelectedOccupationId() == 101405) {
            relevantProfId = 370;
        }
        //for pension or retired
        else if (employmentDetailsViewModel.getSelectedOccupationId() == 101406) {
            relevantProfId = 810;
        }
        //for student
        else if (employmentDetailsViewModel.getSelectedOccupationId() == 101404) {
            relevantProfId = 650;
        }
        //for unemployed
        else if (employmentDetailsViewModel.getSelectedOccupationId() == 101407) {
            relevantProfId = 720;
        }
        self.employmentDetailsViewModel.setProfession(id: Double(relevantProfId))
    }
    
    private func subscribeViewModel() {
        
        employmentDetailsViewModel.occupationsList.bind { [weak self] response in
            guard let self = self, let occupationsList = response?.data else { return }
//            self.occupationsListDropDown.dataSource = occupationsList.map { $0.description ?? "N/A" }
            self.occopationDataSource = occupationsList.map { $0.description ?? "N/A" }
        }
        
        employmentDetailsViewModel.occupationDropDownTapped.bind { [weak self] isTapped in
            
            guard let self = self, isTapped else { return }
//            self.occupationsListDropDown.show()
            self.openOccupation()
        }
        
        
        employmentDetailsViewModel.professionsList.bind { [weak self] response in
            guard let self = self, let professionList = response?.data else { return }
//            self.professionsListDropDown.dataSource = professionList.map { $0.description ?? "N/A" }
            self.professionDataSource = professionList.map { $0.description ?? "N/A" }

        }
        
        employmentDetailsViewModel.professionsDropDownTapped.bind { [weak self] isTapped in
            print(isTapped)
            guard let self = self, isTapped else {
                return
            }
//            self.professionsListDropDown.show()
            self.openProfession()
        }
        
        employmentDetailsViewModel.registerConsumerEmploymentDetailsResponse.bind {  response  in
            guard let status = response?.message?.status, let description = response?.message?.description?.lowercased() else { return }
            if status == "200" && description.lowercased() == "success"{
                self.callSaveKyc()
                modelRegistrationSteper.profession = self.selectProfessionLabel.text!
                modelRegistrationSteper.occupation = self.selectOccupationLabel.text!
                modelRegistrationSteper.ntnNumber = self.textFieldNtn.text!
                modelRegistrationSteper.employmentDetailsViewModel = self.employmentDetailsViewModel
                modelRegistrationSteper.salaryIncome = self.avgMonthlySalaryTF.text!
                
//                if self.isEditFromReviewDetailsViewController && self.forViewController == "PersonalInformationSecondVC" || self.forViewController == "NationalityVC" || self.forViewController == "RegisterPermanentAddressViewController" {
//                    self.dismissToViewController(viewController: ReviewDetailsVC.self)
//                    DispatchQueue.main.async {
//                        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifierRefreshReviewDetailsVC"), object: nil)
//                    }
//                }
//                else {
////                    self.delegate?.addChild(vc: .serviceChannelsVC)
//                    self.delegate?.addChild(vc: .taxResidentDetailVC, fromViewController: "OccupationVC")
//
//                }
            }
        }
        
        employmentDetailsViewModel.saveKYCResponseData.bind { [weak self] response  in
           guard let status = response?.message?.status, let description = response?.message?.description?.lowercased() else { return }
            if status == "200" && description.lowercased() == "success" {
//                self?.delegate?.addChild(vc: .serviceChannelsVC)
//                self?.delegate?.addChild(vc: .taxResidentDetailVC, fromViewController: "OccupationVC")
                if self?.isEditFromReviewDetailsViewController ?? false && self?.forViewController == "PersonalInformationSecondVC" || self?.forViewController == "NationalityVC" || self?.forViewController == "RegisterPermanentAddressViewController" {
                    self?.dismissToViewController(viewController: ReviewDetailsVC.self)
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifierRefreshReviewDetailsVC"), object: nil)
                    }
                }
                else {
//                    self.delegate?.addChild(vc: .serviceChannelsVC)
                    self?.delegate?.addChild(vc: .taxResidentDetailVC, fromViewController: "OccupationVC")

                }
            }
        }
    }
    
    private func callSaveKyc(){
        
        let registerOTPResponse = DataCacheManager.shared.loadRegisterVerifyOTPResponse()
        guard let rdaCustomerAccountInfoId = registerOTPResponse?.consumerList?.first?.accountInformation?.rdaCustomerAccInfoID, let rdaCustomerProfileId = registerOTPResponse?.consumerList?.first?.rdaCustomerProfileID else { return }
        let relationCode = DataCacheManager.shared.loadAdditionalApplicantRelationship()?.id
        if avgMonthlySalaryTF.text?.count == 0 {
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please Enter Salary/Income first")
        }else{
            employmentDetailsViewModel.saveKyc(rdaCustomerAccInfoId: rdaCustomerAccountInfoId, rdaCustomerProfileId: rdaCustomerProfileId, isPrimary: false, relationCode1: relationCode, averageMonthlySalary: avgMonthlySalaryTF.text)
        }

    }
    
    @IBAction func nextBtnClicked(_ sender: UIButton){
        if avgMonthlySalaryTF.text?.count == 0 {
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please Enter Salary/Income first")
        }
        else {
            employmentDetailsViewModel.registerConsumerEmploymentDetails(
                customerAccInfoID: DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.first?.accountInformation?.rdaCustomerAccInfoID,
                customerProfiledID: DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.first?.rdaCustomerProfileID,
                occupationId: employmentDetailsViewModel.getSelectedOccupationId(),
                professionId: employmentDetailsViewModel.getSelectedProfessionId(),
                isPrimary: true
            )
        }
    }
    
    @IBAction func backBtnClicked(_ snder: UIButton){
        if let count = self.parent?.children.count {
            if count > 1 {
                self.delegate?.removeChild()
                self.parent?.children.last?.remove()
            }else{
                navigationController?.popViewController(animated: true)
            }
        }
    }
}
//@objc func showDropDownOccupation() {
//    let  dropDown = DropDown(frame: CGRect(x: 110, y: 140, width: 200, height: 30)) // set frame
//    employmentDetailsViewModel.occupationsList.bind { [weak self] response in
//        guard let self = self, let occupationsList = response?.data else { return }
//        print(occupationsList)
//        dropDown.dataSource = occupationsList.map { $0.description ?? "N/A" }
//    }
//
//    dropDown.anchorView = selectOccupationView // UIView or UIBarButtonItem
//    dropDown.direction = .any
//    dropDown.width = selectOccupationView.frame.width
//    dropDown.selectionAction = {(index: Int, item: String) in
//        print("Selected item: \(item) at index: \(index)")
//        let occupation = self.employmentDetailsViewModel.getOccupation(at: index)
//        self.selectOccupationLabel.text = occupation?.description
//        self.employmentDetailsViewModel.setOccupation(id: occupation?.id ?? 0)
//    }
//    dropDown.show()
//}
