//
//  PersonalInfomationBaseVC.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/03/2022.
//

import UIKit


protocol PersonalInfoChildToParentProtocol:AnyObject {
    func addChild(vc: PluginViewController, fromViewController: String)
//    func addChild(vc: PluginViewController)
    func removeChild()
}

enum PersonalInfoChildVC{
    case fatcaVC
    case personalInfoSecondVC
    case personalInfoThirdVC
    case serviceChannelVC
    case pictureAndSignVC
    case remittanceDetailVC
    case taxResidentDetailVC
    case additionalApplicationDetailsVC
    case nationalityVC
    case transactionalAlertsVC
    case nextOfKinVC
    case currentTaxResidentDetailVC
    case taxResidentailDetailVC
    case registerPermanentAddress
}

final class PersonalInformationBaseVC: UIViewController{
    
    @IBOutlet weak var viewFour: UIView!
    @IBOutlet weak var viewThree: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var childContainerView: UIView!
    
    var childrenCount: Int! {
        didSet {
            //Reset
            viewOne.backgroundColor = .white
            viewTwo.backgroundColor = .white
            viewThree.backgroundColor = .white
            viewFour.backgroundColor = .white
            
            if childrenCount == 1 {
                viewOne.backgroundColor = UIColor(named: "App Branding Blue")
            }
            else if childrenCount == 2 {
                viewTwo.backgroundColor = UIColor(named: "App Branding Blue")
            }
            else if childrenCount == 3 {
                viewThree.backgroundColor = UIColor(named: "App Branding Blue")
            }
            else if childrenCount == 4 {
                viewFour.backgroundColor = UIColor(named: "App Branding Blue")
            }
            print(self.parent?.children.count)
        }
    }
    var firstChild: PersonalInfoChildVC = .currentTaxResidentDetailVC
    var isPersonalInformationBaseViewLoaded = false
    var isEditFromReviewDetailsViewController = false
    var forViewController = ""
    
    var forViewControllerFromChild = ""
    
    override func viewWillAppear(_ animated: Bool) {
        print("Print LLLLL")
        isPersonalInformationBaseViewLoaded = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        isPersonalInformationBaseViewLoaded = false
    }
    override func viewDidLoad() {
        childrenCount = 1
        super.viewDidLoad()
        switch firstChild {
        case .fatcaVC:
            addFATCAVCChild(fromViewController: "")
        case .personalInfoSecondVC:
            addPersonalInfoSecondVCChild(fromViewController: "")
        case .personalInfoThirdVC:
            addPersonalInfoThirdVCChild(fromViewController: "")
        case .serviceChannelVC:
            addServiceChannelVCChild(fromViewController: "")
        case .pictureAndSignVC:
            addPictureAndSignatureVCChild(fromViewController: "")
        case .remittanceDetailVC:
            addRemitterDetailVCChild(fromViewController: "")
        case .taxResidentDetailVC:
            addTaxResidentDetailVCChild(fromViewController: "")
        case .additionalApplicationDetailsVC:
            addAdditionalApplicantDetailsVCChild(fromViewController: "")
        case .nationalityVC:
            addNationalityVCChild(fromViewController: "")
        case .transactionalAlertsVC:
            addTransactionalAlertsVCChild(fromViewController: "")
        case .nextOfKinVC:
            addNextOfKinVCChild()
        case .currentTaxResidentDetailVC:
            addCurrentTaxResidentDetailVC(fromViewController: "")
        case .taxResidentailDetailVC:
            addTaxResidentDetailVCChild(fromViewController: "")
        case .registerPermanentAddress:
            addRegisterPermanentAddressVCChild(fromViewController: "")
        }
    }
    func removeChild() {
        childrenCount! -= 1
    }
    func setSelection() {
        childrenCount! += 1
    }
    
    
    override func viewDidLayoutSubviews() {
        navigationController?.navigationBar.isHidden = true
    }

    
    private func addPersonalInfoSecondVCChild(fromViewController: String){
        print("asdfasdf")
        guard let personalInformationSecondVC = UIStoryboard.initialize(
            viewController: .personalInformationSecondVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationSecondVC else { return }
        
        childContainerView.frame = personalInformationSecondVC.view.frame
        personalInformationSecondVC.isEditFromReviewDetailsViewController = isEditFromReviewDetailsViewController
        personalInformationSecondVC.forViewController = forViewController
        
        add(personalInformationSecondVC, to: childContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            personalInformationSecondVC.delegate = self
        }
    }
    
    private func addPersonalInfoThirdVCChild(fromViewController: String){
        print("asdfasdf")
        guard let personalInformationThirdVC = UIStoryboard.initialize(
            viewController: .personalInformationThirdVC,
            fromStoryboard: .openAccount
        ) as? PersonalInformationThirdVC else { return }
        childContainerView.frame = personalInformationThirdVC.view.frame
        personalInformationThirdVC.isEditFromReviewDetailsViewController = isEditFromReviewDetailsViewController
        personalInformationThirdVC.forViewController = forViewController
        
        add(personalInformationThirdVC, to: childContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            personalInformationThirdVC.delegate = self
        }
    }
    
    private func addOccupationVCChild(fromViewController: String){
        
        guard let occupationVC = UIStoryboard.initialize(
            viewController: .occupationVC,
            fromStoryboard: .openAccount
        ) as? OccupationVC else { return }
        occupationVC.isEditFromReviewDetailsViewController = isEditFromReviewDetailsViewController
        occupationVC.forViewController = forViewController
        childContainerView.frame = occupationVC.view.frame
        add(occupationVC, to: childContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            occupationVC.delegate = self
        }
    }
    
    private func addServiceChannelVCChild(fromViewController: String){
        
        guard let serviceChannelVC = UIStoryboard.initialize(
            viewController: .serviceChannelsVC,
            fromStoryboard: .openAccount
        ) as? ServiceChannelsVC else { return }
        
        childContainerView.frame = serviceChannelVC.view.frame
        add(serviceChannelVC, to: childContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            serviceChannelVC.delegate = self
        }
    }
    
    private func addPictureAndSignatureVCChild(fromViewController: String){
        
        guard let pictureAndSignVC = UIStoryboard.initialize(
            viewController: .pictureAndSignatureVC,
            fromStoryboard: .openAccount
        ) as? PictureAndSignatureVC else { return }
        
        childContainerView.frame = pictureAndSignVC.view.frame
        add(pictureAndSignVC, to: childContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            pictureAndSignVC.delegate = self
        }
    }
    

    private func addFATCAVCChild(fromViewController: String) {
        
        guard let fatcaDetailsVC = UIStoryboard.initialize(
            viewController: .fatcaDetailsVC,
            fromStoryboard: .freelancer
        ) as? FATCADetailsViewController else { return }
        fatcaDetailsVC.delegate = self
        fatcaDetailsVC.forViewController = forViewController
        fatcaDetailsVC.fromViewController = fromViewController
        fatcaDetailsVC.isEditFromReviewDetailsViewController = isEditFromReviewDetailsViewController
        childContainerView.frame = fatcaDetailsVC.view.frame
        add(fatcaDetailsVC, to: childContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            fatcaDetailsVC.delegate = self
        }
    }

    private func addTaxResidentDetailVCChild(fromViewController: String){
        
        guard let taxResidentDetailVC = UIStoryboard.initialize(
            viewController: .taxResidentDetailVC,
            fromStoryboard: .remittanceAccount
        ) as? TaxResidentDetailVC else { return }
        
        childContainerView.frame = taxResidentDetailVC.view.frame
        add(taxResidentDetailVC, to: childContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            taxResidentDetailVC.delegate = self
        }
    }
    
    private func addRegisterPermanentAddressVCChild(fromViewController: String){
        
        guard let registerPermanentAddressVC = UIStoryboard.initialize(
            viewController: .registerPermanentAddress,
            fromStoryboard: .openAccount
        ) as? RegisterPermanentAddressViewController else { return }
        
        childContainerView.frame = registerPermanentAddressVC.view.frame
        
        registerPermanentAddressVC.isEditFromReviewDetailsViewController = isEditFromReviewDetailsViewController
        registerPermanentAddressVC.forViewController = forViewController
        add(registerPermanentAddressVC, to: childContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            registerPermanentAddressVC.delegate = self
        }
    }
    
    private func addRemitterDetailVCChild(fromViewController: String){
        guard let remitterDetailVC = UIStoryboard.initialize(
            viewController: .remitterDetailVC,
            fromStoryboard: .remittanceAccount
        ) as? RemitterDetailVC else { return }
        
        childContainerView.frame = remitterDetailVC.view.frame
        add(remitterDetailVC, to: childContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            remitterDetailVC.delegate = self
        }
    }
    
    private func addAdditionalApplicantDetailsVCChild(fromViewController: String) {
        guard let additionalApplicantDetailsVC = UIStoryboard.initialize(
            viewController: .additionalApplicantDetailsVC,
            fromStoryboard: .openAccount
        ) as? AdditionalApplicantDetailsVC else { return }
        
        childContainerView.frame = additionalApplicantDetailsVC.view.frame
        add(additionalApplicantDetailsVC, to: childContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            additionalApplicantDetailsVC.delegate = self
        }
    }
    
    private func addNationalityVCChild(fromViewController: String){
        guard let nationalityVC = UIStoryboard.initialize(
            viewController: .nationalityVC,
            fromStoryboard: .currentAccount
        ) as? NationalityVC else { return }
        
        childContainerView.frame = nationalityVC.view.frame
        nationalityVC.isEditFromReviewDetailsViewController = isEditFromReviewDetailsViewController
        nationalityVC.forViewController = forViewController
        
        add(nationalityVC, to: childContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            nationalityVC.delegate = self
        }
    }
    
    private func addTransactionalAlertsVCChild(fromViewController: String) {
        guard let transactionalAlertsVC = UIStoryboard.initialize(
            viewController: .transactionalAlertsVC,
            fromStoryboard: .currentAccount
        ) as? TransactionalAlertsVC else { return }
        childContainerView.frame = transactionalAlertsVC.view.frame
        add(transactionalAlertsVC, to: childContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            transactionalAlertsVC.delegate = self
        }
    }
    
    private func addNextOfKinVCChild() {
        guard let nextOfKinVC = UIStoryboard.initialize(
            viewController: .nextOfKinVC,
            fromStoryboard: .currentAccount
        ) as? NextOfKinVC else { return }
        
        childContainerView.frame = nextOfKinVC.view.frame
        add(nextOfKinVC, to: childContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            nextOfKinVC.delegate = self
        }
    }
    
    private func addCurrentTaxResidentDetailVC(fromViewController: String) {
        guard let currentTaxResidentDetailVC = UIStoryboard.initialize(
            viewController: .currentTaxResidentDetailVC,
            fromStoryboard: .remittanceAccount
        ) as? CurrentTaxResidentDetailVC else { return }
        
        childContainerView.frame = currentTaxResidentDetailVC.view.frame
        add(currentTaxResidentDetailVC, to: childContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // your code here
            currentTaxResidentDetailVC.delegate = self
        }
    }
    
}

extension PersonalInformationBaseVC: PersonalInfoChildToParentProtocol {
    func addChild(vc: PluginViewController, fromViewController: String) {
        setSelection()
        if vc == .personalInformationSecondVC{
            addPersonalInfoSecondVCChild(fromViewController: fromViewController)
        }else if vc == .personalInformationThirdVC{
            addPersonalInfoThirdVCChild(fromViewController: fromViewController)
        }else if vc == .occupationVC{
            addOccupationVCChild(fromViewController: fromViewController)
        }else if vc == .serviceChannelsVC{
            addServiceChannelVCChild(fromViewController: fromViewController)
        }else if vc == .pictureAndSignatureVC{
            addPictureAndSignatureVCChild(fromViewController: fromViewController)
        }else if vc == .fatcaDetailsVC{
            addFATCAVCChild(fromViewController: fromViewController)
        }else if vc == .remitterDetailVC{
            addRemitterDetailVCChild(fromViewController: fromViewController)
        }else if vc == .registerPermanentAddress{
            addRegisterPermanentAddressVCChild(fromViewController: fromViewController)
        }else if vc == .nationalityVC{
            addNationalityVCChild(fromViewController: fromViewController)
        }else if vc == .taxResidentDetailVC{
            addTaxResidentDetailVCChild(fromViewController: fromViewController)
        } else if vc == .remitterDetailVC{
            addTaxResidentDetailVCChild(fromViewController: fromViewController)
        }
        
    }
    
//    func addChild(vc: PluginViewController) {
//        setSelection()
//        if vc == .personalInformationSecondVC{
//            addPersonalInfoSecondVCChild()
//        }else if vc == .personalInformationThirdVC{
//            addPersonalInfoThirdVCChild()
//        }else if vc == .occupationVC{
//            addOccupationVCChild()
//        }else if vc == .serviceChannelsVC{
//            addServiceChannelVCChild()
//        }else if vc == .pictureAndSignatureVC{
//            addPictureAndSignatureVCChild()
//        }else if vc == .fatcaDetailsVC{
//            addFATCAVCChild()
//        }else if vc == .remitterDetailVC{
//            addRemitterDetailVCChild()
//        }else if vc == .registerPermanentAddress{
//            addRegisterPermanentAddressVCChild()
//        }else if vc == .nationalityVC{
//            addNationalityVCChild()
//        }else if vc == .taxResidentDetailVC{
//            addTaxResidentDetailVCChild()
//        } else if vc == .remitterDetailVC{
//            addTaxResidentDetailVCChild()
//        }
//    }
}
//case taxResidentDetailVC = "TaxResidentDetailVC"
//case remitterDetailVC = "RemitterDetailVC"
