//
//  FATCADetailsViewController.swift
//  ABL
//
//  Created by Hamza Amin on 4/26/22.
//

import UIKit
import BetterSegmentedControl

struct FATCAQuestion{
    
    let question: String
    var isYes: Bool
}

class FATCADetailsViewController: UIViewController {

    @IBOutlet weak var questionsTableView: UITableView!
    var fromViewController = String()
    var isEditFromReviewDetailsViewController = false
    var forViewController = ""
    private let fatcaDetailsViewModel = FATCADetailsViewModel()
    weak var delegate: PersonalInfoChildToParentProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        subscribeViewModel()

        // Do any additional setup after loading the view.
    }
    
    private func setupTableView(){
        let questionsNib = UINib(nibName: PluginNibs.fatcaTVC.rawValue, bundle: nil)
        questionsTableView.register(questionsNib, forCellReuseIdentifier: PluginTableViewCells.fatcaTVC.rawValue)
        questionsTableView.delegate = self
        questionsTableView.dataSource = self
        print(fatcaDetailsViewModel.getFATCAQuestions().count, "fatcaDetailsViewModel.getFATCAQuestions().count...")
        questionsTableView.reloadData()
    }

    private func subscribeViewModel() {
        fatcaDetailsViewModel.registerFACTAInfoResponse.bind { [weak self]  response  in
            guard let status = response?.message?.status, let description = response?.message?.description?.lowercased() else { return }
            if status == "200" && description.lowercased() == "success"{
                guard let personalInformationBaseVC = UIStoryboard.initialize(
                    viewController: .personalInformationBaseVC,
                    fromStoryboard: .openAccount
                ) as? PersonalInformationBaseVC else { return }
                
                if self?.isEditFromReviewDetailsViewController ?? false && self?.forViewController == "FATCADetailsViewController" {
                    self?.dismissToViewController(viewController: ReviewDetailsVC.self)
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifierRefreshReviewDetailsVC"), object: nil)
                    }
                }
                switch modelRegistrationSteper.selectPreferredAccountViewModel?.getAccountVariantID() {
                case .freelancerDigitalAccount:
                    self?.delegate?.addChild(vc: .personalInformationSecondVC, fromViewController: "")
                default:
                    self?.delegate?.addChild(vc: .reviewDetailsVC, fromViewController: "")
                }
            }
        }
        
        fatcaDetailsViewModel.errorMessage.bind {  error in
            guard let error = error else { return }
            AlertManager.shared.showOKAlert(with: "Error", message: error)
        }
        
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton){
        if isEditFromReviewDetailsViewController && forViewController == "FATCADetailsViewController" {
            self.dismissToViewController(viewController: ReviewDetailsVC.self)
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("NotificationIdentifierRefreshReviewDetailsVC"), object: nil)
            }
        }
        else {
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
    
    @IBAction func nextBtnTapped(_ sender: UIButton){
//        if isEditFromReviewDetailsViewController && forViewController == "FATCADetailsViewController" {
//            self.dismissToViewController(viewController: ReviewDetailsVC.self)
//            DispatchQueue.main.async {
//                NotificationCenter.default.post(name: Notification.Name("NotificationIdentifierRefreshReviewDetailsVC"), object: nil)
//            }
//        }
//        else {
//            if fromViewController == "TaxResidentDetailVC" {
//                delegate?.addChild(vc: .personalInformationSecondVC, fromViewController: "")
//            }
//            else {
//                delegate?.addChild(vc: .serviceChannelsVC, fromViewController: "")
//            }
//        }
        fatcaDetailsViewModel.registerFATCADetails(
            attorneyInd: fatcaDetailsViewModel.getAnswer(at: 6).intValue,
            birthUSInd: fatcaDetailsViewModel.getAnswer(at: 3).intValue,
            careAddrInd: fatcaDetailsViewModel.getAnswer(at: 2).intValue,
            greenCardHolderInd: fatcaDetailsViewModel.getAnswer(at: 5).intValue,
            rdaCustomerId: BaseConstants.Config.rdaCustomerId,
            usCitizenInd: fatcaDetailsViewModel.getAnswer(at: 1).intValue,
            usMailAddrInd: fatcaDetailsViewModel.getAnswer(at: 4).intValue,
            usTaxResidentInd: fatcaDetailsViewModel.getAnswer(at: 0).intValue)
        
        
    }
}

extension FATCADetailsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return fatcaDetailsViewModel.getFATCAQuestions().count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FATCATableViewCell.identifier) as! FATCATableViewCell
            cell.loadCell(with: fatcaDetailsViewModel.getFATCAQuestions()[indexPath.row])
            cell.answerSwitch.tag = indexPath.row
            cell.answerSwitch.addTarget(self, action: #selector(answerSwitchTapped), for: .valueChanged)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell")!
            
            return cell
        }
    }
    
    @objc func answerSwitchTapped(_ sender: BetterSegmentedControl){
        
        fatcaDetailsViewModel.toggleAnsewer(at: sender.tag)
        print(fatcaDetailsViewModel.getAnswer(at: sender.tag), "fatcaDetailsViewModel.getAnswer(at: sender.tag)")
        
    }
    
}

