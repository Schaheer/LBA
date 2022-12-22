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
        print(nationalitySegment.index)
        if nationalitySegment.index == 1 {
            modelRegistrationSteper.isNationalityDual = true
            if nationalityDualCountryNameLocal != nil {
                modelRegistrationSteper.nationalityDualName = nationalityDualCountryNameLocal
            }
            if nationalityDualCountryIdLocal != nil {
                modelRegistrationSteper.nationalityDualId = nationalityDualCountryIdLocal
            }
        } else {
            modelRegistrationSteper.isNationalityDual = nil
            modelRegistrationSteper.nationalityDualName = nil
            modelRegistrationSteper.nationalityDualId = nil
        }
        registerConsumerBasicInfo()
        
        
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
    
    func registerConsumerBasicInfo() {
        var currentUser = getCurrentUser()
        
        let nationalityPakistan = NationalityInputModel(
            rdaCustomerId: currentUser.rdaCustomerProfileID,
            nationalityId: 157,
            idNumber: currentUser.idNumber)!
        
        var nationalitiesArray: [NationalityInputModel]? = []
        nationalitiesArray?.append(nationalityPakistan)
        //MARK: - if more then one nationality
        if modelRegistrationSteper.isNationalityDual ?? false {
            let nationalityOther = NationalityInputModel(
                rdaCustomerId: currentUser.rdaCustomerProfileID,
                nationalityId: Double(modelRegistrationSteper.nationalityDualId!),
                idNumber: currentUser.idNumber)!
            nationalitiesArray?.append(nationalityOther)
        }
        
        let nationalities2: [[String: Any]] = (nationalitiesArray?.map({
            ["rdaCustomerId": ($0.rdaCustomerId ?? 0) ?? 0,
             "nationalityId": ($0.nationalityId ?? 0),
             "idNumber": ($0.idNumber ?? 0)]
        }))!
        
        let customerAccInfoID = currentUser.rdaCustomerAccInfoId
        let customerProfiledID = currentUser.rdaCustomerProfileID!
        let isPrimary = currentUser.isPrimary
        let isPrimaryRegistered = currentUser.isPrimaryRegistered ?? false
        
        let consumerList = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList
        
        var consumerListInputModelArray = [BasicInfoConsumerListInputModel]()
        
        let basicInfoConsumerListInput = BasicInfoConsumerListInputModel(
            rdaCustomerAccInfoId: customerAccInfoID as! Double,
            rdaCustomerProfileId: customerProfiledID,
            isPrimary: (consumerList?.count ?? 0 > 0 ? false : isPrimary)!,
            isPrimaryRegistered: isPrimaryRegistered,
            nationalityTypeId: modelRegistrationSteper.isNationalityDual ?? false ? 100902 : 100901,
            nationalities: nationalities2
        )
        consumerListInputModelArray = getListOfConsumers(newUserInfo: basicInfoConsumerListInput!)
        
        //TODO: add data of all the applicants for joint account
        guard let registerConsumerBasicInfoInput = RegisterConsumerBasicInfoInputModel(consumerList: consumerListInputModelArray) else {return}
        APIManager.shared.registerConsumerBasicInfo(input: registerConsumerBasicInfoInput) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.delegate?.addChild(vc: .occupationVC, fromViewController: "")
                print(value)
                break
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
    //MARK: - For merging
    func getListOfConsumers(newUserInfo: BasicInfoConsumerListInputModel) -> [BasicInfoConsumerListInputModel] {
        var tempRdaCustomerProfileID = newUserInfo.rdaCustomerProfileId
        var tempRdaCustomerAccInfoId = newUserInfo.rdaCustomerAccInfoId
        let nationalities = newUserInfo.nationalities
        let cousumerListHamza = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList
        let cousumerListShakeel = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList
        
        //MARK: - Start----- Just to find new User Profile ID
        if let listConsumerLocalHamza = cousumerListHamza {
            for consumer in listConsumerLocalHamza {
                print(consumer.rdaCustomerProfileID ?? 0)
                print(consumer.rdaCustomerAccInfoId ?? 0)
                if let consumerListLocalShakeel = cousumerListShakeel {
                    var isNotFoundAndNewUserProfileID = true
                    consumerListLocalShakeel.forEach {
                        print("Hamza" + "\(consumer.rdaCustomerProfileID ?? 0)")
                        print("Hamza" + "\(consumer.rdaCustomerAccInfoId ?? 0)")
                        print("Shakeel" + "\($0.rdaCustomerProfileID ?? 0)")
                        print("Shakeel" + "\($0.rdaCustomerAccInfoId ?? 0)")
                        if $0.rdaCustomerProfileID == consumer.rdaCustomerProfileID {
                            print("record found")
                            isNotFoundAndNewUserProfileID = false
                        }
                    }
                    if isNotFoundAndNewUserProfileID {
                        print("------Start-----Profile Id Not Found------")
                        tempRdaCustomerProfileID = consumer.rdaCustomerProfileID ?? 0
                        tempRdaCustomerAccInfoId = consumer.rdaCustomerAccInfoId as? Double
                        print(consumer.rdaCustomerProfileID ?? 0)
                        print(consumer.rdaCustomerAccInfoId ?? 0)
                        print("------End-----Profile Id Not Found------")
                    }
                }
            }
        }
        //MARK: - End----- Just to find new User Profile ID
        
        //MARK: - Start-----If user profile id found Replace in new user Request data
        newUserInfo.rdaCustomerProfileId = tempRdaCustomerProfileID
        newUserInfo.rdaCustomerAccInfoId = tempRdaCustomerAccInfoId
        newUserInfo.nationalities = nationalities
        //MARK: - End-----If user profile id found Replace in new user Request data
        
        var consumerListInputModelArray = [BasicInfoConsumerListInputModel]()
        
        if let consumerListTemp = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList {
            consumerListTemp.forEach {
                let consumerListInputModel = BasicInfoConsumerListInputModel(
                    rdaCustomerAccInfoId: ($0.accountInformation?.rdaCustomerAccInfoID)!,
                    rdaCustomerProfileId: $0.rdaCustomerProfileID!,
                    fullName: $0.fullName!,
                    fatherHusbandName: $0.fatherHusbandName ?? "",
                    motherMaidenName: $0.motherMaidenName ?? "",
                    isPrimary: $0.isPrimary ?? false,
                    isPrimaryRegistered: $0.isPrimaryRegistered ?? false,
                    nationalityTypeId: $0.nationalityTypeID,
                    nationalities: $0.nationalities
                )
                consumerListInputModelArray.append(consumerListInputModel!)
            }
        }
        
        print("------Start-----Check if user is adding for joint account------")
        //MARK: - Start----- Just to check if user is trying for joint account this this check will become true
        if consumerListInputModelArray.count > 0 {
            newUserInfo.isPrimaryRegistered = false
            newUserInfo.isPrimary = false
        }
        //MARK: - End----- Just to check if user is trying for joint account this this check will become true
        print("------End-----Check if user is adding for joint account------")
        
        consumerListInputModelArray.append(newUserInfo)
        return consumerListInputModelArray
    }
}
