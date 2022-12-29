//
//  TaxResidentDetailVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 26/04/2022.
//

import UIKit
import BetterSegmentedControl
import DropDown

final class TaxResidentDetailVC: UIViewController {
    
    @IBOutlet weak var labelReson: LabelSetting!

    @IBOutlet weak var taxNumberNotAvailableView: CustomUIView!
    @IBOutlet weak var enterTaxNumberView: CustomUIView!
    @IBOutlet weak var enterTaxNumberTextField: UITextField!
    
    
    @IBOutlet weak var taxResidentSegment: BetterSegmentedControl!
    @IBOutlet weak var taxIdentificationNumSegment: BetterSegmentedControl!
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var taxIdentificationNumView: UIStackView!
    @IBOutlet weak var resonView: UIView!
    @IBOutlet weak var resonBView: UIView!
    
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var viewObjects: UIView!

    @IBOutlet weak var viewTaxIdentificationNumber: UIView!
    @IBOutlet weak var textFieldIDentificationNumber: TextFieldSetting!
    
    private let taxResidentViewModel = TaxResidentViewModel()
    private let selectCountryDropDown = DropDown()
    private let selectResonDropDown = DropDown()

    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCountry.isHidden = true
        stackViewObjects.isHidden = true
        resonView.isHidden = false
        viewTaxIdentificationNumber.isHidden = true
        resonBView.isHidden = true
        
        taxResidentSegment.segments = LabelSegment.segments(
            withTitles: ["No", "Yes"],
            normalTextColor: .white,
            selectedTextColor: UIColor(
                red: 0.92,
                green: 0.29,
                blue: 0.15,
                alpha: 1.00
            )
        )
        
        taxIdentificationNumSegment.segments = LabelSegment.segments(
            withTitles: ["No", "Yes"],
            normalTextColor: .white,
            selectedTextColor: UIColor(
                red: 0.92,
                green: 0.29,
                blue: 0.15,
                alpha: 1.00
            )
        )
        
        taxResidentViewModel.getTaxNotAvailableReasons(
            codeTypeID: Double(BaseConstants.Config.taxNotAvailableLookupID)
        )
        taxResidentViewModel.setTaxResident(value: 0)
        
        taxResidentSegment.setIndex(0)
        
        taxIdentificationNumSegment.setIndex(1)
        viewTaxIdentificationNumber.isHidden = false
        resonView.isHidden = true
        
        setupDropdown()
        setupGestureRecognizers()
        subscribeViewModel()
        taxResidentViewModel.getCountries()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if modelRegistrationSteper.isNationalityDual ?? false {
            taxResidentSegment.setIndex(1)
            labelCountry.text = modelRegistrationSteper.countryDual
            if let countryDualId = modelRegistrationSteper.countryDualId {
                taxResidentViewModel.setCountryOfTaxResidenceID(for: countryDualId)
            }
            
            if modelRegistrationSteper.isTaxIdentificationNoDual ?? false {
                taxIdentificationNumSegment.setIndex(1)
                enterTaxNumberTextField.text = modelRegistrationSteper.taxNumberDual
            }
            else {
                taxIdentificationNumSegment.setIndex(0)
                labelReson.text = modelRegistrationSteper.taxNotAvailableReson
                if let taxNotAvailableResonId = modelRegistrationSteper.taxNotAvailableResonId {
                    taxResidentViewModel.setTaxNotAvailableReason(id: taxNotAvailableResonId)
                }
                if taxResidentViewModel.getTaxNotAvailableReasonID() == 101202.0 {
                    resonBView.isHidden = false
                    textFieldIDentificationNumber.text = modelRegistrationSteper.taxFormBExplanation
                }
                else {
                    resonBView.isHidden = true                    
                }
            }
        }
    }
    
    @IBOutlet weak var viewReson: CustomUIView!
    @IBAction func toggleTaxSegment(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            viewTaxIdentificationNumber.isHidden = true
            resonView.isHidden = false
        } else {
            viewTaxIdentificationNumber.isHidden = false
            resonView.isHidden = true
        }
    }
    
    @IBAction func outSidePakistanSegment(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            viewCountry.isHidden = true
            stackViewObjects.isHidden = true
        } else {
            viewCountry.isHidden = false
            stackViewObjects.isHidden = false
        }
        if sender.index == 0 {
            viewCountry.isHidden = true
            taxIdentificationNumView.isHidden = true
        } else {
            viewCountry.isHidden = false
            taxIdentificationNumView.isHidden = false
        }
    }

    @IBOutlet weak var stackViewObjects: UIStackView!
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if taxResidentSegment.index == 1 {
            if labelCountry.text?.lowercased() == "select country" {
                self.showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: "Please select country")
                return()
            }
            modelRegistrationSteper.isNationalityDual = true
            modelRegistrationSteper.countryDual = labelCountry.text
            modelRegistrationSteper.countryDualId = self.taxResidentViewModel.getCountyofTaxResidenceID()
            if taxIdentificationNumSegment.index == 1 {
                if enterTaxNumberTextField.text?.count == 0 {
                    AlertManager.shared.showOKAlert(with: "Alert!", message: "Please Enter Tax Identification Number first")
                    return()
                }
                modelRegistrationSteper.isTaxIdentificationNoDual = true
                modelRegistrationSteper.taxNotAvailableReson = labelReson.text
                modelRegistrationSteper.taxFormBExplanation = nil
                modelRegistrationSteper.taxNotAvailableReson = nil
                modelRegistrationSteper.taxNotAvailableResonId = nil
            }
            else {
                if labelReson.text?.lowercased() == "please select" {
                    self.showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: "Please select reason")
                    return()
                }
                modelRegistrationSteper.taxNotAvailableResonId = taxResidentViewModel.getTaxNotAvailableReasonID()
                if taxResidentViewModel.getTaxNotAvailableReasonID() == 101202.0 {
                    modelRegistrationSteper.taxFormBExplanation = textFieldIDentificationNumber.text
                }
                else {
                    modelRegistrationSteper.taxFormBExplanation = nil
                }
                modelRegistrationSteper.isTaxIdentificationNoDual = false
                taxResidentViewModel.setTaxIdentificationNumber(value: enterTaxNumberTextField.text ?? "")
            }
        }
        else {
            modelRegistrationSteper.isNationalityDual = false
            modelRegistrationSteper.isTaxIdentificationNoDual = false
            modelRegistrationSteper.countryDual = nil
            modelRegistrationSteper.countryDualId = nil
            modelRegistrationSteper.taxNumberDual = nil
        }
        
        let taxIDNumber = taxResidentViewModel.getTaxIdentificationNumber()
        let taxNotAvailableReasonID = taxResidentViewModel.getTaxNotAvailableReasonID()
//        let taxResident = taxResidentViewModel.getTaxResident()
        let taxResident = taxResidentSegment.index

        let explanation = (modelRegistrationSteper.taxFormBExplanation != nil ? textFieldIDentificationNumber.text : taxResidentViewModel.getTaxNotAvailableReason()?.description ?? "N/A")!
        print(taxResidentViewModel.getCountyofTaxResidenceID())
        var countryResidentID = "\(taxResidentViewModel.getCountyofTaxResidenceID())"
        print(countryResidentID)
        guard let residentCountry = BasicInfoResidentCountriesInputModel(
            explanation: explanation,
            rdaCustomerID: BaseConstants.Config.rdaCustomerId, // Enter correct rdaCustomerID
            taxIdentityNo: taxIDNumber,
            tinReasonID: taxNotAvailableReasonID,
            taxResidentInd: taxResident,
            countryOfTaxResidenceId: countryResidentID
        ) else { return }
        taxResidentViewModel.registerConsumerBasicInfo(
            residentCountries: [residentCountry]
        )
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        if let count = self.parent?.children.count {
            if count > 1 {
                self.delegate?.removeChild()
                self.parent?.children.last?.remove()
            } else {
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func setupDropdown() {
        selectCountryDropDown.anchorView = viewCountry
        selectCountryDropDown.direction = .any
        selectCountryDropDown.width = viewCountry.bounds.width
        selectCountryDropDown.frame.size.height = 400
        selectCountryDropDown.bottomOffset = CGPoint(
            x: 0,
            y: selectCountryDropDown.anchorView?.plainView.bounds.height ?? 0
        )
        selectCountryDropDown.selectionAction = { [unowned self] index, item in
            taxResidentViewModel.setCountryOfTaxResidenceID(for: index)
            self.labelCountry.text = item
            self.taxResidentViewModel.setCountryOfTaxResidenceID(for: index)
        }

        selectResonDropDown.anchorView = viewReson
        selectResonDropDown.direction = .bottom
        selectResonDropDown.width = viewReson.bounds.width
        selectResonDropDown.bottomOffset = CGPoint(
            x: 0,
            y: selectResonDropDown.anchorView?.plainView.bounds.height ?? 0
        )
        
        selectResonDropDown.selectionAction = { [unowned self] index, item in
            taxResidentViewModel.setTaxNotAvailableReason(for: index)
            let taxNotAvailableReason = taxResidentViewModel.getTaxNotAvailableReason()
            labelReson.text = taxNotAvailableReason?.description
            taxResidentViewModel.setTaxNotAvailableReason(id: taxNotAvailableReason?.id ?? 0)
            print(taxNotAvailableReason?.id ?? 0)
            if taxNotAvailableReason?.id ?? 0 == 101202.0 {
                resonBView.isHidden = false
            }
            else {
                resonBView.isHidden = true
            }
        }
    }
    
    private func setupGestureRecognizers() {
        viewReson.addGestureRecognizer(
            UITapGestureRecognizer(
                target: taxResidentViewModel,
                action: #selector(taxResidentViewModel.openResonDropdown)
            )
        )
        viewCountry.addGestureRecognizer(
            UITapGestureRecognizer(
                target: taxResidentViewModel,
                action: #selector(taxResidentViewModel.openCountryDropdown)
            )
        )
    }
    
    private func subscribeViewModel() {
        taxResidentViewModel.countryLookupResponse.bind { [weak self] response in
            guard let self = self, let countryLookupResponse = response?.data else { return }
            let countries = countryLookupResponse.map {
                $0.name ?? "N/A"
            } as! [String]
            DispatchQueue.main.async {
                print(self.selectCountryDropDown)
                self.selectCountryDropDown.dataSource = countries
            }
        }
        
        taxResidentViewModel.countryDropDownTapped.bind { [weak self]  isTapped in
            guard let self = self, isTapped else { return }
            self.selectCountryDropDown.show()
        }
        
        taxResidentViewModel.taxNotAvailableReasons.bind { [weak self] response in
            guard let self = self, let taxNotAvailableReasons = response?.data else { return }
            self.selectResonDropDown.dataSource = taxNotAvailableReasons.map { $0.description ?? "N/A" }
        }
        
        taxResidentViewModel.resonDropDownTapped.bind { [weak self]  isTapped in
            guard let self = self, isTapped else { return }
            self.selectResonDropDown.show()
        }
        
        taxResidentViewModel.registerConsumerBasicInfoResponse.bind { [weak self] response in
            guard let status = response?.message?.status, let description = response?.message?.description?.lowercased() else { return }
            
            if status == "200" && description.lowercased() == "success"{
                
                guard let registerConsumerAccountInfoResponse = DataCacheManager.shared.loadRegisterConsumerAccountInfoResponse()?.data else { return }
                
                
                guard let personalInformationBaseVC = UIStoryboard.initialize(
                    viewController: .personalInformationBaseVC,
                    fromStoryboard: .openAccount
                ) as? PersonalInformationBaseVC else { return }
                               
                switch modelRegistrationSteper.selectPreferredAccountViewModel?.getAccountVariantID() {
//                case .asaanDigitalRemittanceAccountSaving:
//                    personalInformationBaseVC.firstChild = .personalInfoSecondVC
                case .asaanDigitalRemittanceAccount:
                    self?.delegate?.addChild(vc: .remitterDetailVC, fromViewController: "")
                default:
                    self?.delegate?.addChild(vc: .serviceChannelsVC, fromViewController: "")
                }
                
//                if registerConsumerAccountInfoResponse.accountVariantID == AccountVariant.freelancerDigitalAccount.id{
//                    self?.delegate?.addChild(vc: .fatcaDetailsVC, fromViewController: "TaxResidentDetailVC")
//                }else if registerConsumerAccountInfoResponse.accountVariantID == AccountVariant.asaanDigitalRemittanceAccount.id{
//                    self?.delegate?.addChild(vc: .remitterDetailVC, fromViewController: "TaxResidentDetailVC")
//                }
//                else {
//                    self?.delegate?.addChild(vc: .serviceChannelsVC, fromViewController: "TaxResidentDetailVC")
//                }
            }
        }
    }
}

