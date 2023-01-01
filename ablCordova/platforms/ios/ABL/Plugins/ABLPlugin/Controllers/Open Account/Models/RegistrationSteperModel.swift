//
//  RegistrationSteperModel.swift
//  ABL
//
//  Created by Shakeel on 31/10/2022.
//

import Foundation

import ObjectMapper

var modelRegistrationSteper = RegistrationSteperModel()
class RegistrationSteperModel {
    
    // MARK: - Model Properties
    var cnicFrontSideImageView: UIImage?
    var cnicBackSideImageView: UIImage?
    
    var rdaCustomerAccInfoId: Double?
    var selectBankingMethodViewModel: SelectBankingMethodViewModel?
    var selectAccountTypeViewModel: SelectAccountTypeViewModel?
    var selectedBankingMode: BankingMethod?
    var selectPreferredAccountViewModel: SelectPreferredAccountViewModel?
    var personalInformationViewModel: PersonalInformationViewModel?
    var mothersNames: [String]?
    var placesOfBirth: [String]?

    var proofOfIncomeInd: Int?
    var gender: String?
    var genderId = Int()
    var fullName: String?
    var fatherName: String?
    var cnicNumber: String?
    var placeOfBirth: String?
    var mothersName: String?
    var emailOptional: String?
    var landLineOptionalCurrent: String?
    var addressCurrent: String?
    var nearestLandMarkCurrent: String?
    var cityCurrent: String?
    var townTehsilCurrent: String?
    var country: String?
    var countryDual: String?
    var countryDualId: Int?

    var profession: String?
    var occupation: String?
    var ntnNumber: String?
    var salaryIncome: String?
    var employmentDetailsViewModel: EmploymentDetailsViewModel?
    var debitCardIndex: Int?
    var chequeBookIndex: Int?
    var transAlertIndex: Int?
    var SOAIndex: Int?
    var isEmail: Int?
    var isSMS: Int?
    var livePhotoPreviewImage: UIImage?
    var signaturePreviewImage: UIImage?
    var additionalApplicant: String?
    var additionalApplicantNo: Int?
    var natureOfAccount: NatureOfAccount?
    var picAndSignViewModel: PicAndSignViewModel?
    var serviceChannelsVM: ServiceChannelsViewModel?
    var permanentAddressViewModel: PersonalInformationViewModel?
    var addressTextFieldPermanent: String?
    var townTextFieldPermanent: String?
    var nearestLandmaarkTextFieldPermanent: String?
    var cityTextFieldPermanent: String?
    var landlineTextFieldPermanent: String?

    var isNationalityDual: Bool?
    var isTaxIdentificationNoDual: Bool?
    var taxNumberDual: String?
    var nationalityDualName: String?
    var nationalityDualId: Int?
    var nationalityDualTaxIdentificationNo: String?
    var taxNotAvailableReson: String?
    var taxNotAvailableResonId: Double?
    var taxNotAvailableResonFormBExplination: String?
    var taxFormBExplanation: String?
    var proofOfIncomeFileData: Data?
    var proofOfIncomeFileName: String?
    
    var isJointAccount = false
}


