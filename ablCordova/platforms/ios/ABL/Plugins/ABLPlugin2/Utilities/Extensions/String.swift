//
//  String.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import CommonCrypto

extension String {
    
    var url: URL? {
        return try? asURL()
    }
    
    func constructURL() -> Self {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "Unable to construct URL"
    }
    
    
    //To check text field or String is blank or not
//    var isBlank: Bool {
//        get {
//            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
//            return trimmed.isEmpty
//        }
//    }

    //Validate Email

//    var isEmail: Bool {
//        do {
//            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
//            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
//        } catch {
//            return false
//        }
//    }

//    var isAlphanumeric: Bool {
//        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
//    }

    //validate Password
//    var isValidPassword: Bool {
//        do {
//            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
//            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil){
//
//                if(self.count>=6 && self.count<=20){
//                    return true
//                }else{
//                    return false
//                }
//            }else{
//                return false
//            }
//        } catch {
//            return false
//        }
//    }
    
    var isValidPhoneNumber: Bool{
        return validateNumber(value: self)
    }
    func validateNumber(value: String) -> Bool {
        let PHONE_REGEX = "^03\\d{2}-\\d{7}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
    
    var isValidEmail: Bool{
        return validateEmail(self)
    }
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
