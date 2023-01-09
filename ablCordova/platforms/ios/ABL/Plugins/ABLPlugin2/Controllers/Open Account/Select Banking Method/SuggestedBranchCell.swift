//
//  SuggestedBranchCell.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 02/06/2022.
//

import UIKit

final class SuggestedBranchCell: UITableViewCell {
    
    @IBOutlet weak var radioImageView: UIImageView!
    @IBOutlet weak var branchLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            radioImageView.image = PluginImageAsset.radioFilled.image
        } else {
            radioImageView.image = PluginImageAsset.radioUnfilled.image
        }
    }
    
    func setupCell(with branch: BranchListModel) {
        branchLabel.text = "\(branch.branchName ?? "") (\(branch.branchCode ?? ""))"
    }
}
