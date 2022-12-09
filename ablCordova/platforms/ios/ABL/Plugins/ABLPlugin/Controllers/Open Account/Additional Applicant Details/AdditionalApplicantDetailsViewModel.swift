//
//  AdditionalApplicantDetailsViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 09/05/2022.
//

import Foundation

protocol AdditionalApplicantDetailsViewModelProtocol {
    var relationships: Observable<CodeTypeResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    var dropdownTapped: Observable<Bool> { get }
    
    func getAdditionalApplicantRelationships(codeTypeID: Double)
    func getRelationship(for index: Int) -> CodeTypeDataModel?
    func setSelectedRelationship(data: CodeTypeDataModel?)
    func getSelectedRelationship() -> CodeTypeDataModel?
}

final class AdditionalApplicantDetailsViewModel: AdditionalApplicantDetailsViewModelProtocol {
    private(set) var relationships: Observable<CodeTypeResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    private(set) var dropdownTapped: Observable<Bool> = Observable(false)
    
    private var selectedRelationship: CodeTypeDataModel?
    
    func getAdditionalApplicantRelationships(codeTypeID: Double) {
        guard let input = CodeTypeInputModel(codeTypeID: Int(codeTypeID)) else { return }
        
        APIManager.shared.lookupInformation(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.relationships.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func getRelationship(for index: Int) -> CodeTypeDataModel? {
        return relationships.value?.data?[index]
    }
    
    func setSelectedRelationship(data: CodeTypeDataModel?) {
        selectedRelationship = data
    }
    
    func getSelectedRelationship() -> CodeTypeDataModel? {
        return selectedRelationship
    }
    
    @objc
    func openDropdown() {
        dropdownTapped.value = true
    }
}
