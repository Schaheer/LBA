//
//  StepperSectionsModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 06/04/2022.
//

import ObjectMapper

final class StepperSectionsModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case setupAccountBankingMode = "SETUP_ACCOUNT_BANKING_MODE"
        case setupAccountType = "SETUP_ACCOUNT_TYPE"
        case setupAccountIncome = "SETUP_ACCOUNT_INCOME"
        case personalDetailNames = "PERSONAL_DETAIL_NAMES"
        case personalDetailAddress = "PERSONAL_DETAIL_ADDRESS"
        case personalDetailEmployment = "PERSONAL_DETAIL_EMPLOYMENT"
        case transactionalDetail = "TRANSACTIONAL_DETAIL"
        case documentUploader = "DOCUMENT_UPLOADER"
    }
    
    // MARK: - Model Properties
    
    var setupAccountBankingMode: Bool?
    var setupAccountType: Bool?
    var setupAccountIncome: Bool?
    var personalDetailNames: Bool?
    var personalDetailAddress: Bool?
    var personalDetailEmployment: Bool?
    var transactionalDetail: Bool?
    var documentUploader: Bool?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: MappingType.fromJSON, JSON: dictionary))
    }
    
    // MARK: Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        setupAccountBankingMode <- map[CodingKeys.setupAccountBankingMode.rawValue]
        setupAccountType <- map[CodingKeys.setupAccountType.rawValue]
        setupAccountIncome <- map[CodingKeys.setupAccountIncome.rawValue]
        personalDetailNames <- map[CodingKeys.personalDetailNames.rawValue]
        personalDetailAddress <- map[CodingKeys.personalDetailAddress.rawValue]
        personalDetailEmployment <- map[CodingKeys.personalDetailEmployment.rawValue]
        transactionalDetail <- map[CodingKeys.transactionalDetail.rawValue]
        documentUploader <- map[CodingKeys.documentUploader.rawValue]
    }
    
    // MARK: - Helper Functions
    
    func stepTo() -> DraftedAppStepper {
        if setupAccountBankingMode == false {
            return .setupAccountBankingMode
        } else if setupAccountType == false {
            return .setupAccountType
        } else if setupAccountIncome == false {
            return .setupAccountIncome
        } else if personalDetailNames == false {
            return .personalDetailNames
        } else if personalDetailAddress == false {
            return .personalDetailAddress
        } else if personalDetailEmployment == false {
            return .personalDetailEmployment
        } else if transactionalDetail == false {
            return .transactionalDetail
        } else if documentUploader == false {
            return .documentUploader
        }
        
        return .setupAccountBankingMode
    }
}
