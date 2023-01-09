//
//  Data.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import Foundation

extension Data {
    
    func prettyJSONString() -> String? {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) {
            if let prettyPrintedData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                return String(bytes: prettyPrintedData, encoding: String.Encoding.utf8) ?? nil
            }
        }
        return nil
    }
    
    func JSON() -> [String: Any]? {
        if let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] {
            return json
        }
        return nil
    }
}
