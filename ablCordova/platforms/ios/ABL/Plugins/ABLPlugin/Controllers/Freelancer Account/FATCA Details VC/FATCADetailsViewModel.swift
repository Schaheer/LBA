//
//  FATCADetailsViewModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/27/22.
//

import Foundation

protocol FATCADetailsViewModelProtocol{
    
    var registerFACTAInfoResponse: Observable<RegisterFACTAInfoResponseModel?> { get }
//    var questionsList: Observable<[FATCAQuestion]?> { get }
    var errorMessage: Observable<String?> { get }
    
}

class FATCADetailsViewModel: FATCADetailsViewModelProtocol{
    
    
    private(set) var registerFACTAInfoResponse: Observable<RegisterFACTAInfoResponseModel?> = Observable(nil)
//    private(set) var questionsList: Observable<[FATCAQuestion]?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)

    var questionsList: [FATCAQuestion] = [
        
        FATCAQuestion(question: "Are you a U.S. Tax Resident?", isYes: false),
        FATCAQuestion(question: "Are you a U.S. Citizen? ", isYes: false),
        FATCAQuestion(question: "Do you have any “in-care-of” or “hold mail” address?", isYes: false),
        FATCAQuestion(question: "Is your place of birth in the U.S. or in any U.S. territory?", isYes: false),
        FATCAQuestion(question: "Do you intend to issue any standing instructions for transfer of funds to U.S. or U.S. overseas territory?", isYes: false),
        FATCAQuestion(question: "Are you holding a U.S Permanent Resident Card (Green Card Holder)?", isYes: false),
        FATCAQuestion(question: "Have you issued any Attorney / Operating Authority to USA Citizen/ Green Card Holder / or a person with US address/ phone number ?", isYes: false),
    ]
    
    func registerFATCADetails(
        attorneyInd: Int?,
        birthUSInd: Int?,
        careAddrInd: Int?,
        greenCardHolderInd: Int?,
        rdaCustomerId: Double?,
        usCitizenInd: Int?,
        usMailAddrInd: Int?,
        usTaxResidentInd: Int?
        
    ) {
        guard
            let attorneyInd = attorneyInd,
            let rdaCustomerId = rdaCustomerId,
            let birthUSInd = birthUSInd,
            let careAddrInd = careAddrInd,
            let greenCardHolderInd = greenCardHolderInd,
            let usCitizenInd = usCitizenInd,
            let usMailAddrInd = usMailAddrInd,
            let usTaxResidentInd = usTaxResidentInd
        else { return }
        guard let FATCAQuestionsInfo = FatcaReqDtoList(attorneyInd: attorneyInd, birthUSInd: birthUSInd, careAddrInd: careAddrInd, greenCardHolderInd: greenCardHolderInd, rdaCustomerId: rdaCustomerId, usCitizenInd: usCitizenInd, usMailAddrInd: usMailAddrInd, usTaxResidentInd: usTaxResidentInd) else { return }
        guard let registerFATCAInfo = RegisterFACTAInfoInputModel(fatcaReqDtoList: [FATCAQuestionsInfo]) else { return }
        
        APIManager.shared.regiaterFACTAInfo(input: registerFATCAInfo) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.registerFACTAInfoResponse.value = value
                
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func getFATCAQuestions() -> [FATCAQuestion]{
        
//        let question1 = FATCAQuestion(question: "Are you a U.S. Tax Resident?", isYes: false)
//        let question2 = FATCAQuestion(question: "Are you a U.S. Citizen? ", isYes: false)
//        let question3 = FATCAQuestion(question: "Do you have any “in-care-of” or “hold mail” address?", isYes: false)
//        let question4 = FATCAQuestion(question: "Is your place of birth in the U.S. or in any U.S. territory?", isYes: false)
//        let question5 = FATCAQuestion(question: "Do you intend to issue any standing instructions for transfer of funds to U.S. or U.S. overseas territory?", isYes: false)
//        let question6 = FATCAQuestion(question: "Are you holding a U.S Permanent Resident Card (Green Card Holder)?", isYes: false)
//        let question7 = FATCAQuestion(question: "Have you issued any Attorney / Operating Authority to USA Citizen/ Green Card Holder / or a person with US address/ phone number ?", isYes: false)
//        questionsList.value?.append(question1)
//        questionsList.value?.append(question2)
//        questionsList.value?.append(question3)
//        questionsList.value?.append(question4)
//        questionsList.value?.append(question5)
//        questionsList.value?.append(question6)
//        questionsList.value?.append(question7)
        return questionsList
    }
    
    func toggleAnsewer(at index: Int){
        
        questionsList[index].isYes = !questionsList[index].isYes
    }
    
    func getAnswer(at index: Int) -> Bool{
        
        return questionsList[index].isYes
    }
}
