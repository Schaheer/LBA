//
//  ResumeApplicationDetailCell.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 30/03/2022.
//

import UIKit

class ResumeApplicationDetailCell: UITableViewCell {
    
    @IBOutlet weak var borderedView: CustomUIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var accountCurrencyLabel: UILabel!
    @IBOutlet weak var deleteApplicationImageView: UIImageView!
    @IBOutlet weak var editApplicationImageView: UIImageView!
    
    var deleteApplication: (() -> Void)?
    var editApplication: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        deleteApplicationImageView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(deleteApplicationTapped)
            )
        )
        
        editApplicationImageView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(editApplicationTapped)
            )
        )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            borderedView.borderColor = PluginColorAsset.appOrange.color
        } else {
            borderedView.borderColor = PluginColorAsset.otpFieldBorder.color
        }
    }

    func setupCell(with draftedAppsDataList: GetDraftedAppsAppListModel) {
        fullNameLabel.text = draftedAppsDataList.fullName
        accountTypeLabel.text = draftedAppsDataList.accountType ?? "ADRA (Single)"
        accountCurrencyLabel.text = draftedAppsDataList.currencyType ?? "PKR"
    }
    
    @objc
    func deleteApplicationTapped() {
        deleteApplication?()
    }
    
    @objc
    func editApplicationTapped() {
        editApplication?()
    }
}
