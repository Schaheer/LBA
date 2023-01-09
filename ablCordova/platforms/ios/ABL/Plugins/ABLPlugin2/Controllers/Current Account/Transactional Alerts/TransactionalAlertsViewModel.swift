//
//  TransactionalAlertsViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 24/05/2022.
//

import Foundation

protocol TransactionalAlertsViewModelProtocol {
    var registerConsumerAccountInfoResponse: Observable<RegisterConsumerAccountInfoResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    
    func setESOA(eSOA: Int)
    func getESOA() -> Int
    func setTransactionalAlerts(transactionalAlerts: Int)
    func getTransactionalAlerts() -> Int
    func setTransactionalAlertID(id: Double)
    func getTransactionalAlertID() -> Double
    
    func registerConsumerAccountInfo(
        rdaCustomerAccountInfoID: Double?,
        rdaCustomerID: Double?,
        customerTypeID: Double?,
        eSOAInd: Int,
        transAlertInd: Int,
        transactionalAlertID: Double,
        genderId: Int
    )
}

final class TransactionalAlertsViewModel: TransactionalAlertsViewModelProtocol {
    private(set) var registerConsumerAccountInfoResponse: Observable<RegisterConsumerAccountInfoResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    
    private var eSOARequired = 0
    private var transactionalAlertsRequired = 0
    private var transactionalAlertID: Double = 10
    
    func setESOA(eSOA: Int) {
        eSOARequired = eSOA
    }
    
    func getESOA() -> Int {
        return eSOARequired
    }
    
    func setTransactionalAlerts(transactionalAlerts: Int) {
        transactionalAlertsRequired = transactionalAlerts
    }
    
    func getTransactionalAlerts() -> Int {
        return transactionalAlertsRequired
    }
    
    func setTransactionalAlertID(id: Double) {
        transactionalAlertID = id
    }
    
    func getTransactionalAlertID() -> Double {
        return transactionalAlertID
    }
    
    func registerConsumerAccountInfo(
        rdaCustomerAccountInfoID: Double?,
        rdaCustomerID: Double?,
        customerTypeID: Double?,
        eSOAInd: Int,
        transAlertInd: Int,
        transactionalAlertID: Double,
        genderId: Int
    ) {
        guard
            let rdaCustomerAccountInfoID = rdaCustomerAccountInfoID,
            let rdaCustomerID = rdaCustomerID,
            let customerTypeID = customerTypeID
        else { return }
        
        guard let input = RegisterConsumerAccountInfoInputModel(
            rdaCustomerAccInfoID: rdaCustomerAccountInfoID,
            rdaCustomerID: Int(rdaCustomerID),
            customerTypeID: customerTypeID,
            transAlertInd: transAlertInd,
            transactionalAlertID: transactionalAlertID,
            eSOAInd: eSOAInd
//            genderId: genderId
        ) else { return }
        
        APIManager.shared.registerConsumerAccountInfo(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.registerConsumerAccountInfoResponse.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
}
