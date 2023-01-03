//
//  ATMTypeCollectionViewCell.swift
//  ABL
//
//  Created by Hamza Amin on 6/7/22.
//

import UIKit

class ATMTypeCollectionViewCell: UICollectionViewCell {

    static let identifier = "ATMTypeCollectionViewCell"

    @IBOutlet weak var selectedImageBackGround: UIView!
    @IBOutlet weak var atmImageView: UIImageView!
    @IBOutlet weak var atmTitleLabel: UILabel!
    @IBOutlet weak var atmDescriptionLabel: UILabel!
    @IBOutlet var containerWidthConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        containerWidthConstraint.constant = UIScreen.main.bounds.width * 0.8
    }
    
    func setupCell(with atm: CodeTypeDataModel) {
        atmTitleLabel.text = atm.name
        atmDescriptionLabel.text = atm.description
        let imageUrl = "https://rda.abl.com/assets/img/atm-cards/" + "\(Int(atm.id!))" + ".png"
        atmImageView.setImage(urlString: imageUrl, placeholder: "upi-paypak-classic-card")
    }

}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        print(url)
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
