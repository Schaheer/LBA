//
//  RemitterDetailCell.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 27/04/2022.
//

import UIKit

final class RemitterDetailCell: UITableViewCell {
    
    @IBOutlet weak var nameOfRemitterTextField: UITextField!
    @IBOutlet weak var relationshipTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

struct RemitterTextModel {
    var nameOfRemitter: String
    var relationship: String
    
    init(nameOfRemitter: String, relationship: String) {
        self.nameOfRemitter = nameOfRemitter
        self.relationship = relationship
    }
}
