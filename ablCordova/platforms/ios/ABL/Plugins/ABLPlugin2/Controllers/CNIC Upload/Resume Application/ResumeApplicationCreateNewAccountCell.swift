//
//  ResumeApplicationCreateNewAccountCell.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 30/03/2022.
//

import UIKit

class ResumeApplicationCreateNewAccountCell: UITableViewCell {
    
    @IBOutlet weak var createNewAccountView: UIView!
    
    var createNewAccount: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        createNewAccountView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(createNewAccountTapped)
            )
        )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc
    private func createNewAccountTapped() {
        createNewAccount?()
    }
}
