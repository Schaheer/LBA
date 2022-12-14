//
//  CurrentTaxResidentDetailVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 24/05/2022.
//

import UIKit
import BetterSegmentedControl
import DropDown

final class CurrentTaxResidentDetailVC: UIViewController {
    
    @IBOutlet weak var taxResidentOutsideSegment: BetterSegmentedControl!
    @IBOutlet weak var taxIDNumberSegment: BetterSegmentedControl!
    
    @IBOutlet weak var selectCountryParentView: UIView!
    @IBOutlet weak var selectCountryContainer: CustomUIView!
    @IBOutlet weak var selectCountryLabel: UILabel!
    
    @IBOutlet weak var taxIDNumberContainer: UIView!
    @IBOutlet weak var taxIDNumberTextField: UITextField!
    
    @IBOutlet weak var tinNotAvailableParentView: CustomUIView!
    @IBOutlet weak var tinNotAvailableContainer: UIView!
    @IBOutlet weak var tinNotAvailableLabel: UILabel!
    
    @IBOutlet weak var tinReasonTextField: UITextField!
    
    @IBOutlet weak var tinStackView: UIStackView!
    
    private let currentTaxResidentDetailViewModel = CurrentTaxResidentDetailViewModel()
    private let countryDropdown = DropDown()
    private let tinNonAvailabilityReasonDropdown = DropDown()
    
    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegments()
        setupDropdowns()
        setupGestureRecognizers()
        subscribeViewModel()
        
        currentTaxResidentDetailViewModel.getCountries()
        currentTaxResidentDetailViewModel.getTinNotAvailableReasons(
            codeTypeID: BaseConstants.Config.taxNotAvailableLookupID
        )
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard
            let consumer = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last
        else { return }
        
        let taxResidentInd = currentTaxResidentDetailViewModel.getTaxResidentInd()
        let tinReasonID = currentTaxResidentDetailViewModel.getTinReasonID()
        
        if taxResidentInd == 0 {
            currentTaxResidentDetailViewModel.registerConsumerBasicInfoForTaxIn(
                customerAccInfoID: consumer.accountInformation?.rdaCustomerAccInfoID,
                customerProfileID: consumer.rdaCustomerProfileID,
                customerTypeID: consumer.customerTypeID,
                taxResidentInd: taxResidentInd,
                isPrimary: true
            )
        } else {
            if taxIDNumberTextField.text?.count == 0{
                AlertManager.shared.showOKAlert(with: "Alert!", message: "Please enter Reason first")
            }else{
                currentTaxResidentDetailViewModel.registerConsumerBasicInfoForTaxOut(
                    customerAccInfoID: consumer.accountInformation?.rdaCustomerAccInfoID,
                    customerProfileID: consumer.rdaCustomerProfileID,
                    customerTypeID: consumer.customerTypeID,
                    customerID: consumer.accountInformation?.rdaCustomerID,
                    taxResidentInd: taxResidentInd,
                    isPrimary: true,
                    taxIDNumber: taxIDNumberTextField.text ?? "",
                    tinReasonID: tinReasonID,
                    tinReason: tinReasonTextField.text ?? ""
                )
            }
        }
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
    
    @IBAction func toggleTaxResidentOutsideSegment(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            selectCountryParentView.isHidden = true
            tinStackView.isHidden = true
            currentTaxResidentDetailViewModel.setTaxResidentInd(taxResidentInd: 0)
        } else {
            selectCountryParentView.isHidden = false
            tinStackView.isHidden = false
            currentTaxResidentDetailViewModel.setTaxResidentInd(taxResidentInd: 1)
        }
    }
    
    @IBAction func toggleTaxIDNumberSegment(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            tinNotAvailableParentView.isHidden = false
            taxIDNumberContainer.isHidden = true
            currentTaxResidentDetailViewModel.setHasTaxIDNumber(hasTaxIDNumber: 0)
        } else {
            tinNotAvailableParentView.isHidden = true
            taxIDNumberContainer.isHidden = false
            currentTaxResidentDetailViewModel.setHasTaxIDNumber(hasTaxIDNumber: 1)
        }
    }
    
    private func setupSegments() {
        taxResidentOutsideSegment.segments = LabelSegment.segments(
            withTitles: ["No".localizeString(), "Yes".localizeString()],
            normalTextColor: .white,
            selectedTextColor: UIColor(
                red: 0.92,
                green: 0.29,
                blue: 0.15,
                alpha: 1.00
            )
        )
        
        taxIDNumberSegment.segments = LabelSegment.segments(
            withTitles: ["No".localizeString(), "Yes".localizeString()],
            normalTextColor: .white,
            selectedTextColor: UIColor(
                red: 0.92,
                green: 0.29,
                blue: 0.15,
                alpha: 1.00
            )
        )
    }
    
    private func setupDropdowns() {
        countryDropdown.anchorView = selectCountryContainer
        countryDropdown.direction = .bottom
        countryDropdown.frame.size.height = 250
        countryDropdown.bottomOffset = CGPoint(
            x: 0,
            y: countryDropdown.anchorView?.plainView.bounds.height ?? 0
        )
        
        countryDropdown.selectionAction = { [unowned self] index, item in
            self.selectCountryLabel.text = item
            self.currentTaxResidentDetailViewModel.setCountryOfTaxResidenceID(for: index)
        }
        
        tinNonAvailabilityReasonDropdown.anchorView = tinNotAvailableContainer
        tinNonAvailabilityReasonDropdown.direction = .bottom
        tinNonAvailabilityReasonDropdown.bottomOffset = CGPoint(
            x: 0,
            y: tinNonAvailabilityReasonDropdown.anchorView?.plainView.bounds.height ?? 0
        )
        
        tinNonAvailabilityReasonDropdown.selectionAction = { [unowned self] index, item in
            self.tinNotAvailableLabel.text = item
            self.currentTaxResidentDetailViewModel.setTinReasonID(for: index)
        }
    }
    
    private func setupGestureRecognizers() {
        selectCountryContainer.addGestureRecognizer(
            UITapGestureRecognizer(
                target: currentTaxResidentDetailViewModel,
                action: #selector(currentTaxResidentDetailViewModel.openCountryDropdown)
            )
        )
        
        tinNotAvailableContainer.addGestureRecognizer(
            UITapGestureRecognizer(
                target: currentTaxResidentDetailViewModel,
                action: #selector(currentTaxResidentDetailViewModel.openTinNonAvailabilityReasonDropdown)
            )
        )
    }
    
    private func subscribeViewModel() {
        currentTaxResidentDetailViewModel.countryLookupResponse.bind { [weak self] response in
            guard let self = self, let countries = response?.data else { return }
            self.countryDropdown.dataSource = countries.map { $0.name ?? "N/A" }
        }
        
        currentTaxResidentDetailViewModel.tinNotAvailableReasonResponse.bind { [weak self] response in
            guard let self = self, let reasons = response?.data else { return }
            self.tinNonAvailabilityReasonDropdown.dataSource = reasons.map { $0.description ?? "N/A" }
        }
        
        currentTaxResidentDetailViewModel.countryDropdownTapped.bind { [weak self] isTapped in
            guard let self = self, isTapped else { return }
            self.countryDropdown.show()
        }
        
        currentTaxResidentDetailViewModel.tinNonAvailabilityReasonDropdownTapped.bind { [weak self] isTapped in
            guard let self = self, isTapped else { return }
            self.tinNonAvailabilityReasonDropdown.show()
        }
        
        currentTaxResidentDetailViewModel.registerConsumerBasicInfoResponse.bind { [weak self] response in
            guard let self = self, let response = response else { return }
            guard
                let status = response.message?.status,
                let description = response.message?.description?.lowercased()
            else { return }
            
            if status == "200" && description == "success" {
                self.delegate?.addChild(vc: .serviceChannelsVC, fromViewController: "")
            }
        }
    }
}

class ChatView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }

    func commonInit() {
        isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
//        let alert = UIAlertController(title: "Alert".localizeString(), message: "Pending from client".localizeString(), preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK".localizeString(), style: .default))
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
//            topController.present(alert, animated: true, completion: nil)
            topController.showAlertSuccessWithPopToVC(viewController: topController, title: "Alert".localizeString(), message: "Pending from client".localizeString())
            
        }
        
        
        
//        guard let url = URL(string: "http://www.google.com") else {
//          return //be safe
//        }
//
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.openURL(url)
//        }
    }

}
