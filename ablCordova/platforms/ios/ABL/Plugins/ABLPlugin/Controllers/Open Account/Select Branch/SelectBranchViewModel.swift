//
//  SelectBranchViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 31/03/2022.
//

import Foundation
import CoreLocation

protocol SelectBranchViewModelProtocol {
    var branches: Observable<BranchResponseModel?> { get }
    var bankingModeID: Double? { get }
    var accountTypeID: Double? { get }
    var userLocation: Observable<CLLocation?> { get }
    var locationDenied: Observable<Bool> { get }
    var errorMessage: Observable<String?> { get }
    
    func setBankingModeID(id: Double)
    func setAccountTypeID(id: Double)
    
    func getBranches(
        branchName: String,
        categoryType: String,
        latitude: String,
        longitude: String,
        distance: String
    )
    
    func locationAuthorization()
}

final class SelectBranchViewModel: NSObject, SelectBranchViewModelProtocol {
    private(set) var branches: Observable<BranchResponseModel?> = Observable(nil)
    private(set) var bankingModeID: Double?
    private(set) var accountTypeID: Double?
    private(set) var userLocation: Observable<CLLocation?> = Observable(nil)
    private(set) var locationDenied: Observable<Bool> = Observable(false)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    
    private let locationManager = CLLocationManager()
    
    func setBankingModeID(id: Double) {
        bankingModeID = id
    }
    
    func setAccountTypeID(id: Double) {
        accountTypeID = id
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
    
    func locationAuthorization() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        guard CLLocationManager.locationServicesEnabled() else {
            // Present authorization alert here
            return
        }
        
        locationManager.requestAlwaysAuthorization()
    }
}

extension SelectBranchViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation.value = location
        locationManager.stopUpdatingLocation()
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
            locationManager.requestLocation()
        case .restricted, .denied:
            locationDenied.value = true
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            errorMessage.value = "There was an unknown error while requesting location"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        errorMessage.value = error.localizedDescription
        logsManager.debug(error)
    }
}
