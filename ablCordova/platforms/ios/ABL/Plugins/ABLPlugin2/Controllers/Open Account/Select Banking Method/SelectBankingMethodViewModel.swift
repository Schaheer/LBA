//
//  SelectBankingMethodViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 30/03/2022.
//

import Foundation
import CoreLocation
import GoogleMaps

protocol SelectBankingMethodViewModelProtocol {
    var bankingMethod: Observable<BankingMethod?> { get }
    var accountType: Observable<AccountType?> { get }
    var routeToSelectBranchVC: Observable<Bool> { get }
    var errorMessage: Observable<String?> { get }
    var userLocation: Observable<CLLocation?> { get }
    var locationDenied: Observable<Bool> { get }
    var branches: Observable<BranchResponseModel?> { get }
    var dropDownTapped: Observable<Bool> { get }
    var branchMarker: Observable<GMSMarker?> { get }
    var tappedMarker: Observable<GMSMarker?> { get }
    var registerVerifyOTPResponse: Observable<RegisterVerifyOTPResponseModel?> { get }
    var routeToSelectAccountTypeVC: Observable<Bool> { get }
    
    func selectIslamicBankingMethod()
    func selectConventionalBankingMethod()
    func selectCurrentAccount()
    func selectSavingsAccount()
    
    func openSelectBranchVC()
    
    func getBankingModeID() -> Double
    func getBankingMode() -> BankingMethod
    func getAccountTypeID() -> Double
    
    func setUserLocation(location: CLLocation)
    func getUserLocation() -> CLLocation?
    
    func locationAuthorization()
    func getBranches(
        branchName: String,
        categoryType: String,
        latitude: String,
        longitude: String,
        distance: String
    )
    func registerVerifyOTP(input: RegisterVerifyOTPInputModel?)
    func createMarker(for branch: BranchListModel)
    func openSelectAccountTypeVC()
    
    func setBranch(name: String)
    func getBranchName() -> String
    
    func setErrorMessage(text: String)
}

final class SelectBankingMethodViewModel: NSObject, SelectBankingMethodViewModelProtocol {
    
    private(set) var bankingMethod: Observable<BankingMethod?> = Observable(nil)
    private(set) var accountType: Observable<AccountType?> = Observable(nil)
    private(set) var routeToSelectBranchVC: Observable<Bool> = Observable(false)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    private(set) var userLocation: Observable<CLLocation?> = Observable(nil)
    private(set) var locationDenied: Observable<Bool> = Observable(false)
    private(set) var branches: Observable<BranchResponseModel?> = Observable(nil)
    private(set) var dropDownTapped: Observable<Bool> = Observable(false)
    private(set) var branchMarker: Observable<GMSMarker?> = Observable(nil)
    private(set) var tappedMarker: Observable<GMSMarker?> = Observable(nil)
    private(set) var registerVerifyOTPResponse: Observable<RegisterVerifyOTPResponseModel?> = Observable(nil)
    private(set) var routeToSelectAccountTypeVC: Observable<Bool> = Observable(false)
    
    private var bankingModeID: Double?
    private var accountTypeID: Double?
    private var branchName = ""
    private var location: CLLocation?
    
    private var locationManager: CLLocationManager?
    
    @objc
    func selectIslamicBankingMethod() {
        bankingMethod.value = .islamic
    }
    
    @objc
    func selectConventionalBankingMethod() {
        bankingMethod.value = .conventional
    }
    
    @objc
    func selectCurrentAccount() {
        accountType.value = .current
    }
    
    @objc
    func selectSavingsAccount() {
        accountType.value = .savings
    }
    
    @objc
    func openDropdown() {
        dropDownTapped.value = true
    }
    
    func openSelectBranchVC() {
        if bankingMethod.value != nil {
            routeToSelectBranchVC.value = true
        } else {
            errorMessage.value = "Please select a Banking Method"
        }
    }
    
    func getBankingModeID() -> Double {
        return bankingMethod.value?.code ?? 0
    }
    
    func getBankingMode() -> BankingMethod {
        return bankingMethod.value ?? .conventional
    }
    
    func getAccountTypeID() -> Double {
        return accountType.value?.code ?? 0
    }
    
    func locationAuthorization() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        guard CLLocationManager.locationServicesEnabled() else {
            locationDenied.value = true
            return
        }
        
        locationManager?.requestAlwaysAuthorization()
    }
    
    func getBranches(
        branchName: String,
        categoryType: String,
        latitude: String,
        longitude: String,
        distance: String
    ) {
        guard let branchInputModel = BranchInputModel(
            branchName: branchName,
            categoryType: categoryType,
            latitude: latitude,
            longitude: longitude,
            distance: distance
        ) else { return }
        
        APIManager.shared.getBranches(input: branchInputModel) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.branches.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func createMarker(for branch: BranchListModel) {
        guard
            let latitude = branch.latitude,
            let longitude = branch.longitude
        else { return }
        
        let marker = GMSMarker(
            position: CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            )
        )
        
        marker.title = branch.branchName
        branchMarker.value = marker
    }
    
    func registerVerifyOTP(input: RegisterVerifyOTPInputModel?) {
        guard let input = input else { return }
        
        APIManager.shared.registerVerifyOTP(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.registerVerifyOTPResponse.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func openSelectAccountTypeVC() {
        routeToSelectAccountTypeVC.value = true
    }
    
    func setBranch(name: String) {
        branchName = name
    }
    
    func getBranchName() -> String {
        return branchName
    }
    
    func setUserLocation(location: CLLocation) {
        self.location = location
    }
    
    func getUserLocation() -> CLLocation? {
        return location
    }
    
    func setErrorMessage(text: String) {
        errorMessage.value = text
    }
}

extension SelectBankingMethodViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation.value = location
        locationManager?.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        var authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = manager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager?.requestLocation()
        case .restricted, .denied:
            locationDenied.value = true
        case .authorizedAlways:
            locationManager?.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
        @unknown default:
            errorMessage.value = "There was an unknown error while requesting location"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        logsManager.debug(error)
    }
}

extension SelectBankingMethodViewModel: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        tappedMarker.value = marker
        return true
    }
}
