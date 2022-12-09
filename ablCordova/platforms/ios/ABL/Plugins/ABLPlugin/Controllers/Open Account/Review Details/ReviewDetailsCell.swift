//
//  ReviewDetailsCell.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 22/04/2022.
//

import UIKit
import BetterSegmentedControl

protocol ReviewDetailsCellDelegate: AnyObject {
    func buttonEditAccountDetails()
    func buttonEditYourDetails()
    func buttonEditCurrentAddress()
    func buttonEditNationality()
    func buttonEditFATCA()
    func buttonEditPermanentAddress()
}
final class ReviewDetailsCell: UITableViewCell {
    
    @IBOutlet weak var bankingModeLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    
    @IBOutlet weak var accountTypeLabel: UILabel!

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var natureOfAccountLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var cnicLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var cnicDateOfIssueLabel: UILabel!
    @IBOutlet weak var cnicDateOfExpiryLabel: UILabel!
    @IBOutlet weak var motherNameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var purposeOfAccountLabel: UILabel!
    @IBOutlet weak var proofOfIncomeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    @IBOutlet weak var fatherHusbandName: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var expectedSalaryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nearestLandmarkLabel: UILabel!
    @IBOutlet weak var tehsilTownLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentCountryLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var debitCardLabel: UILabel!
    @IBOutlet weak var chequeBookLabel: UILabel!
    
    @IBOutlet weak var nationalityLabel: LabelSetting!
    @IBOutlet weak var nationalityCnincLabel: LabelSetting!
    @IBOutlet weak var nationalityCountryLabel: LabelSetting!
    @IBOutlet weak var prAddressLabel: LabelSetting!
    @IBOutlet weak var prTownTehsilLabel: LabelSetting!
    @IBOutlet weak var prNearestLandmarkLabel: LabelSetting!
    @IBOutlet weak var prCityLabel: LabelSetting!
    
    @IBAction func segementUSTaxResident(_ sender: Any) {
    }
    @IBOutlet weak var segementUSTaxResident: BetterSegmentedControl!
    
    @IBAction func segementUSTaxCitizen(_ sender: Any) {
    }
    @IBOutlet weak var segementUSTaxCitizen: BetterSegmentedControl!
    @IBAction func segementMailAddress(_ sender: Any) {
    }
    @IBOutlet weak var segementMailAddress: BetterSegmentedControl!
    
    @IBAction func segementPlaceOfBirth(_ sender: Any) {
    }
    @IBOutlet weak var segementPlaceOfBirth: BetterSegmentedControl!
    
    @IBAction func segementOverSeasTerrotory(_ sender: Any) {
    }
    @IBOutlet weak var segementOverSeasTerrotory: BetterSegmentedControl!
    
    @IBAction func segementPermanentResident(_ sender: Any) {
    }
    @IBOutlet weak var segementPermanentResident: BetterSegmentedControl!
    
    @IBAction func segementGreenCardORPhoneNumber(_ sender: Any) {
    }
    @IBOutlet weak var segementGreenCardORPhoneNumber: BetterSegmentedControl!
    
    @IBOutlet weak var factaTaxResidentLabel: BetterSegmentedControl!
    @IBOutlet weak var factaTaxCitizenLabel: BetterSegmentedControl!
    @IBOutlet weak var factaInCareOfOrHoldLabel: BetterSegmentedControl!
    @IBOutlet weak var factaBirthUSTerritoryLabel: BetterSegmentedControl!
    @IBOutlet weak var factaTransferFundsLabel: BetterSegmentedControl!
    @IBOutlet weak var factaGreenCardHolderLabel: BetterSegmentedControl!
    @IBOutlet weak var factaIssuedAuthLabel: BetterSegmentedControl!
    
    @IBOutlet weak var buttonEditNationality: UIButton!
    @IBAction func buttonEditNationality(_ sender: Any) {
        cellDelegate.buttonEditNationality()
    }
    
    @IBOutlet weak var buttonEditPermanentAddress: UIButton!
    @IBAction func buttonEditPermanentAddress(_ sender: Any) {
        cellDelegate.buttonEditPermanentAddress()
    }
    
    @IBOutlet weak var buttonEditFATCA: UIButton!
    @IBAction func buttonEditFATCA (_ sender: Any) {
        cellDelegate.buttonEditFATCA()
    }
    @IBOutlet weak var buttonEditAccountDetails: UIButton!
    @IBAction func buttonEditAccountDetails(_ sender: Any) {
        cellDelegate.buttonEditAccountDetails()
    }
    @IBOutlet weak var buttonEditYourDetails: UIButton!
    @IBAction func buttonEditYourDetails(_ sender: Any) {
        cellDelegate.buttonEditYourDetails()
    }
    @IBOutlet weak var buttonEditCurrentAddress: UIButton!
    @IBAction func buttonEditCurrentAddress(_ sender: Any) {
        cellDelegate.buttonEditCurrentAddress()
    }
    @IBOutlet weak var buttonEditDetailsTransactions: UIButton!
    @IBAction func buttonEditDetailsTransactions(_ sender: Any) {
    }
    @IBOutlet weak var buttonEditDocuments: UIButton!
    @IBAction func buttonEditDocuments(_ sender: Any) {
    }
    
//    @IBOutlet weak var bankingModetxt: UITextField!
//    @IBOutlet weak var branchtxt: UITextField!
//    @IBOutlet weak var accountTypetxt: UITextField!
//    @IBOutlet weak var currencytxt: UITextField!
//    @IBOutlet weak var accounttxt: UITextField!
//    @IBOutlet weak var labelNatureOfAccount: UILabel!
//    @IBOutlet weak var mobileNumbertxt: UITextField!
//    @IBOutlet weak var labelCnic: UILabel!
//    @IBOutlet weak var dateOfBirthtxt: UITextField!
//    @IBOutlet weak var cnicDateOfIssuetxt: UITextField!


//    @IBOutlet weak var titletxt: UITextField!
//    @IBOutlet weak var fullNametxt: UITextField!
//    @IBOutlet weak var gendertxt: UITextField!
//    @IBOutlet weak var fatherHusbandNametxt: UITextField!
//    @IBOutlet weak var professiontxt: UITextField!
//    @IBOutlet weak var occupationtxt: UITextField!
//    @IBOutlet weak var expectedSalarytxt: UITextField!
//    @IBOutlet weak var addresstxt: UITextField!
//    @IBOutlet weak var nearestLandmarktxt: UITextField!
//    @IBOutlet weak var tehsilTowntxt: UITextField!
//    @IBOutlet weak var citytxt: UITextField!
//    @IBOutlet weak var currentCountrytxt: UITextField!
//    @IBOutlet weak var emailAddresstxt: UITextField!
//    @IBOutlet weak var debitCardtxt: UITextField!
//    @IBOutlet weak var chequeBooktxt: UITextField!
//    @IBOutlet weak var transactionAlertstxt: UITextField!
    
    @IBOutlet weak var transactionAlertsLabel: UILabel!
    @IBOutlet weak var cnicFrontImageView: UIImageView!
    @IBOutlet weak var cnicBackImageView: UIImageView!
    @IBOutlet weak var signatureImageView: UIImageView!
    
    
    @IBOutlet weak var btnSummary: UIButton!
    @IBOutlet weak var btnAccDetail: UIButton!
    @IBOutlet weak var btnYourDetail: UIButton!
    @IBOutlet weak var btnMailingAddress: UIButton!
    @IBOutlet weak var btnDetailsTrans: UIButton!
    
    
    
    var cellDelegate: ReviewDetailsCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fatcaDefaultSetting()
//        bankingModetxt.borderStyle = .none
//        branchtxt.borderStyle = .none
//        accountTypetxt.borderStyle = .none
//        currencytxt.borderStyle = .none
//        accounttxt.borderStyle = .none
//
//        mobileNumbertxt.borderStyle = .none
//
//        dateOfBirthtxt.borderStyle = .none
//        cnicDateOfIssuetxt.borderStyle = .none
//
//        titletxt.borderStyle = .none
//        fullNametxt.borderStyle = .none
//        gendertxt.borderStyle = .none
//        fatherHusbandNametxt.borderStyle = .none
//        professiontxt.borderStyle = .none
//        occupationtxt.borderStyle = .none
//        expectedSalarytxt.borderStyle = .none
//        addresstxt.borderStyle = .none
//        nearestLandmarktxt.borderStyle = .none
//        tehsilTowntxt.borderStyle = .none
//        citytxt.borderStyle = .none
//
//        emailAddresstxt.borderStyle = .none
//        debitCardtxt.borderStyle = .none
//        chequeBooktxt.borderStyle = .none
//        transactionAlertstxt.borderStyle = .none
    }
    
    func setupCell(with consumer: ConsumerListResponseModel) {
      /*  bankingModeLabel.text = BankingMethod.getDescription(for: consumer.accountInformation?.bankingModeID ?? 0)
        branchLabel.text = consumer.customerBranch ?? ""
        accountTypeLabel.text = AccountType.getDescription(for: consumer.accountInformation?.customerAccountTypeID ?? 0)
        currencyLabel.text = consumer.accountInformation?.currencyType ?? ""
        // Accout type here
        // Nature of account
        mobileNumberLabel.text = consumer.mobileNo ?? ""
        cnicLabel.text = consumer.idNumber ?? ""
        dateOfBirthLabel.text = consumer.dateOfBirth ?? ""
        cnicDateOfIssueLabel.text = consumer.dateOfIssue ?? ""
        motherNameLabel.text = consumer.motherMaidenName ?? ""
        // Country here
        purposeOfAccountLabel.text = consumer.accountInformation?.purposeOfAccount ?? ""
        proofOfIncomeLabel.text = consumer.accountInformation?.proofOfIncomeInd == false ? "0" : "1"
        titleLabel.text = consumer.customerTitle ?? ""
        fullNameLabel.text = consumer.fullName ?? ""
        genderLabel.text = consumer.gender ?? ""
        placeOfBirthLabel.text = consumer.cityOfBirth ?? ""
        fatherHusbandName.text = consumer.fatherHusbandName ?? ""
        professionLabel.text = consumer.profession ?? ""
        occupationLabel.text = consumer.occupation ?? ""
        expectedSalaryLabel.text = consumer.accountInformation?.averageMonthlySalary ?? ""
        addressLabel.text = consumer.addresses?.first?.customerAddress ?? ""
        tehsilTownLabel.text = consumer.addresses?.first?.customerTown ?? ""
        cityLabel.text = consumer.addresses?.first?.city ?? ""
        currentCountryLabel.text = consumer.addresses?.first?.country ?? ""
        emailAddressLabel.text = consumer.emailAddress ?? ""
        debitCardLabel.text = consumer.accountInformation?.atmType ?? ""
        chequeBookLabel.text = consumer.accountInformation?.chequeBookReqInd == false ? "No" : "Yes"
        transactionAlertsLabel.text = consumer.accountInformation?.transAlertInd == false ? "No" : "Yes" */
        
        bankingModeLabel.text = BankingMethod.getDescription(for: consumer.accountInformation?.bankingModeID ?? 0)

//        bankingModetxt.text = BankingMethod.getDescription(for: consumer.accountInformation?.bankingModeID ?? 0)
        branchLabel.text = consumer.customerBranch ?? ""
        accountLabel.text = AccountType.getDescription(for: consumer.accountInformation?.customerAccountTypeID ?? 0)
        currencyLabel.text = consumer.accountInformation?.currencyType ?? ""
        // Accout type here
        accountTypeLabel.text = AccountType.getDescription(for: consumer.accountInformation?.customerAccountTypeID ?? 0)
        // Nature of account
        mobileNumberLabel.text = consumer.mobileNo ?? ""
        cnicLabel.text = consumer.idNumber ?? ""
        nationalityCnincLabel.text = consumer.idNumber ?? ""
        
        dateOfBirthLabel.text = consumer.dateOfBirth ?? ""
        natureOfAccountLabel.text = consumer.natureOfBusiness
        
        cnicDateOfIssueLabel.text = consumer.dateOfIssue ?? ""
        motherNameLabel.text = consumer.motherMaidenName ?? ""
        // Country here
       
        proofOfIncomeLabel.text = consumer.accountInformation?.proofOfIncomeInd == false ? "NO" : "YES"
        
        titleLabel.text = consumer.customerTitle ?? ""
        fullNameLabel.text = consumer.fullName ?? ""
        genderLabel.text = consumer.gender ?? ""
        fatherHusbandName.text = consumer.fatherHusbandName ?? ""
        professionLabel.text = consumer.profession ?? ""
        occupationLabel.text = consumer.occupation ?? ""
        expectedSalaryLabel.text = consumer.accountInformation?.averageMonthlySalary ?? ""
        addressLabel.text = consumer.addresses?.first?.customerAddress ?? ""
        tehsilTownLabel.text = consumer.addresses?.first?.customerTown ?? ""
        cityLabel.text = consumer.addresses?.first?.city ?? ""
        countryLabel.text = consumer.addresses?.first?.country ?? ""
//        nationalityCountryLabel.text = consumer.addresses?.first?.country ?? ""
        emailAddressLabel.text = consumer.emailAddress ?? ""
        debitCardLabel.text = consumer.accountInformation?.atmType ?? ""
        chequeBookLabel.text = consumer.accountInformation?.chequeBookReqInd == false ? "No" : "Yes"
        transactionAlertsLabel.text = consumer.accountInformation?.transAlertInd == false ? "No" : "Yes"
        
        
        let cnicFront = consumer.attachments?.first?.base64Content ?? ""
        let cnicBack = consumer.attachments?.last?.base64Content ?? ""
        
        cnicFrontImageView.image = modelRegistrationSteper.cnicFrontSideImageView
        cnicBackImageView.image = modelRegistrationSteper.cnicBackSideImageView
//        cnicFrontImageView.image = UIImage(data: Data(base64Encoded: cnicFront) ?? Data())
//        cnicBackImageView.image = UIImage(data: Data(base64Encoded: cnicBack) ?? Data())
    }
    @IBAction func btnSummary(_ sender: UIButton){
       
       
    }
    @IBAction func btnAccDetail(_ sender: UIButton){
        
    }
    @IBAction func btnYourDetail(_ sender: UIButton){
        
    }
    @IBAction func btnMailingAddress(_ sender: UIButton){
    }
    @IBAction func btnDetailsTrans(_ sender: UIButton){
       
    }
   
    
    func fatcaDefaultSetting() {
        segementUSTaxResident.segments = LabelSegment.segments(
            withTitles: ["No", "Yes"],
            normalTextColor: .white,
            selectedTextColor: UIColor(
                red: 0.92,
                green: 0.29,
                blue: 0.15,
                alpha: 1.00
            )
        )
        segementUSTaxCitizen.segments = LabelSegment.segments(
            withTitles: ["No", "Yes"],
            normalTextColor: .white,
            selectedTextColor: UIColor(
                red: 0.92,
                green: 0.29,
                blue: 0.15,
                alpha: 1.00
            )
        )
        segementMailAddress.segments = LabelSegment.segments(
            withTitles: ["No", "Yes"],
            normalTextColor: .white,
            selectedTextColor: UIColor(
                red: 0.92,
                green: 0.29,
                blue: 0.15,
                alpha: 1.00
            )
        )
        segementPlaceOfBirth.segments = LabelSegment.segments(
            withTitles: ["No", "Yes"],
            normalTextColor: .white,
            selectedTextColor: UIColor(
                red: 0.92,
                green: 0.29,
                blue: 0.15,
                alpha: 1.00
            )
        )
        segementOverSeasTerrotory.segments = LabelSegment.segments(
            withTitles: ["No", "Yes"],
            normalTextColor: .white,
            selectedTextColor: UIColor(
                red: 0.92,
                green: 0.29,
                blue: 0.15,
                alpha: 1.00
            )
        )
        segementPermanentResident.segments = LabelSegment.segments(
            withTitles: ["No", "Yes"],
            normalTextColor: .white,
            selectedTextColor: UIColor(
                red: 0.92,
                green: 0.29,
                blue: 0.15,
                alpha: 1.00
            )
        )
        segementGreenCardORPhoneNumber.segments = LabelSegment.segments(
            withTitles: ["No", "Yes"],
            normalTextColor: .white,
            selectedTextColor: UIColor(
                red: 0.92,
                green: 0.29,
                blue: 0.15,
                alpha: 1.00
            )
        )
    }
}
