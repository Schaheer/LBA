//
//  BranchResponseModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 31/03/2022.
//

import ObjectMapper

final class BranchResponseModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case branchList = "data.branchList"
        case suggestedBranchList = "data.suggestBranchList"
    }
    
    // MARK: - Model Properties
    
    var branchList: [BranchListModel]?
    var suggestedBranchList: [BranchListModel]?
    
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
        
        branchList <- map[CodingKeys.branchList.rawValue]
        suggestedBranchList <- map[CodingKeys.suggestedBranchList.rawValue]
    }
}
