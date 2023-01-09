//
//  SelectPreferredAccountCell.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 17/03/2022.
//

import UIKit

//final class SelectPreferredAccountCell: UITableViewCell {
//
//    @IBOutlet weak var borderedView: CustomUIView!
//    @IBOutlet weak var accountTypeLabel: UILabel!
//    @IBOutlet weak var accountTypeDescriptionLabel: UILabel!
//    @IBOutlet weak var checkUncheckImageView: UIImageView!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        if selected {
//            checkUncheckImageView.image = PluginImageAsset.checkIcon.image
//            borderedView.borderColor = PluginColorAsset.appOrange.color
//        } else {
//            checkUncheckImageView.image = PluginImageAsset.uncheckIcon.image
//            borderedView.borderColor = PluginColorAsset.otpFieldBorder.color
//        }
//    }
//
//    func setupCell(with preferredAccount: PreferredAccount) {
//        accountTypeLabel.text = preferredAccount.type
//        accountTypeDescriptionLabel.text = preferredAccount.description
//        checkUncheckImageView.image = preferredAccount.checkUncheckIcon
//    }
//}

struct PreferredAccount {
    var type: String
    var description: String
    var checkUncheckIcon: UIImage
    var id: AccountVariant

    init(type: String, description: String, checkUncheckIcon: UIImage, id: AccountVariant) {
        self.type = type
        self.description = description
        self.checkUncheckIcon = checkUncheckIcon
        self.id = id
    }
}

//struct PreferredAccount {
//    var type: String
//    var description: UIImage
//    var checkUncheckIcon: UIImage
//    var color: UIColor
//
//    init(type: String, description: UIImage, checkUncheckIcon: UIImage, color: UIColor) {
//        self.type = type
//        self.description = description
//        self.checkUncheckIcon = checkUncheckIcon
//        self.color = color
//    }
//}

final class SelectPreferredAccountCell: UICollectionViewCell {

    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var accountTypeDescriptionLabel: UILabel!
    @IBOutlet weak var filledUnfilledIconImageView: UIImageView!
    @IBOutlet weak var containerView: CustomUIView!
    

    @IBOutlet weak var textView: UITextView!
    override var isSelected: Bool {
        didSet {
//            if isSelected {
//                filledUnfilledIconImageView.image = PluginImageAsset.checkIcon.image
//                containerView.borderColor = PluginColorAsset.appOrange.color
//            } else {
//                filledUnfilledIconImageView.image = PluginImageAsset.uncheckIcon.image
//                containerView.borderColor = PluginColorAsset.otpFieldBorder.color
//            }
        }
    }

    override class func awakeFromNib() {
        super.awakeFromNib()

    }

//    func setupCell(with preferredAccount: PreferredAccount) {
//        accountTypeLabel.text = preferredAccount.type
//        accountTypeDescriptionLabel.text = preferredAccount.description
//        accountTypeDescriptionLabel.text = "• Allied Bank Current Account offers a host of free services on maintaining a monthly average balance of Rs.250,000/- & above.\n\n•Free of cost issuance of first cheque book of 10 leaves\n\n•Free Online Balance Enquiry"
//        filledUnfilledIconImageView.image = preferredAccount.checkUncheckIcon
//    }
    
    func setupCell(with account: CodeTypeDataModel) {
        accountTypeLabel.text = account.name
        accountTypeDescriptionLabel.text = "• Allied Bank Current Account offers a host of free services on maintaining a monthly average balance of Rs.250,000/- & above.\n\n•Free of cost issuance of first cheque book of 10 leaves\n\n•Free Online Balance Enquiry"
        filledUnfilledIconImageView.image = UIImage(named: "uncheck-icon")!
        guard let accountId = account.id else { return }
        let accountType: AccountVariant = AccountVariant(rawValue: accountId) ?? .unknown
        accountTypeDescriptionLabel.text = accountType.description
        textView.text = accountType.description
    }
}
