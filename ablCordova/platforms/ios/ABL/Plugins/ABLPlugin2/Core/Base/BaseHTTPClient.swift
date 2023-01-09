//
//  BaseHTTPClient.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import Foundation
import Alamofire


class BaseHTTPClient: NSObject {
    
    // MARK: - Properties
    
    var parameters: [String: Any]
    private var headers: HTTPHeaders
    
    var sessionManager = Session(configuration: .default)
        
    override init() {
        parameters = [String: Any]()
        headers = HTTPHeaders()
        let manager = ServerTrustManager(evaluators: [BaseConstants.BaseURL.qaServer.rawValue: DisabledTrustEvaluator()])
        sessionManager = Session(serverTrustManager: manager)
    }
    
    // MARK: - Helper Methods
    
    /// This method will return the complete Request URL String
    ///
    /// - Parameters:
    ///   - endPoint: End point of request
    ///   - ignoreBaseUrl: Bool flag to ignore Base URL
    /// - Returns: URL String
    
    private func getRequestURL(endPoint: String, ignoreBaseUrl: Bool = false) -> String {
        var urlString = ""
        
        if !ignoreBaseUrl {
            urlString = BaseConstants.BaseURL.value()
        }
        
        return (urlString + endPoint).constructURL()
    }
    
    /// This method will clear all the parameters in the dictionary.
    
    func clearParameters() {
        parameters = [String: Any]()
    }
    
    // MARK: - Get Method
    
    /// This is a generic web service method of type 'GET'  with parameters as query string.
    ///
    /// - Parameters:
    ///   - endPoint: Service end point
    ///   - ignoreBaseUrl: Flag to ignore the base url
    ///   - completionHandler: Generic call back completion handler
    
    func executeGet<T: BaseResponseMappable>(
        endPoint: String,
        ignoreBaseURL: Bool = false,
        isDebugging: Bool = true,
        showLoader: Bool = true,
        completion: @escaping (AFDataResponse<T>) -> Void
    ) {
        if Reachability.isConnectedToNetwork() {
            if showLoader {
                ActivityIndicatorView.shared.startAnimating()
            }
            
            headers = HTTPHeaders(DataCacheManager.shared.getAuthHeaders())
            
            let url = getRequestURL(endPoint: endPoint, ignoreBaseUrl: ignoreBaseURL)
            let request = sessionManager.request(
                url,
                method: .get,
                parameters: parameters,
                encoding: URLEncoding.queryString,
                headers: headers
            )
            
            let requestStartTime = Date()
            
            request.responseObject { response in
                Parser.parseResponse(
                    response: response,
                    isDebugging: isDebugging,
                    requestTime: Date().timeIntervalSince(requestStartTime),
                    completionHandler: completion
                )
            }
        } else {
            AlertManager.shared.showOKAlert(
                with: "No Internet Connection",
                message: "Please make sure your device is connected to the internet"
            )
        }
    }
    
    // MARK: - Post Method
    
    /// This is the generic webservice method of type 'POST' for web service calling
    ///
    /// - Parameters:
    ///   - endPoint: service end point
    ///   - ignoreBaseUrl: flag for ignore the base url
    ///   - completionHandler: generic call back completion handler
    
    func executePost<T: BaseResponseMappable>(
        endPoint: String,
        ignoreBaseURL: Bool = false,
        isDebugging: Bool = true,
        showLoader: Bool = true,
        completion: @escaping (AFDataResponse<T>) -> Void
    ) {
        if Reachability.isConnectedToNetwork() {
            if showLoader {
                ActivityIndicatorView.shared.startAnimating()
            }
            
            headers = HTTPHeaders(DataCacheManager.shared.getAuthHeaders())
            
            let url = getRequestURL(endPoint: endPoint, ignoreBaseUrl: ignoreBaseURL)
            let request = sessionManager.request(
                url,
                method: .post,
                parameters: parameters,
                encoding: JSONEncoding(options: []),
                headers: headers
            )
            
            let requestStartTime = Date()
            
            request.validate().responseObject { response in
                
                Parser.parseResponse(
                    response: response,
                    isDebugging: isDebugging,
                    requestTime: Date().timeIntervalSince(requestStartTime),
                    completionHandler: completion
                )
            }
        } else {
            AlertManager.shared.showOKAlert(
                with: "No Internet Connection",
                message: "Please make sure your device is connected to the internet"
            )
        }
    }
    
//    func executePostWithArrayJSONInput<T: BaseResponseMappable>(
//        endPoint: String,
//        ignoreBaseURL: Bool = false,
//        isDebugging: Bool = true,
//        showLoader: Bool = true,
//        completion: @escaping (AFDataResponse<T>) -> Void
//    ) {
//        if Reachability.isConnectedToNetwork() {
//            if showLoader {
//                ActivityIndicatorView.shared.startAnimating()
//            }
//
//            headers = HTTPHeaders(DataCacheManager.shared.getAuthHeaders())
//
////            let url = getRequestURL(endPoint: endPoint, ignoreBaseUrl: ignoreBaseURL)
////            let request = sessionManager.request(
////                url,
////                method: .post,
////                parameters: parametersArrayJSON.asParameters(),
////                encoding: JSONEncoding(options: []),
////                headers: headers
////            )
////
////            let requestStartTime = Date()
////
////            request.validate().responseObject { response in
////                Parser.parseResponse(
////                    response: response,
////                    isDebugging: isDebugging,
////                    requestTime: Date().timeIntervalSince(requestStartTime),
////                    completionHandler: completion
////                )
////            }
//
//            guard let url = URL(string: getRequestURL(endPoint: endPoint, ignoreBaseUrl: ignoreBaseURL)) else { return }
//            var urlRequest = URLRequest(url: url)
//
//            urlRequest.method = .post
//            urlRequest.headers = headers
//            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parametersArrayJSON, options: [])
//
//            let request = sessionManager.request(urlRequest)
//
//            let requestStartTime = Date()
//
//            request.validate().responseObject { response in
//                Parser.parseResponse(
//                    response: response,
//                    isDebugging: isDebugging,
//                    requestTime: Date().timeIntervalSince(requestStartTime),
//                    completionHandler: completion
//                )
//            }
//        } else {
//            AlertManager.shared.showOKAlert(
//                with: "No Internet Connection",
//                message: "Please make sure your device is connected to the internet"
//            )
//        }
//    }
    
    func executePut<T: BaseResponseMappable>(
        endPoint: String,
        ignoreBaseURL: Bool = false,
        isDebugging: Bool = true,
        showLoader: Bool = true,
        completion: @escaping (AFDataResponse<T>) -> Void
    ) {
        if Reachability.isConnectedToNetwork() {
            if showLoader {
                ActivityIndicatorView.shared.startAnimating()
            }
            
            headers = HTTPHeaders(DataCacheManager.shared.getAuthHeaders())
            
            let url = getRequestURL(endPoint: endPoint, ignoreBaseUrl: ignoreBaseURL)
            let request = sessionManager.request(
                url,
                method: .put,
                parameters: parameters,
                encoding: JSONEncoding(options: []),
                headers: headers
            )
            
            let requestStartTime = Date()
            
            request.validate().responseObject { response in
                Parser.parseResponse(
                    response: response,
                    isDebugging: isDebugging,
                    requestTime: Date().timeIntervalSince(requestStartTime),
                    completionHandler: completion
                )
            }
        } else {
            AlertManager.shared.showOKAlert(
                with: "No Internet Connection",
                message: "Please make sure your device is connected to the internet"
            )
        }
    }
}
