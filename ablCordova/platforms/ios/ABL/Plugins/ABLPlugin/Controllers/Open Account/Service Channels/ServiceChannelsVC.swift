//
//  ServiceChannelsVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/03/2022.
//

import UIKit
import BetterSegmentedControl

final class ServiceChannelsVC: UIViewController {
    
    @IBAction func buttonReason(_ sender: Any) {
    }
    @IBOutlet weak var buttonReason: UIButton!
    @IBOutlet weak var labelReason: LabelSetting!
    @IBOutlet weak var viewReason: CustomUIView!
    @IBOutlet weak var nextBtnTapped: UIButton!
    @IBOutlet weak var buttonSms: UIButton!
    @IBOutlet weak var buttonEmail: UIButton!
    @IBAction func buttonSms(_ sender: Any) {
        buttonEmailSMS(button: buttonSms)
    }
    @IBAction func buttonEmail(_ sender: Any) {
        buttonEmailSMS(button: buttonEmail)
    }
    
    var selectedATMTypeId = Double()
    
    func buttonEmailSMSDefault() {
        buttonSms.tag = 1
        
        buttonSms.backgroundColor = PluginColorAsset.alliedBlue.color
        buttonEmail.backgroundColor = .white
        buttonSms.setTitleColor(.white, for: .normal)
        buttonEmail.setTitleColor(PluginColorAsset.alliedBlue.color, for: .normal)
        buttonEmail.layer.cornerRadius = buttonEmail.frame.height / 2
        buttonSms.layer.cornerRadius = buttonSms.frame.height / 2
        buttonEmail.clipsToBounds = true
        buttonSms.clipsToBounds = true
        
    }
    func buttonEmailSMS(button: UIButton) {
        buttonEmail.tag = 0
        buttonSms.tag = 0
        modelRegistrationSteper.isEmail = 0
        modelRegistrationSteper.isSMS = 0
        
        buttonSms.backgroundColor = .white
        buttonEmail.backgroundColor = .white
        buttonSms.setTitleColor(PluginColorAsset.alliedBlue.color, for: .normal)
        buttonEmail.setTitleColor(PluginColorAsset.alliedBlue.color, for: .normal)
        
        if button == buttonEmail {
            modelRegistrationSteper.isEmail = 1
            modelRegistrationSteper.isSMS = 0
        }
        else {
            modelRegistrationSteper.isEmail = 0
            modelRegistrationSteper.isSMS = 1
        }
        
        DispatchQueue.main.async {
            button.tag = 1
            button.backgroundColor = PluginColorAsset.alliedBlue.color
            button.setTitleColor(.white, for: .normal)
        }
    }
    @IBOutlet weak var debitCardSwitch: BetterSegmentedControl!
    @IBOutlet weak var chequeBookSwitch: BetterSegmentedControl!
    @IBOutlet weak var transactionalAlertsSwitch: BetterSegmentedControl!
    @IBOutlet weak var atmTypeCollectionView: UICollectionView!
    @IBOutlet var atmtypeCollectionLayout: UICollectionViewFlowLayout!
    
    private var serviceChannelsVM = ServiceChannelsViewModel()
    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    private var atmTypes = [CodeTypeDataModel]()
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        buttonEmailSMSDefault()
        serviceChannelsVM.getATMTypes(
            codeTypeID: BaseConstants.Config.allATMTypesLookupId
        )
        setupCollectionViews()
        subscribeViewModel()
        viewReason.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        viewDidAppearCustom()
    }
    func viewDidAppearCustom() {
        if modelRegistrationSteper.serviceChannelsVM != nil {
            let tempViewModel = modelRegistrationSteper.serviceChannelsVM!
            selectedATMTypeId = tempViewModel.getSelectedATMTypeID()!
            
            serviceChannelsVM.setSelectedATMTypeID(accountVariantID: selectedATMTypeId)
            tempViewModel.getATMTypes(
                codeTypeID: BaseConstants.Config.allATMTypesLookupId
            )
            setupCollectionViews()
            subscribeViewModel()
            
            if modelRegistrationSteper.isSMS != nil {
                let index = modelRegistrationSteper.isSMS
                if index == 1 {
                    buttonEmailSMS(button: buttonSms)
                }
            }
            if modelRegistrationSteper.isEmail != nil {
                let index = modelRegistrationSteper.isEmail
                if index == 1 {
                    buttonEmailSMS(button: buttonEmail)
                }
            }
            if modelRegistrationSteper.chequeBookIndex != nil {
                let index = modelRegistrationSteper.chequeBookIndex
                chequeBookSwitch.isEnabled = index == 1
                chequeBookSwitch.isSelected = index == 1
                chequeBookSwitch.setIndex(index!)
            }
            if modelRegistrationSteper.debitCardIndex != nil {
                let index = modelRegistrationSteper.debitCardIndex
                debitCardSwitch.isEnabled = index == 1
                debitCardSwitch.isSelected = index == 1
                debitCardSwitch.setIndex(index!)
            }
            if modelRegistrationSteper.transAlertIndex != nil {
                let index = modelRegistrationSteper.transAlertIndex
                transactionalAlertsSwitch.isEnabled = index == 1
                transactionalAlertsSwitch.isSelected = index == 1
                transactionalAlertsSwitch.setIndex(index!)
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        
    }
    
    private func setupViews() {
        if nextBtnTapped.tag != 1 {
            debitCardSwitch.segments = LabelSegment.segments(withTitles: ["No", "Yes"],
                                                             normalTextColor: .white,
                                                             selectedTextColor: UIColor(red: 0.92, green: 0.29, blue: 0.15, alpha: 1.00))
            if modelRegistrationSteper.chequeBookIndex == nil {
                debitCardSwitch.isEnabled = true
                debitCardSwitch.isSelected = true
                debitCardSwitch.setIndex(1)
            }
            
            
            chequeBookSwitch.segments = LabelSegment.segments(withTitles: ["No", "Yes"],
                                                             normalTextColor: .white,
                                                             selectedTextColor: UIColor(red: 0.92, green: 0.29, blue: 0.15, alpha: 1.00))
            transactionalAlertsSwitch.segments = LabelSegment.segments(withTitles: ["Required", "Not Required"],
                                                             normalTextColor: .white,
                                                             selectedTextColor: UIColor(red: 0.92, green: 0.29, blue: 0.15, alpha: 1.00))
        }
        nextBtnTapped.tag = 0
    }
    
    private func setupCollectionViews(){
        
        atmTypeCollectionView.register(UINib(nibName: ATMTypeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ATMTypeCollectionViewCell.identifier)
        atmtypeCollectionLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width * 0.4, height: 1)
        atmTypeCollectionView.delegate = self
        atmTypeCollectionView.dataSource = self
        
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton){
        if let count = self.parent?.children.count{
            if count > 1{
                self.delegate?.removeChild()
                self.parent?.children.last?.remove()
            }else{
                
                navigationController?.popViewController(animated: true)
                
            }
        }
        
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton){
        nextBtnTapped.tag = 1
        serviceChannelsVM.registerConsumerEmploymentDetails(
            customerAccInfoID: DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last?.accountInformation?.rdaCustomerAccInfoID,
//            customerProfiledID: DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.first?.rdaCustomerProfileID,
            rdaCustomerId: DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last?.accountInformation?.rdaCustomerID,
            customerTypeId: BaseConstants.Config.customerTypeID,
            atmTypeId: serviceChannelsVM.getSelectedATMTypeID(),
            transAlertInd: transactionalAlertsSwitch.index == 0 ? true.intValue : false.intValue,
            chequeBookReqInd: chequeBookSwitch.index == 0 ? true.intValue : false.intValue,
            transactionalAlertId: getTransactionalAlertId(),
            rdaCustomerProfileId: DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last?.rdaCustomerProfileID
        )
    }
    
    @IBAction func debitCardSwitchValueChanged(_ sender: BetterSegmentedControl) {
        print("The selected index is \(sender.index)")
        modelRegistrationSteper.debitCardIndex = sender.index
    }
    
    @IBAction func chequeBookSwitchValueChanged(_ sender: BetterSegmentedControl) {
        print("The selected index is \(sender.index)")
        modelRegistrationSteper.chequeBookIndex = sender.index
    }
    
    @IBAction func transAlertSwitchValueChanged(_ sender: BetterSegmentedControl) {
        print("The selected index is \(sender.index)")
        modelRegistrationSteper.transAlertIndex = sender.index
    }
    
    func getTransactionalAlertId() -> Double {
        return transactionalAlertsSwitch.index == 0 ? 114401 : 114402
    }
    
    private func subscribeViewModel() {
        serviceChannelsVM.registerConsumerTransactionDetailsResponse.bind { [weak self]   response  in
            guard let status = response?.message?.status, let description = response?.message?.description?.lowercased() else { return }
            if status == "200" && description.lowercased() == "success"{
                self?.delegate?.addChild(vc: .pictureAndSignatureVC, fromViewController: "")
            }
        }
        
        serviceChannelsVM.atmTypes.bind { [weak self]   atmTypes in
            guard let self = self, let atmTypes = atmTypes?.data else { return }
            self.atmTypes = atmTypes
            self.atmTypeCollectionView.reloadData()
        }
        
        serviceChannelsVM.errorMessage.bind {   error in
            guard let error = error else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: error)
        }
    }
    
    //MARK: TODO
    // debit card delivery brd
}


extension ServiceChannelsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return atmTypes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ATMTypeCollectionViewCell.identifier,
            for: indexPath) as? ATMTypeCollectionViewCell
        else { return UICollectionViewCell() }
        if atmTypes[indexPath.row].id == selectedATMTypeId {
            cell.selectedImageBackGround.backgroundColor = UIColor(named: "App Orange")
        }
        else  {
            cell.selectedImageBackGround.backgroundColor = .white
        }
            cell.setupCell(with: atmTypes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedATMTypeId = atmTypes[indexPath.row].id else { return }
        
        if (Int(selectedATMTypeId) == 108608 ||
            Int(selectedATMTypeId) == 108613 ||
            Int(selectedATMTypeId) == 108614 ||
            Int(selectedATMTypeId) == 108618 ||
            Int(selectedATMTypeId) == 108619 ||
            Int(selectedATMTypeId) == 108620 ||
            Int(selectedATMTypeId) == 108621 ||
            Int(selectedATMTypeId) == 108622 ||
            Int(selectedATMTypeId) == 108623) {
            //Visa Card Visible dropdown show
            viewReason.isHidden = false
            
        } else {
            //Hide dropdown
            viewReason.isHidden = true
        }
        
        
        self.selectedATMTypeId = selectedATMTypeId
        serviceChannelsVM.setSelectedATMTypeID(accountVariantID: selectedATMTypeId)
        modelRegistrationSteper.serviceChannelsVM = serviceChannelsVM
        collectionView.reloadData()
    }
}
