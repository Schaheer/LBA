//
//  AddRemitterCell.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 27/04/2022.
//

import UIKit

final class AddRemitterCell: UITableViewCell {
    
    @IBOutlet weak var addRemitterView: UIView!
    
    var addRemitter: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addRemitterView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(addRemitterTapped)
            )
        )
    }
    
    @objc
    func addRemitterTapped() {
        addRemitter?()
    }
}
