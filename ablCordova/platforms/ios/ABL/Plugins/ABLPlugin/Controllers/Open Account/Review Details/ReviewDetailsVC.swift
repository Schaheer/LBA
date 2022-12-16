//
//  ReviewDetailsVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 13/04/2022.
//

import UIKit

final class ReviewDetailsVC: UIViewController {
    
//    @IBOutlet weak var bankingModeLabel: UILabel!
//    @IBOutlet weak var branchLabel: UILabel!
//    @IBOutlet weak var accountTypeLabel: UILabel!
//    @IBOutlet weak var currencyLabel: UILabel!
//    @IBOutlet weak var accountLabel: UILabel!
//    @IBOutlet weak var natureOfAccountLabel: UILabel!
//    @IBOutlet weak var mobileNumberLabel: UILabel!
//    @IBOutlet weak var cnicLabel: UILabel!
//    @IBOutlet weak var dateOfBirthLabel: UILabel!
//    @IBOutlet weak var cnicDateOfIssueLabel: UILabel!
//    @IBOutlet weak var cnicDateOfExpiryLabel: UILabel!
//    @IBOutlet weak var motherNameLabel: UILabel!
//    @IBOutlet weak var countryLabel: UILabel!
//    @IBOutlet weak var purposeOfAccountLabel: UILabel!
//    @IBOutlet weak var proofOfIncomeLabel: UILabel!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var fullNameLabel: UILabel!
//    @IBOutlet weak var genderLabel: UILabel!
//    @IBOutlet weak var placeOfBirthLabel: UILabel!
//    @IBOutlet weak var fatherHusbandName: UILabel!
//    @IBOutlet weak var professionLabel: UILabel!
//    @IBOutlet weak var occupationLabel: UILabel!
//    @IBOutlet weak var expectedSalaryLabel: UILabel!
//    @IBOutlet weak var addressLabel: UILabel!
//    @IBOutlet weak var nearestLandmarkLabel: UILabel!
//    @IBOutlet weak var tehsilTownLabel: UILabel!
//    @IBOutlet weak var cityLabel: UILabel!
//    @IBOutlet weak var currentCountryLabel: UILabel!
//    @IBOutlet weak var emailAddressLabel: UILabel!
//    @IBOutlet weak var debitCardLabel: UILabel!
//    @IBOutlet weak var chequeBookLabel: UILabel!
//    @IBOutlet weak var transactionAlertsLabel: UILabel!
//    @IBOutlet weak var cnicFrontImageView: UIImageView!
//    @IBOutlet weak var cnicBackImageView: UIImageView!
//    @IBOutlet weak var signatureImageView: UIImageView!
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    private let reviewDetailsViewModel = ReviewDetailsViewModel()
    private var consumers = [ConsumerListResponseModel]()
    
    var TCCheckBoxChecked: Bool = false
    var declarationCheckBoxChecked: Bool = false
    var keyFactStatementCheckBoxChecked: Bool = false
    
    private var selectPreferredAccountViewModel = SelectPreferredAccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeViewModel()
        getConsumerAccountDetails()
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.estimatedRowHeight = 3000
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationIdentifierRefreshReviewDetailsVC(notification:)), name: Notification.Name("NotificationIdentifierRefreshReviewDetailsVC"), object: nil)

    }
    
    @objc func notificationIdentifierRefreshReviewDetailsVC(notification: Notification) {
        getConsumerAccountDetails()
    }


    
    private func openConfirmationVC() {
        guard let confirmationVC = UIStoryboard.initialize(
            viewController: .confirmationVC,
            fromStoryboard: .openAccount
        ) as? ConfirmationVC else { return }
        
        navigationController?.pushViewController(confirmationVC, animated: true)
    }
    
    private func subscribeViewModel() {
        reviewDetailsViewModel.consumerAccountDetail.bind { [weak self] response in
            guard let self = self, let response = response, let consumers = response.consumerList else { return }
            
            self.consumers = consumers
            DataCacheManager.shared.saveRegisterVerifyOTPResponse(input: response)
            
            self.detailsTableView.reloadData()
        }
        
        reviewDetailsViewModel.routeToConfirmationVC.bind { [weak self] shouldRoute in
            guard let self = self, shouldRoute else { return }
            self.openConfirmationVC()
        }
    }
    
    private func getConsumerAccountDetails() {
        guard
            let consumerAccountDetails = DataCacheManager.shared.loadRegisterVerifyOTPResponse()
        else { return }
        
        let consumer = consumerAccountDetails.consumerList?.first
        reviewDetailsViewModel.getConsumerAccountDetail(
            rdaCustomerProfileID: consumer?.rdaCustomerProfileID,
            rdaCustomerAccInfoID: consumer?.accountInformation?.rdaCustomerAccInfoID,
            customerTypeID: BaseConstants.Config.customerTypeID
        )
    }
    
//    private func populateDetails(with consumer: ConsumerListResponseModel) {
//        bankingModeLabel.text = BankingMethod.getDescription(for: consumer.accountInformation?.bankingModeID ?? 0)
//        branchLabel.text = consumer.customerBranch ?? "N/A"
//        accountTypeLabel.text = AccountType.getDescription(for: consumer.accountInformation?.customerAccountTypeID ?? 0)
//        currencyLabel.text = consumer.accountInformation?.currencyType ?? "N/A"
//        // Accout type here
//        // Nature of account
//        mobileNumberLabel.text = consumer.mobileNo ?? "N/A"
//        cnicLabel.text = consumer.idNumber ?? "N/A"
//        dateOfBirthLabel.text = consumer.dateOfBirth ?? "N/A"
//        cnicDateOfIssueLabel.text = consumer.dateOfIssue ?? "N/A"
//        motherNameLabel.text = consumer.motherMaidenName ?? "N/A"
//        // Country here
//        purposeOfAccountLabel.text = consumer.accountInformation?.purposeOfAccount ?? "N/A"
//        proofOfIncomeLabel.text = consumer.accountInformation?.proofOfIncomeInd == false ? "0" : "1"
//        titleLabel.text = consumer.customerTitle ?? "N/A"
//        fullNameLabel.text = consumer.fullName ?? "N/A"
//        genderLabel.text = consumer.gender ?? "N/A"
//        placeOfBirthLabel.text = consumer.cityOfBirth ?? "N/A"
//        fatherHusbandName.text = consumer.fatherHusbandName ?? "N/A"
//        professionLabel.text = consumer.profession ?? "N/A"
//        occupationLabel.text = consumer.occupation ?? "N/A"
//        expectedSalaryLabel.text = consumer.accountInformation?.averageMonthlySalary ?? "N/A"
//        addressLabel.text = consumer.addresses?.first?.customerAddress ?? "N/A"
//        tehsilTownLabel.text = consumer.addresses?.first?.customerTown ?? "N/A"
//        cityLabel.text = consumer.addresses?.first?.city ?? "N/A"
//        currentCountryLabel.text = consumer.addresses?.first?.country ?? "N/A"
//        emailAddressLabel.text = consumer.emailAddress ?? "N/A"
//        debitCardLabel.text = consumer.accountInformation?.atmType ?? "N/A"
//        chequeBookLabel.text = consumer.accountInformation?.chequeBookReqInd == false ? "No" : "Yes"
//        transactionAlertsLabel.text = consumer.accountInformation?.transAlertInd == false ? "No" : "Yes"
//
//        let cnicFront = consumer.attachments?.first?.base64Content ?? ""
//        let cnicBack = consumer.attachments?.last?.base64Content ?? ""
//
//        cnicFrontImageView.image = UIImage(data: Data(base64Encoded: cnicFront) ?? Data())
//        cnicBackImageView.image = UIImage(data: Data(base64Encoded: cnicBack) ?? Data())
    
//    }
    
    func getKfsUrl() -> String {
        print(selectPreferredAccountViewModel.getAccountVariantID())
        
        var kfsUrl: String = ""
        let accountVariant: Double = selectPreferredAccountViewModel.getAccountVariantID().rawValue
        
        if (accountVariant == 108203) {
            kfsUrl = "assets/docs/KFS-Allied-Business-AC.pdf";
        } else if (accountVariant == 108238) {
            kfsUrl = "assets/docs/KFS-Allied-Khanum-AC-1.pdf";
        } else if (accountVariant == 108211) {
            kfsUrl = "assets/docs/KFS-Allied-Platinum-Rewarding-Profit-AC.pdf";
        } else if (accountVariant == 108242) {
            kfsUrl = "assets/docs/KFS-Allied-Senior-Citizen.pdf";
        } else if (accountVariant == 108214) {
            kfsUrl = "assets/docs/KFS-Allied-Youth-Account.pdf";
        } else if (accountVariant == 108212) {
            kfsUrl = "assets/docs/KFS-Current-AC.pdf";
        } else if (accountVariant == 108217) {
            kfsUrl = "assets/docs/KFS-Saving-AC.pdf";
        } else if (accountVariant == 108205) {
            kfsUrl = "assets/docs/KFS-Allied-Express-AC.pdf";
        } else if (accountVariant == 108220) {
            kfsUrl = "assets/docs/1.-KFS-LCY-Current-Accounts-JAN-JUNE-2022.pdf";
        } else if (accountVariant == 108224) {
            kfsUrl = "assets/docs/2.-KFS-LCY-Saving-Accounts-Individuals-and-Entities-JAN-JUNE-2022.pdf";
        } else if (accountVariant == 108237) {
            kfsUrl = "assets/docs/10.-KFS-FCY-Current-and-Saving-Accounts-JAN-JUNE-2022.pdf";
        } else if (accountVariant == 108216) {
            kfsUrl = "assets/docs/KFS-Allied-Khanum-AC-1.pdf";
        } else if (accountVariant == 108240) {
            kfsUrl = "assets/docs/KFS-Allied-Khanum-AC-1.pdf";
        } else if (accountVariant == 108241) {
            kfsUrl = "assets/docs/KFS-Allied-Khanum-AC-1.pdf";
        } else if (accountVariant == 108238) {
            kfsUrl = "assets/docs/KFS-Allied-Khanum-AC-1.pdf";
        } else if (accountVariant == 108206) {
            kfsUrl = "assets/docs/KFS-Allied-Senior-Citizen.pdf";
        } else if (accountVariant == 108207) {
            kfsUrl = "assets/docs/KFS-Allied-Senior-Citizen.pdf";
        } else if (accountVariant == 108239) {
            kfsUrl = "assets/docs/KFS-Allied-Senior-Citizen.pdf";
        } else if (accountVariant == 108208) {
            kfsUrl = "assets/docs/KFS-Allied-Youth-Account.pdf";
        } else if (accountVariant == 108209) {
            kfsUrl = "assets/docs/KFS-Allied-Youth-Account.pdf";
        } else if (accountVariant == 108213) {
            kfsUrl = "assets/docs/KFS-Allied-Youth-Account.pdf";
        } else if (accountVariant == 108201) {
            kfsUrl = "assets/docs/KFS-Current-AC.pdf";
        } else if (accountVariant == 108204) {
            kfsUrl = "assets/docs/KFS-Current-AC.pdf";
        } else if (accountVariant == 108210) {
            kfsUrl = "assets/docs/KFS-Saving-AC.pdf";
        } else if (accountVariant == 108215) {
            kfsUrl = "assets/docs/KFS-Saving-AC.pdf";
        } else if (accountVariant == 108217) {
            kfsUrl = "assets/docs/KFS-Saving-AC.pdf";
        } else if (accountVariant == 108218) {
            kfsUrl = "assets/docs/1.-KFS-LCY-Current-Accounts-JULY-DEC-2022-DH-reviewed.pdf";
        } else if (accountVariant == 108222) {
            kfsUrl = "assets/docs/2.a.-KFS-LCY-Saving-Accounts-Individuals-and-Entities-JULY-DEC-2022DH-reviewed.pdf";
        } else if (accountVariant == 108225) {
            kfsUrl = "assets/docs/3.-KFS-LCY-Saving-Accounts-Specialized-products-JULY-DEC-2022-DH-reviewed.pdf";
        } else if (accountVariant == 108226) {
            kfsUrl = "assets/docs/2.a.-KFS-LCY-Saving-Accounts-Individuals-and-Entities-JULY-DEC-2022DH-reviewed.pdf";
        } else if (accountVariant == 108228) {
            kfsUrl = "assets/docs/3.a-KFS-LCY-Saving-Accounts-Specialized-products-JULY-DEC-2022-DH-Reviewed.pdf";
        } else if (accountVariant == 108230) {
            kfsUrl = "assets/docs/3.a-KFS-LCY-Saving-Accounts-Specialized-products-JULY-DEC-2022-DH-Reviewed.pdf";
        } else if (accountVariant == 108231) {
            kfsUrl = "assets/docs/3.a-KFS-LCY-Saving-Accounts-Specialized-products-JULY-DEC-2022-DH-Reviewed.pdf";
        } else if (accountVariant == 108234) {
            kfsUrl = "assets/docs/KFS-Current-AC-FCY.pdf";
        } else if (accountVariant == 108235) {
            kfsUrl = "assets/docs/10.-KFS-FCY-Current-and-Saving-Accounts-JULY-DEC-2022-DH-reviewed.pdf";
        } else if (accountVariant == 108236) {
            kfsUrl = "assets/docs/KFS-Saving-AC.pdf";
        } else if (accountVariant == 108243) {
            kfsUrl = "assets/docs/KFS-Asaan-Digital-Account";
        } else if (accountVariant == 108244) {
            kfsUrl = "assets/docs/KFS-Asaan-Digital-Remittance-Account";
        } else if (accountVariant == 108245) {
            kfsUrl = "assets/docs/KFS-Freelancer-Digital-Account";
        } else if (accountVariant == 108246) {
            kfsUrl = "assets/docs/KFS-Allied-Aitebar-Freelancer-Digital-Account-(PKR & FCY)-JULY-DEC 2022";
        } else if (accountVariant == 108247) {
            kfsUrl = "assets/docs/23.KFS-Allied-Islamic-Asaan-Digital-Account-JULY-DEC-2022";
        } else if (accountVariant == 108248) {
            kfsUrl = "assets/docs/KFS-Allied-Aitebar-Asaan-Digital-Remittance-Account-JULY-DEC-2022";
        } else if (accountVariant == 108249) {
            kfsUrl = "assets/docs/KFS-Freelancer-Digital-Account";
        } else if (accountVariant == 108250) {
            kfsUrl = "assets/docs/KFS-Allied-Aitebar-Freelancer-Digital-Account-(PKR & FCY)-JULY-DEC 2022";
        } else if (accountVariant == 108251) {
            kfsUrl = "assets/docs/KFS-Asaan-Digital-Account";
        } else if (accountVariant == 108252) {
            kfsUrl = "assets/docs/KFS-Asaan-Digital-Remittance-Account";
        } else if (accountVariant == 108253) {
            kfsUrl = "assets/docs/KFS-Freelancer-Digital-Saving-Account";
        }

        return BaseConstants.BaseURL.value() + "/consumer-portal/" + kfsUrl
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        if TCCheckBoxChecked == false {
            self.showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: "Please accept Terms & Conditions")
            
            return
        } else if declarationCheckBoxChecked == false {
            self.showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: "Please accept Declaration")
            
            return
        } else if keyFactStatementCheckBoxChecked == false {
            self.showAlertSuccessWithPopToVC(viewController: self, title: "Error", message: "Please accept KFS")
            
            return
        }
            
        reviewDetailsViewModel.openConfirmationVC()
    }
    
    //MARK: TODO
    //declaration check boxes popup
}

extension ReviewDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return consumers.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewDetailsCell", for: indexPath) as? ReviewDetailsCell
            cell?.cellDelegate = self
            cell?.setupCell(with: consumers[indexPath.row])
            
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as? ChatCell
            
            cell?.setTermsCheckBox(with: false)
            cell?.setDeclarationCheckBox(with: false)
            cell?.setKeyFactStatementCheckBox(with: false)
            
            cell?.TNCBlock = { [weak self] in
                if self?.TCCheckBoxChecked == false {
                    self?.showWebView(with: .termsNConditions, url: BaseConstants.BaseURL.value() + "/abl-rda/terms/pda-terms.html") { [weak self] in
                        DispatchQueue.main.async {
                            self?.TCCheckBoxChecked = true
                            cell?.setTermsCheckBox(with: true)
                        }
                    }
                } else {
                    self?.TCCheckBoxChecked = false
                    cell?.setTermsCheckBox(with: false)
                }
            }
            
            cell?.declarationBlock = { [weak self] in
                if self?.declarationCheckBoxChecked == false {
                    self?.showWebView(with: .declaration, url: nil, htmlString: "<h1>• I / We hereby confirm my residency/ non-residency status as per the Income Tax Ordinance 2001 under Chapter-V, Division II \"Resident and Non-Resident Persons\". <br><br> • I / We hereby confirm that funds to be invested / used through this account will be my own / dependent family members / spouse funds and also confirm that funds beneficially owned by any other person will not be invested/used through this account. If the funds are not beneficially owned by me/us or my/our dependent family members, the same will be intimated to the bank.<br><br>• I / We hereby allow the Bank to open my account digitally and bank is also allowed to use my / our information/documents for all due diligence and supervisory functions. <br><br>• I / We declare that I / we have neither asked for, nor received, any advice from the Bank in determining my classification as a Reportable person or otherwise. I / We further declare that I / we have neither asked for nor received, any advice in relation to concealing from the Bank anything that would affect my / our classification as a foreign person. <br><br>• I / We agree to indemnify the Bank from any loss, claim, damages or liability arising or incurred by the bank in discharging its obligations under FATCA and CRS or as result of disclosure of account related information to U.S. or other Tax Authorities. <br><br>• I / We acknowledge downloading / received copy of Account Opening information as well as copy of the Terms &amp; Conditions. I / We declare and confirm that I / we have read / been read before me / us and understood the Terms &amp; Conditions governing the Account, Digital Account opening, transaction through digital channels and agree to observe and be bound by the said Terms &amp; Conditions and any changes, supplements or modifications thereto that may be made by the Bank from time to time. <br><br>• Where required by domestic or overseas regulations or tax authorities, I / we consent and agree that the Bank may withhold from my / our account(s) such amount as may be required according to applicable laws, regulations and directives. <br><br>• I / We explicitly provide my / our consent to share my / our KYC / CDD information with CDC and will ensure compliance to applicable laws, rules &amp; regulations. <br><br>• I hereby declare that whole information provided to the Bank is correct and true in all respects. Further source of income declared above is also correct and legitimate.</h1>") { [weak self] in
                        self?.declarationCheckBoxChecked = true
                        cell?.setDeclarationCheckBox(with: true)
                    }
                } else {
                    self?.declarationCheckBoxChecked = false
                    cell?.setDeclarationCheckBox(with: false)
                }
            }
            
            cell?.keyFactStatementBlock = { [weak self] in
                if self?.keyFactStatementCheckBoxChecked == false {
                    self?.showWebView(with: .keyFactStatement, url: self?.getKfsUrl() ?? "") { [weak self] in
                        self?.keyFactStatementCheckBoxChecked = true
                        cell?.setKeyFactStatementCheckBox(with: true)
                    }
                } else {
                    self?.keyFactStatementCheckBoxChecked = false
                    cell?.setKeyFactStatementCheckBox(with: false)
                }
            }
            
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ReviewDetailsVC: ReviewDetailsCellDelegate {
    func buttonEditNationality() {
        guard let personalInformationBaseVC = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC else { return }
        
        personalInformationBaseVC.firstChild = .nationalityVC
        personalInformationBaseVC.isEditFromReviewDetailsViewController = true
        personalInformationBaseVC.forViewController = "NationalityVC"
        navigationController?.pushViewController(personalInformationBaseVC, animated: true)
    }
    
    func buttonEditFATCA() {
//        guard let personalInformationBaseVC = UIStoryboard.initialize(
//            viewController: .personalInformationBaseVC,
//            fromStoryboard: .openAccount
//        ) as? PersonalInformationBaseVC else { return }
//
//        personalInformationBaseVC.firstChild = .nationalityVC
//        personalInformationBaseVC.isEditFromReviewDetailsViewController = true
//        personalInformationBaseVC.forViewController = "NationalityVC"
//        navigationController?.pushViewController(personalInformationBaseVC, animated: true)
//
        guard let fatcaDetailsViewController = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC else { return }
        fatcaDetailsViewController.firstChild = .fatcaVC
        fatcaDetailsViewController.isEditFromReviewDetailsViewController = true
        fatcaDetailsViewController.forViewController = "FATCADetailsViewController"
        navigationController?.pushViewController(fatcaDetailsViewController, animated: true)
    }
    
    func buttonEditPermanentAddress() {
        guard let personalInformationBaseVC = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC else { return }
        
        personalInformationBaseVC.firstChild = .registerPermanentAddress
        personalInformationBaseVC.isEditFromReviewDetailsViewController = true
        personalInformationBaseVC.forViewController = "RegisterPermanentAddressViewController"
        navigationController?.pushViewController(personalInformationBaseVC, animated: true)
    }
    
    func buttonEditAccountDetails() {
//        dismissToViewController(viewController: SelectBankingMethodVC.self)
        
        guard let selectBankingMethodVC = UIStoryboard.initialize(
            viewController: .selectBankingMethodVC,
            fromStoryboard: .openAccount
        ) as? SelectBankingMethodVC else { return }
        selectBankingMethodVC.isEditFromReviewDetailsViewController = true
        navigationController?.pushViewController(selectBankingMethodVC, animated: true)
    }
    
    func buttonEditYourDetails() {
//        dismissToViewController(viewController: PersonalInformationBaseVC.self)
        guard let personalInformationBaseVC = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC else { return }
        
        personalInformationBaseVC.firstChild = .personalInfoSecondVC
        personalInformationBaseVC.isEditFromReviewDetailsViewController = true
        personalInformationBaseVC.forViewController = "PersonalInformationSecondVC"
        navigationController?.pushViewController(personalInformationBaseVC, animated: true)
    }
    
    func buttonEditCurrentAddress() {
        guard let personalInformationBaseVC = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC else { return }
//        PersonalInformationThirdVC
        personalInformationBaseVC.firstChild = .personalInfoThirdVC
        navigationController?.pushViewController(personalInformationBaseVC, animated: true)
    }
    
    func buttonEditDocuments() {
        
        guard let personalInformationBaseVC = UIStoryboard.initialize(
            viewController: .personalInformationBaseVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationBaseVC else { return }
//        PersonalInformationThirdVC
        personalInformationBaseVC.firstChild = .pictureAndSignVC
        personalInformationBaseVC.isEditFromReviewDetailsViewController = true
        personalInformationBaseVC.forViewController = "ReviewDetailsVC"
        navigationController?.pushViewController(personalInformationBaseVC, animated: true)
    }
}
