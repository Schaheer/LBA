//
//  AESManager.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 09/03/2022.
//

import Foundation
import CommonCrypto

struct AES {

    private let key: String

    // MARK: - Initialzier
    init?(key: String) {
        self.key = key
    }
    
    func encrypt(string: String) -> String? {
        
        let keyData: NSData! = (key as NSString).data(using: String.Encoding.utf8.rawValue) as NSData?
        let data: NSData! = (string as NSString).data(using: String.Encoding.utf8.rawValue) as NSData?
        
        let cryptData    = NSMutableData(length: Int(data.length) + kCCBlockSizeAES128)!
        
        let keyLength              = size_t(kCCKeySizeAES128)
        let operation: CCOperation = UInt32(kCCEncrypt)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
        let options:   CCOptions   = UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding)
        
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  keyData.bytes, keyLength,
                                  nil,
                                  data.bytes, data.length,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.length = Int(numBytesEncrypted)
            let base64cryptString = cryptData.base64EncodedString(options: .lineLength64Characters)
            return base64cryptString
        }
        
        return nil
    }
}
