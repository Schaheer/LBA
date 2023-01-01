//
//  SelectionCell.swift
//  ABL
//
//  Created by Schaheer Saleem
//

import UIKit

class SelectionCell: UITableViewCell {

    @IBOutlet weak var titleLabel: LabelSetting!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func setCell(with title: String) {
        titleLabel.text = title
    }
    
}
