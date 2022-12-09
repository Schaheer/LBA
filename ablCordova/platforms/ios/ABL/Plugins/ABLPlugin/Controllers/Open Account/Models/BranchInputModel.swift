//
//  BranchInputModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 31/03/2022.
//

import ObjectMapper

final class BranchInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case branchName = "data.branchName"
        case categoryType = "data.categoryType"
        case latitude = "data.latitude"
        case longitude = "data.longitude"
        case distance = "data.distance"
    }
    
    // MARK: - Model Properties
    
    var branchName: String?
    var categoryType: String?
    var latitude: String?
    var longitude: String?
    var distance: String?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        branchName: String,
        categoryType: String,
        latitude: String,
        longitude: String,
        distance: String
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.branchName.rawValue] = branchName
        dictionary[CodingKeys.categoryType.rawValue] = categoryType
        dictionary[CodingKeys.latitude.rawValue] = latitude
        dictionary[CodingKeys.longitude.rawValue] = longitude
        dictionary[CodingKeys.distance.rawValue] = distance
        
        self.branchName = branchName
        self.categoryType = categoryType
        self.latitude = latitude
        self.longitude = longitude
        self.distance = distance
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        branchName <- map[CodingKeys.branchName.rawValue]
        categoryType <- map[CodingKeys.categoryType.rawValue]
        latitude <- map[CodingKeys.latitude.rawValue]
        longitude <- map[CodingKeys.longitude.rawValue]
        distance <- map[CodingKeys.distance.rawValue]
    }
}
