//
//  FATCATableViewCell.swift
//  ABL
//
//  Created by Hamza Amin on 4/26/22.
//

import UIKit
import BetterSegmentedControl

class FATCATableViewCell: UITableViewCell {

    static let identifier = "FATCATableViewCell"
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerSwitch: BetterSegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews(){
        answerSwitch.segments = LabelSegment.segments(withTitles: ["No".localizeString(), "Yes".localizeString()],
                                                      normalFont: PluginFonts.workSansReg14.font,
                                                      normalTextColor: .white,
                                                      selectedFont: PluginFonts.workSansReg14.font,
                                                      selectedTextColor: .white)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(with question: FATCAQuestion){
        questionLabel.text = question.question
//        answerSwitch
    }
}
