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
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        reviewDetailsViewModel.openConfirmationVC()
    }
    
    //MARK: TODO
    //declaration check boxes popup
}

extension ReviewDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consumers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewDetailsCell", for: indexPath) as? ReviewDetailsCell
        cell?.cellDelegate = self
        cell?.setupCell(with: consumers[indexPath.row])
        
        return cell ?? UITableViewCell()
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
