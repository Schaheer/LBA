//
//  GetDraftedAppsVerifyOTPResponseModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 28/03/2022.
//

import ObjectMapper

final class GetDraftedAppsVerifyOTPResponseModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case appList = "data.appList"
        case accessToken = "data.accessToken"
    }
    
    // MARK: - Model Properties
    
    var appList: [GetDraftedAppsAppListModel]?
    var accessToken: String?
    
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
        
        appList <- map[CodingKeys.appList.rawValue]
        accessToken <- map[CodingKeys.accessToken.rawValue]
    }
}
