//
//  ChangeNumberVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 19/04/2022.
//

import UIKit
import BetterSegmentedControl

final class ChangeNumberVC: UIViewController {
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var portedSegment: BetterSegmentedControl!
    
    @IBAction func buttonUrdu(_ sender: Any) {
        funChangeAppLanguageAndSide(to: "ur", vc: self)
    }
    @IBOutlet weak var buttonUrdu: UIButton!
    private let changeNumberViewModel = ChangeNumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        portedSegment.segments = LabelSegment.segments(
            withTitles: ["No", "Yes"],
            normalBackgroundColor: PluginColorAsset.otpFieldBorder.color,
            normalTextColor: .white,
            selectedBackgroundColor: PluginColorAsset.appOrange.color,
            selectedTextColor: .white
        )
        
        mobileNumberLabel.makeAttributedText(stringToColor: "*")
        subscribeViewModel()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let viewAppsGenerateOTP = DataCacheManager.shared.loadViewAppGenerateOTPResponse() else { return }
        if mobileNumberTextField.text?.count == 0{
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please enter Mobile Number first")
        }else{
            changeNumberViewModel.changeNumber(
                mobileNumber: mobileNumberTextField.text,
                rdaCustomerProfileID: viewAppsGenerateOTP.rdaCustomerProfileID
            )
        }
    }
    
    @IBAction func toggleSegmentControl(_ sender: BetterSegmentedControl) {
        if sender.index == 1 {
            openPortedPopupVC()
        }
    }
    
    private func openPortedPopupVC() {
        guard let portedPopupVC = UIStoryboard.initialize(
            viewController: .portedPopupVC,
            fromStoryboard: .cnicUpload
        ) as? PortedPopupVC else { return }
        
        portedPopupVC.portedMobileNetwork = { [weak self] in
            guard let self = self else { return }
            self.portedSegment.setIndex(1)
        }
        
        present(portedPopupVC, animated: true)
    }
    
    private func openCNICAvailabilityVC() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func subscribeViewModel() {
        changeNumberViewModel.changeNumberResponse.bind { [weak self] response in
            guard let self = self, let _ = response else { return }
            AlertManager.shared.showOKChoiceAlert(
                title: "Success",
                message: "Mobile number has been successfully changed"
            ) { _ in
                self.changeNumberViewModel.openCNICAvailabilityVC()
            }
        }
        
        changeNumberViewModel.routeToCNICAvailabilityVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openCNICAvailabilityVC()
        }
        
        changeNumberViewModel.errorMessage.bind { message in
            guard let message = message else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: message)
        }
    }
}
