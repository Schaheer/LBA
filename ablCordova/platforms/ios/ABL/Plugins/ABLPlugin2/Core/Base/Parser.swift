//
//  Parser.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import Foundation
import Alamofire
import ObjectMapper

typealias BaseResponseMappable = BaseMappable

final class Parser: NSObject {
    
    /// This method is responsible for parsing the response of a request in which a single object is returned
    ///
    /// - Parameters:
    ///   - response: Incomming response object of generic AFDataResponse type
    ///   - completionHandler: completionHandler for call back
    class func parseResponse<T: BaseResponseMappable>(
        response: AFDataResponse<T>,
        isDebugging: Bool = false,
        showLoader: Bool = true,
        requestTime: TimeInterval? = nil,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) {
        
        if showLoader {
            ActivityIndicatorView.shared.stopAnimating()
        }
        print(response)
        checkForDebuggingLogs(isDebuging: isDebugging, requestTime: requestTime, response: response)
        
        switch response.result {
        case .success(let object):

            guard let _ = object as? BaseResponseModel else {
                return completionHandler(response)
            }
            
            completionHandler(response)
            
        case .failure(_): // completion handler is not called, need to dig the use case
            
            if let errorJSON = response.data?.JSON() {
                if let baseResponseModel = Mapper<BaseResponseModel>().map(JSON: errorJSON) {
                    AlertManager.shared.showOKAlert(
                        with: "Error",
                        message: baseResponseModel.message?.description ?? "Internal server error occured, please try again."
                    )
                }
            }
        }
    }
    
    /// This method will print the request logs if Debugging is enabled
    /// - Parameters:
    ///   - isDebuging: debugging flag
    ///   - response: incomming response object of generic DataResponse type
    class func checkForDebuggingLogs<T: BaseResponseMappable>(
        isDebuging: Bool = false,
        requestTime: TimeInterval? = nil,
        response: AFDataResponse<T>
    ) {
        if isDebuging {
            
            switch response.result {
            case .success:
                logsManager.logRequest(response: response, requestTime: requestTime, successFlag: true)
                
            case .failure:
                logsManager.logRequest(response: response, requestTime: requestTime, successFlag: false)
            }
        }
    }
    
//    class func parseResponseMessage<T: BaseResponseMappable>(response: AFDataResponse<T>) -> String {
//
//        let responseToJSON = response.data?.JSON()
//        guard let message = responseToJSON?["message"] as? String else { return BaseConstants.ErrorConstants.unknownError.rawValue }
//
//        return message
//    }
}
