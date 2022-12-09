//
//  OTPTextField.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 04/03/2022.
//

import UIKit

class OTPTextField: UITextField {
    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?
    override public func deleteBackward(){
        text = ""
        previousTextField?.becomeFirstResponder()
    }
}
