//
//  BranchListModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 31/03/2022.
//

import ObjectMapper

final class BranchListModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case id
        case branchName
        case branchCode
        case tBranchCode
        case cityName
        case latitude
        case longitude
        case distance
    }
    
    // MARK: - Model Properties
    
    var id: Int?
    var branchName: String?
    var branchCode: String?
    var tBranchCode: String?
    var cityName: String?
    var latitude: Double?
    var longitude: Double?
    var distance: Double?
    
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
        
        id <- map[CodingKeys.id.rawValue]
        branchName <- map[CodingKeys.branchName.rawValue]
        branchCode <- map[CodingKeys.branchCode.rawValue]
        tBranchCode <- map[CodingKeys.tBranchCode.rawValue]
        cityName <- map[CodingKeys.cityName.rawValue]
        latitude <- map[CodingKeys.latitude.rawValue]
        longitude <- map[CodingKeys.longitude.rawValue]
        distance <- map[CodingKeys.distance.rawValue]
    }
}
