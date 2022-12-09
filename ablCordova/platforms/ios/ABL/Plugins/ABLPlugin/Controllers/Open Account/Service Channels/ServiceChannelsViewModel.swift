//
//  ServiceChannelsViewModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/18/22.
//

import Foundation

protocol ServiceChannelsViewModelProtocol{
    
    var registerConsumerTransactionDetailsResponse: Observable<ConsumerTransactionDetailsResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    var atmTypes: Observable<CodeTypeResponseModel?> { get }
    var selectedAtmTypeID: Observable<Double?> { get }
    
    func getATMTypes(codeTypeID: Int)
    func getAccountVariantID() -> Double
}



class ServiceChannelsViewModel{
    
    private(set) var registerConsumerTransactionDetailsResponse: Observable<ConsumerTransactionDetailsResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    private(set) var atmTypes: Observable<CodeTypeResponseModel?> = Observable(nil)
    private(set) var selectedAtmTypeID: Observable<Double?> = Observable(nil)
    
    func registerConsumerEmploymentDetails(
        customerAccInfoID: Double?,
        rdaCustomerId: Double?,
        customerTypeId: Double?,
        atmTypeId: Double?,
        transAlertInd: Int?,
        chequeBookReqInd: Int?,
        transactionalAlertId: Double?,
        rdaCustomerProfileId: Double?
        
    ) {
        guard
            let customerAccInfoID = customerAccInfoID,
            let rdaCustomerId = rdaCustomerId,
            let customerTypeId = customerTypeId,
            let atmTypeId = atmTypeId,
            let transAlertInd = transAlertInd,
            let chequeBookReqInd = chequeBookReqInd,
            let transactionalAlertId = transactionalAlertId,
            let rdaCustomerProfileId = rdaCustomerProfileId
        else {
            
            self.errorMessage.value = "All fields are required"
            return
            
        }
        
        guard let transactionDetailsData = SetupTransactionDataInputModel(rdaCustomerAccInfoId: customerAccInfoID, rdaCustomerId: rdaCustomerId, customerTypeId: customerTypeId, atmTypeId: atmTypeId, transAlertInd: transAlertInd, chequeBookReqInd: chequeBookReqInd, transactionalAlertId: transactionalAlertId,rdaCustomerProfileId:rdaCustomerProfileId ) else { return }
        guard let transactionDetailsInput = SetupTransactionsInputModel(consumerList: [transactionDetailsData]) else { return }
        
        APIManager.shared.setupConsumerTransactionDetails(input: transactionDetailsInput) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.registerConsumerTransactionDetailsResponse.value = value
                
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    
    func getATMTypes(codeTypeID: Int) {
        
        guard let input = CodeTypeInputModel(codeTypeID: codeTypeID) else { return }
        
        APIManager.shared.lookupInformation(input: input) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let value):
                self.atmTypes.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func setSelectedATMTypeID(accountVariantID: Double) {
        self.selectedAtmTypeID.value = accountVariantID
    }
    
    func getSelectedATMTypeID() -> Double?{
        
        return selectedAtmTypeID.value
    }
    
    
}
