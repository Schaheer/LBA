//
//  PersonalInformationSecondVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/03/2022.
//

import UIKit
import TTGTags

final class PersonalInformationSecondVC: UIViewController {
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var fathersNameTextField: UITextField!
    @IBOutlet weak var mothersNameCollectionView: TTGTextTagCollectionView!
    @IBOutlet weak var placeOfBirthCollectionView: TTGTextTagCollectionView!
    
    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    var mothersName = String()
    var placeOfBirth = String()
    var isEditFromReviewDetailsViewController = false
    var forViewController = ""
    private var mothersNames = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.first?.suggestedMotherNames
    private var placesOfBirth = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.first?.suggestedPlaceOfBirth
    
//    private let mothersNames = [
//        "Aaira",
//        "Ayesha",
//        "Ayera",
//        "Sana Bibi",
//        "Fatima",
//        "Ayaan Ali"
//    ]
    
//    private let placesOfBirth = [
//        "Lahore",
//        "Canada",
//        "Larkana",
//        "Layyah",
//        "Lodhran",
//        "Britian"
//    ]
    
    private var personalInformationViewModel = PersonalInformationViewModel()
    

    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMothersNameCollectionView()
        setupPlaceOfBirthCollectionView()
        subscribeViewModel()
        prePopulateData()
    }
    
    func viewDidLoadCustom() {
        if modelRegistrationSteper.personalInformationViewModel != nil {
            let tempViewModel = modelRegistrationSteper.personalInformationViewModel!
            if modelRegistrationSteper.mothersName != nil {
                mothersName = modelRegistrationSteper.mothersName!
                mothersNames = modelRegistrationSteper.mothersNames
                mothersNameCollectionView.removeAllTags()
                setupMothersNameCollectionView()
            }
            if modelRegistrationSteper.placeOfBirth != nil {
                placeOfBirth = modelRegistrationSteper.placeOfBirth!
                placesOfBirth = modelRegistrationSteper.placesOfBirth
                placeOfBirthCollectionView.removeAllTags()
                setupPlaceOfBirthCollectionView()
            }
            if modelRegistrationSteper.fullName != nil {
                fullNameTextField.text = modelRegistrationSteper.fullName
            }
            if modelRegistrationSteper.fatherName != nil {
                fathersNameTextField.text = modelRegistrationSteper.fatherName
            }
        }

    }
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoadCustom()
    }
    private func prePopulateData(){
        if let data = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.first {
            fullNameTextField.text = data.fullName
            fathersNameTextField.text = data.fatherHusbandName
        }
    }
    
    private func setupMothersNameCollectionView() {
        mothersNameCollectionView.delegate = self
        mothersNameCollectionView.verticalSpacing = 20
        mothersNameCollectionView.horizontalSpacing = 20
        guard let suggestedMotherNames = mothersNames else { return }
        for text in suggestedMotherNames {
            let unselectedContent = TTGTextTagStringContent(text: text)
            unselectedContent.textColor = .black
            unselectedContent.textFont = UIFont(name: "Lato-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
            
            let selectedContent = TTGTextTagStringContent(text: text)
            selectedContent.textColor = .white
            selectedContent.textFont = UIFont(name: "Lato-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
            
            let normalStyle = TTGTextTagStyle()
            normalStyle.backgroundColor = .white
            normalStyle.extraSpace = CGSize(width: 50, height: 20)
            normalStyle.shadowColor = .clear
            normalStyle.shadowOffset = CGSize(width: 0, height: 0)
            normalStyle.shadowRadius = 0
            normalStyle.shadowOpacity = 0
            normalStyle.borderWidth = 1
            normalStyle.borderColor = PluginColorAsset.appCTABlue.color
            normalStyle.cornerRadius = 16
            
            let selectedStyle = TTGTextTagStyle()
            selectedStyle.backgroundColor = PluginColorAsset.appCTABlue.color
            selectedStyle.extraSpace = CGSize(width: 50, height: 20)
            selectedStyle.shadowColor = .clear
            selectedStyle.shadowOffset = CGSize(width: 0, height: 0)
            selectedStyle.shadowRadius = 0
            selectedStyle.shadowOpacity = 0
            selectedStyle.borderWidth = 1
            selectedStyle.borderColor = PluginColorAsset.appCTABlue.color
            selectedStyle.cornerRadius = 16
            
            let tag = TTGTextTag()
            tag.content = unselectedContent
            tag.selectedContent = selectedContent
            tag.style = normalStyle
            tag.selectedStyle = selectedStyle
            if text == mothersName {
                tag.selected = true
            }
            mothersNameCollectionView.addTag(tag)
        }
        mothersNameCollectionView.reload()
    }
    
    private func setupPlaceOfBirthCollectionView() {
        placeOfBirthCollectionView.delegate = self
        placeOfBirthCollectionView.verticalSpacing = 20
        placeOfBirthCollectionView.horizontalSpacing = 20
        guard let suggestedPlaceOfBirth = placesOfBirth else { return }
        for text in suggestedPlaceOfBirth {
            let unselectedContent = TTGTextTagStringContent(text: text)
            unselectedContent.textColor = .black
            unselectedContent.textFont = UIFont(name: "Lato-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
            
            let selectedContent = TTGTextTagStringContent(text: text)
            selectedContent.textColor = .white
            selectedContent.textFont = UIFont(name: "Lato-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
            
            let normalStyle = TTGTextTagStyle()
            normalStyle.backgroundColor = .white
            normalStyle.extraSpace = CGSize(width: 50, height: 20)
            normalStyle.shadowColor = .clear
            normalStyle.shadowOffset = CGSize(width: 0, height: 0)
            normalStyle.shadowRadius = 0
            normalStyle.shadowOpacity = 0
            normalStyle.borderWidth = 1
            normalStyle.borderColor = PluginColorAsset.appCTABlue.color
            normalStyle.cornerRadius = 16
            
            let selectedStyle = TTGTextTagStyle()
            selectedStyle.backgroundColor = PluginColorAsset.appCTABlue.color
            selectedStyle.extraSpace = CGSize(width: 50, height: 20)
            selectedStyle.shadowColor = .clear
            selectedStyle.shadowOffset = CGSize(width: 0, height: 0)
            selectedStyle.shadowRadius = 0
            selectedStyle.shadowOpacity = 0
            selectedStyle.borderWidth = 1
            selectedStyle.borderColor = PluginColorAsset.appCTABlue.color
            selectedStyle.cornerRadius = 16
            
            let tag = TTGTextTag()
            tag.content = unselectedContent
            tag.selectedContent = selectedContent
            tag.style = normalStyle
            tag.selectedStyle = selectedStyle
            if text == placeOfBirth {
                tag.selected = true
            }
            placeOfBirthCollectionView.addTag(tag)
        }
        placeOfBirthCollectionView.reload()
    }
    
    
    private func subscribeViewModel() {
        personalInformationViewModel.registerConsumerBasicInfoResponse.bind() { [weak self] response in
            guard let status = response?.message?.status, let description = response?.message?.description?.lowercased() else { return }
            if status == "200" && description.lowercased() == "success"{
                self?.delegate?.addChild(vc: .personalInformationThirdVC, fromViewController: "")
            }
        }
        
        personalInformationViewModel.errorMessage.bind() {  error in
            guard let error = error else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: error)
        }
    }
    
    @IBAction func nextBtnClicked(_ sender: UIButton){
        if fullNameTextField.text?.count == 0{
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please Enter Full Name first")
        }else if fathersNameTextField.text?.count == 0{
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please Enter Full Fahter’s Name first")
        }else if mothersName.count == 0{
            AlertManager.shared.showOKAlert(with: "Alert!", message: "Please Enter Mother’s Name first")
        }else{
            personalInformationViewModel.registerConsumerBasicInfo(
                customerAccInfoID: DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last?.accountInformation?.rdaCustomerAccInfoID,
                customerProfiledID: DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last?.rdaCustomerProfileID,
                fullName: fullNameTextField.text,
                fatherHusbandName: fathersNameTextField.text,
                motherMaidenName: mothersName,
                placeOfBirth: placeOfBirth,
                isPrimary: true
            )
        }
        modelRegistrationSteper.personalInformationViewModel = personalInformationViewModel
        modelRegistrationSteper.mothersNames = mothersNames
        modelRegistrationSteper.placesOfBirth = placesOfBirth
        modelRegistrationSteper.fullName = fullNameTextField.text
        modelRegistrationSteper.fatherName = fathersNameTextField.text
    }
    
    @IBAction func backBtnClicked(_ snder: UIButton){
        if let count = self.parent?.children.count{
            if count > 1{
                self.delegate?.removeChild()
                self.parent?.children.last?.remove()
            }else{
                
                navigationController?.popViewController(animated: true)
                
            }
        }
        
    }
}

extension PersonalInformationSecondVC: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(
        _ textTagCollectionView: TTGTextTagCollectionView!,
        didTap tag: TTGTextTag!,
        at index: UInt
    ) {
        if textTagCollectionView == mothersNameCollectionView {
            textTagCollectionView.allSelectedTags().forEach {
                $0.selected = false
            }
            
            textTagCollectionView.updateTag(at: index, selected: true)
            mothersName = tag.content.getAttributedString().string
            modelRegistrationSteper.mothersName = mothersName
        } else if textTagCollectionView == placeOfBirthCollectionView {
            textTagCollectionView.allSelectedTags().forEach {
                $0.selected = false
            }
            textTagCollectionView.updateTag(at: index, selected: true)
            placeOfBirth = tag.content.getAttributedString().string
            modelRegistrationSteper.placeOfBirth = placeOfBirth
        }
    }
    
}
