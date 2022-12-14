//
//  CustomPopup.swift
//  ABL
//
//  Created by Shakeel on 14/12/2022.
//

import UIKit

final class CustomPopup: UIViewController {
    
    var portedMobileNetwork: (() -> Void)?
    var titleString: String?
    var message: String?
    var buttonTitle: String?
    @IBOutlet weak var labelTitle: LabelSetting!
    @IBOutlet weak var doneButton: ButtonSetting!
    @IBOutlet weak var labelMessage: LabelSetting!
    
   
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if titleString != nil {
            labelTitle.text = titleString
        }
        if message != nil {
            labelMessage.text = message
        }
        if buttonTitle != nil {
            doneButton.setTitle(buttonTitle, for: .normal)
        }
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
        dismiss(animated: true) {
            self.portedMobileNetwork?()
        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
