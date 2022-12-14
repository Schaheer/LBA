//
//  TableViewCell.swift
//  ABL
//
//  Created by Schaheer Saleem on 14/12/2022.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var termsCheckBoxImageView: UIImageView!
    @IBOutlet weak var declarationCheckBoxImageView: UIImageView!
    @IBOutlet weak var keyFactStatementCheckBoxImageView: UIImageView!
    
    var TNCBlock: (() -> ())?
    var declarationBlock: (() -> ())?
    var keyFactStatementBlock: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func setTermsCheckBox(with state: Bool) {
        if state {
            termsCheckBoxImageView.image = #imageLiteral(resourceName: "review-detail-check")
        } else {
            termsCheckBoxImageView.image = #imageLiteral(resourceName: "review-detail-checked")
        }
    }
    
    func setDeclarationCheckBox(with state: Bool) {
        if state {
            declarationCheckBoxImageView.image = #imageLiteral(resourceName: "review-detail-check")
        } else {
            declarationCheckBoxImageView.image = #imageLiteral(resourceName: "review-detail-checked")
        }
    }
    
    func setKeyFactStatementCheckBox(with state: Bool) {
        if state {
            keyFactStatementCheckBoxImageView.image = #imageLiteral(resourceName: "review-detail-check")
        } else {
            keyFactStatementCheckBoxImageView.image = #imageLiteral(resourceName: "review-detail-checked")
        }
    }
    
    @IBAction func termsAndConditionsTapped(_ sender: Any) {
        TNCBlock?()
    }
    
    @IBAction func declarationTapped(_ sender: Any) {
        declarationBlock?()
    }
    
    @IBAction func keyFactStatementTapped(_ sender: Any) {
        keyFactStatementBlock?()
    }

}
