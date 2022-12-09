//
//  RegisterPermanentAddressViewModel.swift
//  ABL
//
//  Created by Hamza Amin on 5/24/22.
//

//protocol PermanentAddressViewModelProtocol{
//    
//    var registerMailAddressResponse: Observable<RegisterMailAddressResponseModel?> { get }
//    var registerConsumerAddressResponse: Observable<RegisterConsumerAddressResponseModel?> { get }
//    var errorMessage: Observable<String?> { get }
//}
//
//class RegisterPermanentAddressViewModel: PermanentAddressViewModelProtocol {
//    
//    private(set) var registerMailAddressResponse: Observable<RegisterMailAddressResponseModel?> = Observable(nil)
//    private(set) var registerConsumerAddressResponse: Observable<RegisterConsumerAddressResponseModel?> = Observable(nil)
//    private(set) var errorMessage: Observable<String?> = Observable(nil)
//    
//    
//    
//    func registerConsumerAddress(
//        rdaCustomerId: Double?,
//        nearestLandMark: String?,
//        customerAddress: String?,
//        city: String?,
//        addressTypeId: Double?,
//        countryId: Double?,
//        rdaCustomerProfileAddrId: Double?,
//        postalCode: String?,
//        phone: String?,
//        mobileNo: String?,
//        customerTown: String?,
//        countryCodeMobile: String?,
//        country: String?,
//        addressTypeForeignInd: Bool?,
//        emailAddress: String?,
//        phoneNumber: String?
//    ) {
//        guard
//            let rdaCustomerId = rdaCustomerId,
//            let nearestLandMark = nearestLandMark,
//            let customerAddress = customerAddress,
//            let city = city,
//            let addressTypeId = addressTypeId,
//            let countryid = countryId,
//            let rdaCustomerProfileAddrId = rdaCustomerProfileAddrId,
//            let postalCode = postalCode,
//            let phone = phone,
//            let mobileNo = mobileNo,
//            let customerTown = customerTown,
//            let countryCodeMobile = countryCodeMobile,
//            let country = country,
//            let addressTypeForeignInd = addressTypeForeignInd,
//            let emailAddress = emailAddress,
//            let phoneNumber = phoneNumber
//        else { return }
//
//        if !nearestLandMark.isEmpty && !customerAddress.isEmpty && !city.isEmpty {
//
//            guard let viewAppGenerateResponseModel = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList else { return }
//            var consumerListInputModelArray = [ConsumerAddressInputModel]()
//            var consumerAddressListInputModelArray = [RegisterConsumerAddressInputModel]()
//            viewAppGenerateResponseModel.forEach { consumerInputModel in
//                guard let addressesList = consumerInputModel.addresses else { return }
//                addressesList.forEach { address in
//                    guard let nearestLandMark = consumerInputModel.nearestLandmark, let customerAddress = address.customerAddress,let city = address.city else { return }
//                    guard let consumerListInputModel = ConsumerAddressInputModel(rdaCustomerId: rdaCustomerId, nearestLandMark: nearestLandMark, customerAddress: customerAddress, city: city, addressTypeId: addressTypeId, countryId: countryid, rdaCustomerProfileAddrId: address.rdaCustomerProfileAddrID, postalCode: address.postalCode, phone: address.phone, mobileNo: address.mobileNo, customerTown: address.customerTown, countryCodeMobile: address.countryCodeMobile, country: address.country, addressTypeForeignInd: address.addressTypeForeignInd, emailAddress: consumerInputModel.emailAddress, phoneNumber: address.mobileNo) else { return }
//
//                    consumerListInputModelArray.append(consumerListInputModel)
//                }
//
//            }
//
//            guard let consumerAddressInput = ConsumerAddressInputModel(rdaCustomerId: rdaCustomerId, nearestLandMark: nearestLandMark, customerAddress: customerAddress, city: city, addressTypeId: addressTypeId, countryId: countryid, rdaCustomerProfileAddrId: rdaCustomerProfileAddrId, postalCode: postalCode, phone: phone, mobileNo: mobileNo, customerTown: customerTown, countryCodeMobile: countryCodeMobile, country: country, addressTypeForeignInd: addressTypeForeignInd, emailAddress: emailAddress, phoneNumber: mobileNo) else {return}
//            consumerListInputModelArray.append(consumerAddressInput)
//            guard let consumerAddressInputList = RegisterConsumerAddressInputModel(addressesList: consumerListInputModelArray, isprimary: true) else {return}
//            APIManager.shared.registerConsumerAddress(input: consumerAddressInputList) { [weak self] response in
//                guard let self = self else { return }
//
//                switch response.result {
//                case .success(let value):
//                    self.registerConsumerAddressResponse.value = value
//
//                case .failure(let error):
//                    self.errorMessage.value = error.errorDescription
//                }
//            }
//        } else {
//            errorMessage.value = "All fields are required"
//        }
//    }
//    
//    
//}

