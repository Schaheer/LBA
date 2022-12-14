//
//  SelectNationalityCell.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/05/2022.
//

import UIKit
import DropDown

final class SelectNationalityCell: UITableViewCell {
    
    @IBOutlet weak var selectNationalityView: CustomUIView!
    @IBOutlet weak var labelDualCountry: UILabel!
    
    var viewController = UIViewController()
    private let dropDown = DropDown()
    var countrySelected: ((Int, String) -> Void)?
    var countrisListResponse: CountryLookupResponseModel?
        
    override func awakeFromNib() {
        super.awakeFromNib()
//        setupDropdown()
        
        selectNationalityView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(dropdownTapped)
            )
        )
    }
    
    func setupDropdown() {
        dropDown.anchorView = selectNationalityView
        dropDown.direction = .top
        dropDown.frame.size.height = 250
        dropDown.bottomOffset = CGPoint(
            x: 0,
            y: dropDown.anchorView?.plainView.bounds.height ?? 0
        )
        dropDown.frame.size.height = 250

        dropDown.selectionAction = { [unowned self] index, item in
            self.labelDualCountry.text = item
            self.countrySelected?(index, item)
        }
        
        guard let countries = countrisListResponse?.data else { return }
//        print(countries.map { $0.name ?? "N/A" }, "countries.map { $0.name ?? N/A }")
        dropDown.dataSource = countries.map { $0.name ?? "N/A" }
//        dropDown.dataSource = [
//            "Pakistan",
//            "USA",
//            "UK",
//            "Canada",
//            "Australia"
//        ]
    }
    
    @objc
    private func dropdownTapped() {
//        dropDown.show()
        guard let countries = countrisListResponse?.data else { return }

        let dataSource = countries.map { $0.name ?? "N/A" }
        
        viewController.showSelectionAlert(with: dataSource, title: "Searched Country") { index, item in
            logsManager.debug("Selected item \(item) at index \(index)")
            self.labelDualCountry.text = item
            self.countrySelected?(index, item)
        }
    }
}
