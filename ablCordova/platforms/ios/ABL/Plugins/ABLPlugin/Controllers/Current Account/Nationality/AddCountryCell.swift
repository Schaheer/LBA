//
//  AddNationalityCell.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/05/2022.
//

import UIKit

final class AddCountryCell: UITableViewCell {
    
    @IBOutlet weak var addCountryView: UIView!
    
    var addCountry: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addCountryView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(addCountryTapped)
            )
        )
    }
    
    @objc
    func addCountryTapped() {
        addCountry?()
    }
}
