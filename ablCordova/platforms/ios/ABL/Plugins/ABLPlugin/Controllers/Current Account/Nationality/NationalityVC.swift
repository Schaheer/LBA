//
//  NationalityVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/05/2022.
//

import UIKit
import BetterSegmentedControl

final class NationalityVC: UIViewController {
    
    @IBOutlet weak var nationalitySegment: BetterSegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedCountryByDefault: [CountryLookupDataModel]!

    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    private let nationalityViewModel = NationalityViewModel()
    private var countrisListResponse: CountryLookupResponseModel?
    var isEditFromReviewDetailsViewController = false
    var forViewController = ""
    
    var nationalityDualCountryNameLocal: String?
    var nationalityDualCountryIdLocal: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nationalitySegment.segments = LabelSegment.segments(
            withTitles: ["Single", "Dual"],
            normalTextColor: .white,
            selectedTextColor: .orange
        )
        
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.isHidden = false
        nationalityViewModel.getCountries()
        subscribeViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if modelRegistrationSteper.isNationalityDual != nil {
            if modelRegistrationSteper.isNationalityDual! == true {
                nationalitySegment.isSelected = (modelRegistrationSteper.isNationalityDual!) == true
                nationalitySegment.setIndex((modelRegistrationSteper.isNationalityDual!) ? 1 : 0)
                nationalityDualCountryIdLocal = modelRegistrationSteper.nationalityDualId
                nationalityDualCountryNameLocal = modelRegistrationSteper.nationalityDualName
                tableView.reloadData()
            }
        }
    }
    
    @IBAction func toggleNationality(_ sender: BetterSegmentedControl) {
        print(sender.index)
//        if sender.index == 0 {
//            tableView.isHidden = true
//        } else {
//            tableView.isHidden = false
//        }
        tableView.reloadData()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton){
        if let count = self.parent?.children.count{
            if count > 1{
                self.delegate?.removeChild()
                self.parent?.children.last?.remove()
            }else{
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton){
        if nationalitySegment.index == 1 {
            modelRegistrationSteper.isNationalityDual = true
            if nationalityDualCountryNameLocal != nil {
                modelRegistrationSteper.nationalityDualName = nationalityDualCountryNameLocal
            }
            if nationalityDualCountryIdLocal != nil {
                modelRegistrationSteper.nationalityDualId = nationalityDualCountryIdLocal
            }
        }
        else {
            modelRegistrationSteper.isNationalityDual = nil
            modelRegistrationSteper.nationalityDualName = nil
            modelRegistrationSteper.nationalityDualId = nil
        }
        
        self.delegate?.addChild(vc: .occupationVC, fromViewController: "")
    }
    
    private func subscribeViewModel() {
        nationalityViewModel.registerConsumerAddressResponse.bind { [weak self] response in
            guard let self = self, let countries = response?.data else { return }
            //MARK: TODO
        }
        nationalityViewModel.countryLookupResponse.bind { [weak self] response in
            
            self?.countrisListResponse = response
            let countries = self?.countrisListResponse?.data
            print(countries)
            print(countries)

//            let selectedCountryByDefault = countries?. {
//                $0.id == 157
//                print($0.id)
//            }
//            self?.selectedCountryByDefault = countries?.filter {
//                $0.id == 157
//                print($0.id)
//            }
            self?.tableView.reloadData()
        }
        
        nationalityViewModel.errorMessage.bind { error in
            guard let error = error else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: error)
        }
    }
    
    
}

extension NationalityVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(nationalitySegment.index)
        print(nationalitySegment.index == 0)

        let index = nationalitySegment.index
        if index == 1 {
            return 2
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SelectNationalityCell2",
                for: indexPath
            ) as? SelectNationalityCell
            cell?.selectNationalityLabel.text = "Pakistan"
            return cell ?? UITableViewCell()
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SelectNationalityCell",
                for: indexPath
            ) as? SelectNationalityCell
            cell?.countrisListResponse = countrisListResponse
            cell?.setupDropdown()
            if modelRegistrationSteper.nationalityDualName != nil {
                cell?.selectNationalityLabel.text = modelRegistrationSteper.nationalityDualName!
            }
            cell?.countrySelected = { [weak self] (index, countryName) in
                guard let countries = self?.countrisListResponse?.data else { return }
                //print("country is selected at index \(index) and the name is \(countries[index].name)" )
//                print(countries[index].id)
                self?.nationalityDualCountryNameLocal = countries[index].name
                self?.nationalityDualCountryIdLocal = countries[index].id
            }
            return cell ?? UITableViewCell()
        } else {
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "AddCountryCell",
                for: indexPath
            ) as? AddCountryCell
//            cell?.addCountry = { [weak self] in
//                guard let self = self else { return }
//                self.remitters.append(
//                    RemitterTextModel(
//                        nameOfRemitter: "",
//                        relationship: ""
//                    )
//                )
//                self.tableView.reloadData()
//            }
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
