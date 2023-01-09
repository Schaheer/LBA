//
//  UserDefaults.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import Foundation

import Foundation

extension UserDefaults {
    
    func saveData(_ data: Any?, forKey key: BaseConstants.UserDefaults) {
        setValue(data, forKey: key.rawValue)
    }
    
    func loadData(forKey key: BaseConstants.UserDefaults) -> Any? {
        return object(forKey: key.rawValue)
    }
    
    func removeData(forKey key: BaseConstants.UserDefaults) {
        removeObject(forKey: key.rawValue)
    }
}
