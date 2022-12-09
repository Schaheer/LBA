//
//  SelectPreferredAccountVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 17/03/2022.
//

import UIKit
import BetterSegmentedControl
import DropDown
import Alamofire
import ObjectMapper

final class SelectPreferredAccountVC: UIViewController {
    
    @IBOutlet weak var imageViewDropDown: UIImageView!
    @IBOutlet weak var buttonGender: UIButton!
    @IBOutlet weak var viewGenderBackGround: UIView!
    @IBOutlet weak var labelGender: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currencyPopupViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    private var accounts = [CodeTypeDataModel]()
    private var yesAccounts = [CodeTypeDataModel]()
    private var noAccounts = [CodeTypeDataModel]()
    var cellTemp: SelectPreferredAccountCell?

    var isEditFromViewController = ""
    var isEditFromReviewDetailsViewController = false
    
    private var proofOfIncomeInd: Int {
        return selectPreferredAccountViewModel.getProofOfIncomeInd()
    }
    
//    private let preferredAccounts = [
//        PreferredAccount(
//            type: "Asaan Digital Account",
//            description: "• Maximum credit balance limit PKR 1,000,000\n\n• Maximum Debit balance limit PKR 1,000,000\n\n• Currency PKR",
//            checkUncheckIcon: UIImage(named: "uncheck-icon")!,
//            id: .asaanDigitalAccount
//        ),
//        PreferredAccount(
//
//            type: "Freelancer Digital Account",
//            description: "• Maximum limit (credit and debit) USD 5,000 or equivalent\n\n• Currency PKR & USD\n\n• Cash withdrawal limit PKR 500,000 or equivalent per day",
//            checkUncheckIcon: UIImage(named: "uncheck-icon")!,
//            id: .freelancerDigitalAccount
//        ),
//        PreferredAccount(
//            type: "Asaan Digital Remittance Account",
//            description: "• Maximum credit balance limit PKR 3,000,000\n\n• Fund transfer limit of PKR 500,000 per day\n\n• No commercial remittance\n\n• Currency PKR\n\n• Cash withdrawal limit PKR 500,000 per day",
//            checkUncheckIcon: UIImage(named: "uncheck-icon")!,
//            id: .asaanDigitalRemittanceAccount
//        ),
//        PreferredAccount(
//            type: "Current Account",
//            description: "• Allied Bank Current Account offers a host of free services on maintaining a monthly average balance of Rs.250,000/- & above.\n\n•Free of cost issuance of first cheque book of 10 leaves\n\n•Free Online Balance Enquiry",
//            checkUncheckIcon: UIImage(named: "uncheck-icon")!,
//            id: .currentAccount
//        )
//    ]

    private var selectPreferredAccountViewModel = SelectPreferredAccountViewModel()
    var selectedAccountTypeId: Double?
    var selectedBankingMode: BankingMethod?
    lazy var currencyPopupViewHeight: CGFloat = 396

    override func viewDidLoad() {
        super.viewDidLoad()
        viewGenderBackGround.borderColor = .lightGray
        viewGenderBackGround.borderWidth = 1
        viewGenderBackGround.cornerRadius = 4
//        tableView.delegate = self
//        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        selectPreferredAccountViewModel.setProofOfIncomeInd(proofOfIncome: 0)
        subscribeViewModel()
        getAllAccounts()
        getGenderList()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoadLocal()
    }
    
    override func viewDidLayoutSubviews() {
        setupViews()
    }
    
    @IBAction func buttonGender(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = viewGenderBackGround // UIView or UIBarButtonItem
        dropDown.direction = .any
        dropDown.width = viewGenderBackGround.frame.width
        
        var allGenders = self.genderList.map{
            ($0 as! [String: Any])["name"]
        } as! [String]
        dropDown.dataSource = allGenders
        dropDown.selectionAction = {(index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.labelGender.text = item
            self.labelGender.textColor = .black
            modelRegistrationSteper.gender = item
            let temp = self.genderList[index] as! [String: Any]
            let tempGenderId = (temp["id"] as! Double).toInt()
            modelRegistrationSteper.genderId = tempGenderId!
            print(modelRegistrationSteper.genderId)
            self.yesAccounts.removeAll()
            self.noAccounts.removeAll()
            self.filterAccounts()
            self.collectionView.reloadData()
        }
        dropDown.show()
    }
    
    func viewDidLoadLocal() {
        if modelRegistrationSteper.selectPreferredAccountViewModel != nil {
            selectPreferredAccountViewModel.resetAccountVariantID()
            yesAccounts.removeAll()
            noAccounts.removeAll()
//            self.selectPreferredAccountViewModel
            
            let viewModel = modelRegistrationSteper.selectPreferredAccountViewModel!
            labelGender.text = modelRegistrationSteper.gender
            labelGender.textColor = .black
            
            let accountVariantID = viewModel.getAccountVariantID()
            let id: Double = accountVariantID.id
            let accountVariant = AccountVariant(rawValue: id) ?? .unknown
            selectPreferredAccountViewModel.setAccountVariantID(accountVariantID: accountVariant)
            filterAccounts()
            let proofOfIncome = viewModel.getProofOfIncomeInd()
            if proofOfIncome == 0 {
                noTapped()
            }
            else {
                yesTapped()
            }
            var foundRow = 0
            if proofOfIncome == 1 {
                var index = 0
                yesAccounts.forEach { account in
                    print(account.id!)
                    if account.id == id {
                        foundRow = index
                    }
                    index += 1
                }
            }
            else {
                var index = 0
                noAccounts.forEach { account in
                    print(account.id!)
                    if account.id == id {
                        foundRow = index
                    }
                    index += 1
                }
            }
            collectionView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                print(foundRow)
                self.cellTemp = self.collectionView.cellForItem(at: IndexPath(item: foundRow, section: 0)) as? SelectPreferredAccountCell
                if self.cellTemp == nil {
                    return
                }
                self.cellTemp?.isSelected = true
                viewModel.accountVariantID.bind { [weak self]  accVariantId in
                    switch accVariantId?.currency{
                    case .PKR:
                        //set currency to PKR
                        self?.showCurrencyPopup(flag: false)
                    case .USD:
                        //set currency to PKR
                        self?.showCurrencyPopup(flag: false)
                    case .All:
                        //set currency Accordingly
                        self?.showCurrencyPopup(flag: true)
                    default:
                        self?.showCurrencyPopup(flag: true)
                    }
                }
            }
        }
    }
    
    private func setupViews(){
        showCurrencyPopup(flag: false)
    }
    
    private func getAllAccounts(){
        
        var codeOrder = 1
        var bankingMode = "C"
        if selectedAccountTypeId == AccountType.current.code{
            codeOrder = 1
        }else {
            codeOrder = 2
        }

        if selectedBankingMode == .conventional {
            bankingMode = "C"
        }else {
            bankingMode = "I"
        }
        
        selectPreferredAccountViewModel.getAllAccounts(
            codeTypeID: BaseConstants.Config.allAccountsLookupID,
            codeDescription: bankingMode,
            codeOrder: codeOrder
        )
    }
    
    @IBAction func yesTapped(_ sender: UIButton) {
        yesTapped()
    }
    
    func yesTapped() {
        yesButton.backgroundColor = PluginColorAsset.alliedBlue.color
        yesButton.tintColor = .white
        yesButton.borderColor = .clear
        yesButton.borderWidth = 0
        
        noButton.backgroundColor = .clear
        noButton.tintColor = PluginColorAsset.appCTABlue.color
        noButton.borderColor = PluginColorAsset.appCTABlue.color
        noButton.borderWidth = 1
        selectPreferredAccountViewModel.setProofOfIncomeInd(proofOfIncome: 1)
        collectionView.reloadData()
//        if !isViewWillAppear {
//            selectPreferredAccountViewModel.resetAccountVariantID()
//        }
        
    }
    
    @IBAction func noTapped(_ sender: UIButton) {
        noTapped()
    }
    
    func noTapped() {
        noButton.backgroundColor = PluginColorAsset.alliedBlue.color
        noButton.tintColor = .white
        noButton.borderColor = .clear
        noButton.borderWidth = 0
        
        yesButton.backgroundColor = .clear
        yesButton.tintColor = PluginColorAsset.appCTABlue.color
        yesButton.borderColor = PluginColorAsset.appCTABlue.color
        yesButton.borderWidth = 1
        selectPreferredAccountViewModel.setProofOfIncomeInd(proofOfIncome: 0)
        collectionView.reloadData()
//        if !isViewWillAppear {
//            selectPreferredAccountViewModel.resetAccountVariantID()
//        }
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if labelGender.text?.lowercased() == "select gender" {
            self.showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: "Please select gender")
            return()
        }
        let proofOfIncomeInd = selectPreferredAccountViewModel.getProofOfIncomeInd()
        let accountVariantID = selectPreferredAccountViewModel.getAccountVariantID()
        modelRegistrationSteper.proofOfIncomeInd = proofOfIncomeInd
        if proofOfIncomeInd != 2 && accountVariantID.id != 0 {
            if let registerVerifyOTPResponse = DataCacheManager.shared.loadRegisterVerifyOTPResponse() {
                let consumer = registerVerifyOTPResponse.consumerList?.first
                
                selectPreferredAccountViewModel.registerConsumerAccountInfo(
                    rdaCustomerAccInfoID: consumer?.accountInformation?.rdaCustomerAccInfoID,
                    rdaCustomerID: consumer?.accountInformation?.rdaCustomerID,
                    bankingModeID: consumer?.accountInformation?.bankingModeID,
                    customerAccountTypeID: selectedAccountTypeId,
                    customerBranch: consumer?.customerBranch,
                    customerTypeID: BaseConstants.Config.customerTypeID,
                    proofOfIncomeInd: proofOfIncomeInd,
                    accountVariantID: accountVariantID.id,
                    genderId: Int(modelRegistrationSteper.genderId)
                )
            } else if let registerConsumerAccountInfoResponse = DataCacheManager.shared.loadRegisterConsumerAccountInfoResponse() {
                
                let consumer = registerConsumerAccountInfoResponse.data
                
                selectPreferredAccountViewModel.registerConsumerAccountInfo(
                    rdaCustomerAccInfoID: consumer?.rdaCustomerAccInfoID,
                    rdaCustomerID: consumer?.rdaCustomerID,
                    bankingModeID: consumer?.bankingModeID,
                    customerAccountTypeID: selectedAccountTypeId,
                    customerBranch: consumer?.customerBranch,
                    customerTypeID: BaseConstants.Config.customerTypeID,
                    proofOfIncomeInd: proofOfIncomeInd,
                    accountVariantID: accountVariantID.id,
                    genderId: modelRegistrationSteper.genderId
                )
            }
        } else {
            AlertManager.shared.showOKAlert(with: "Error", message: "Please select an account type")
        }
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    private func openPersonalInformationBaseVC() {
        guard let personalInformationBaseVC = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC else { return }
        print(selectPreferredAccountViewModel.getAccountVariantID())
        switch selectPreferredAccountViewModel.getAccountVariantID(){
        case .asaanDigitalAccount:
            personalInformationBaseVC.firstChild = .personalInfoSecondVC
        case .asaanDigitalRemittanceAccount:
            personalInformationBaseVC.firstChild = .taxResidentDetailVC
        case .freelancerDigitalAccount:
            personalInformationBaseVC.firstChild = .taxResidentDetailVC
//            personalInformationBaseVC.firstChild = .taxResidentailDetailVC
        case .currentAccount:
            personalInformationBaseVC.firstChild = .personalInfoSecondVC
        default:
            personalInformationBaseVC.firstChild = .personalInfoSecondVC
//            logsManager.debug("Default case")
        }
        self.navigationController?.pushViewController(personalInformationBaseVC, animated: true)
    }
    
    private(set) var genderList = [Any]()
    var GENDER_LOOKUP = 1006;
    private func getGenderList() {
        guard
            let mobileNetworkInput = OccupationsListInputModel(codeTypeID: GENDER_LOOKUP)
        else { return }
        
        APIManager.shared.getOccupationsList(input: mobileNetworkInput) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let object):
                let responseModel = object as? BaseResponseModel
                self.genderList = responseModel?.dictionaryRepresentation()["data"] as! [Any]
                print(self.genderList)

            case .failure(let error):
                break
//                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    private func subscribeViewModel() {
        selectPreferredAccountViewModel.accountVariantID.bind { [weak self] accVariantId in
            switch accVariantId?.currency{
            case .PKR:
                //set currency to PKR
                self?.showCurrencyPopup(flag: false)
            case .USD:
                //set currency to PKR
                self?.showCurrencyPopup(flag: false)
            case .All:
                //set currency Accordingly
                self?.showCurrencyPopup(flag: true)
            default:
                self?.showCurrencyPopup(flag: true)
            }
        }
        
        selectPreferredAccountViewModel.allAccounts.bind { [weak self] allAccounts in
            guard let self = self, let accounts = allAccounts?.data else { return }
            self.accounts = accounts
            self.filterAccounts()
            self.collectionView.reloadData()
        }
        
        selectPreferredAccountViewModel.routeToPersonalInformationVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            //Shakeel
            self.selectPreferredAccountViewModel.addGender()
            self.openPersonalInformationBaseVC()
        }
        
        selectPreferredAccountViewModel.registerConsumerAccountInfoResponse.bind { [weak self] response in
            guard let self = self, let response = response else { return }
            DataCacheManager.shared.saveRegisterConsumerAccountInfoResponse(input: response)
            guard let selectedAccountedType = self.selectPreferredAccountViewModel.accountVariantID.value else { return }
            DataCacheManager.shared.saveAccountTypeInfo(input: selectedAccountedType.id)
            modelRegistrationSteper.selectPreferredAccountViewModel = self.selectPreferredAccountViewModel
            //Shakeel
            if self.isEditFromReviewDetailsViewController && self.isEditFromViewController == "SelectBankingMethodVC" {
                self.dismissToViewController(viewController: ReviewDetailsVC.self)
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name("NotificationIdentifierRefreshReviewDetailsVC"), object: nil)
                }
            }
            else {
                self.selectPreferredAccountViewModel.openPersonalInformationVC()
            }
        }
    }
    
    func showCurrencyPopup(flag: Bool){
        if flag{
            currencyPopupViewHeightConstraint.constant = currencyPopupViewHeight
        }else {
            currencyPopupViewHeightConstraint.constant = 0
        }
        
    }
    
    private func filterAccounts() {
//        let proofOfIncomeInd = self.selectPreferredAccountViewModel.getProofOfIncomeInd()
//
//        if proofOfIncomeInd == 0 {
//            let yesAccounts = AccountVariant.filter(by: .yes)
//            yesAccounts.forEach { account in
//                if let yesAccount = accounts.first(where: { $0.id ?? 0 == account.id }) {
//                    self.accounts.append(yesAccount)
//                }
//            }
//        } else {
//            let noAccounts = AccountVariant.filter(by: .no)
//            noAccounts.forEach { account in
//                if let noAccount = accounts.first(where: { $0.id ?? 0 == account.id }) {
//                    self.accounts.append(noAccount)
//                }
//            }
//        }
        if yesAccounts.count == 0 {
            let yesAccountsTemp = AccountVariant.filter(by: .yes)
            yesAccountsTemp.forEach { account in
                print(account)
                if let yesAccount = accounts.first(where: { $0.id ?? 0 == account.id }) {
                    if modelRegistrationSteper.genderId == 100601 {
                        let arrayName = yesAccount.name?.components(separatedBy: " ")
                        print(arrayName)
                        if arrayName!.contains("Khanum") {
                            print(arrayName)
                        }
                        else {
                            self.yesAccounts.append(yesAccount)
                        }
                    }
                    else {
                        self.yesAccounts.append(yesAccount)
                    }
                }
            }
        }
        
        if noAccounts.count == 0 {
            let noAccountsTemp = AccountVariant.filter(by: .no)
            noAccountsTemp.forEach { account in
                print(account)
                if let noAccount = accounts.first(where: { $0.id ?? 0 == account.id }) {
                    if modelRegistrationSteper.genderId == 100601 {
                        let arrayName = noAccount.name?.components(separatedBy: " ")
                        print(arrayName)
                        if arrayName!.contains("Khanum") {
                            print(arrayName)
                        }
                        else {
                            self.noAccounts.append(noAccount)
                        }
                    }
                    else {
                        self.noAccounts.append(noAccount)
                    }
                }
            }
        }
    }
}

//extension SelectPreferredAccountVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return preferredAccounts.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(
//            withIdentifier: "SelectPreferredAccountCell",
//            for: indexPath
//        ) as? SelectPreferredAccountCell else { return UITableViewCell() }
//
//        cell.setupCell(with: preferredAccounts[indexPath.row])
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if preferredAccounts[indexPath.row].id != 108243 {
//            AlertManager.shared.showOKAlert(with: "Error", message: "Account not available yet")
//        } else {
//            let id = preferredAccounts[indexPath.row].id
//            selectPreferredAccountViewModel.setAccountVariantID(accountVariantID: id)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 160
//    }
//}

extension SelectPreferredAccountVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let proofOfIncomeInd = selectPreferredAccountViewModel.getProofOfIncomeInd()
        if proofOfIncomeInd == 1 {
            return yesAccounts.count
        }
        return noAccounts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SelectPreferredAccountCell",
            for: indexPath) as? SelectPreferredAccountCell
        else { return UICollectionViewCell() }

//        let proofOfIncomeInd = selectPreferredAccountViewModel.getProofOfIncomeInd()
        if proofOfIncomeInd == 1 {
            cell.setupCell(with: yesAccounts[indexPath.row])
        } else {
            cell.setupCell(with: noAccounts[indexPath.row])
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if cellTemp != nil {
            cellTemp?.isSelected = false
            cellTemp = nil
        }
        
        var id: Double = 0
        var accountVariant: AccountVariant = .unknown
        
//        let proofOfIncomeInd = selectPreferredAccountViewModel.getProofOfIncomeInd()
        if proofOfIncomeInd == 1 {
            id = yesAccounts[indexPath.row].id ?? 0
            accountVariant = AccountVariant(rawValue: id) ?? .unknown
        } else {
            id = noAccounts[indexPath.row].id ?? 0
            accountVariant = AccountVariant(rawValue: id) ?? .unknown
        }
        
//        if id == 108243 {
        
        selectPreferredAccountViewModel.setAccountVariantID(accountVariantID: accountVariant)

//        } else {
//            AlertManager.shared.showOKAlert(with: "Error", message: "Account not available yet")
//            selectPreferredAccountViewModel.setAccountVariantID(accountVariantID: id)
//        }

    }
}

extension Double {
    
    func toInt() -> Int? {
        let roundedValue = rounded(.toNearestOrEven)
        return Int(exactly: roundedValue)
    }
    
}
