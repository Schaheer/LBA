//
//  APIs.swift
//  AABEngage
//  Student Id: MC200202009
//  Created by Shakeel Ahmed on 10/30/21.
//

import Foundation
import Alamofire
import SwiftyJSON

var kAccessToken = ""

class APIs: SessionDelegate {
    static var shared = APIs()
    
    
    
//    let evaluators = [
//      "10.100.37.45":
//        PinnedCertificatesTrustEvaluator(certificates: [
//          Certificates.aabCertificate
//          ])
//    ]
    
//        let evaluators = [
//          "10.100.37.45":
//            PinnedCertificatesTrustEvaluator(certificates: [Certificates.aabCertificate], acceptSelfSignedCertificates: true, performDefaultValidation: true, validateHost: true)
//        ]
//    struct Certificates {
//      static let aabCertificate =
//        Certificates.certificate(filename: "aab")
//
//      private static func certificate(filename: String) -> SecCertificate {
//        let filePath = Bundle.main.path(forResource: filename, ofType: "der")!
//        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
//
////          let cfData = CFDataCreateWithBytesNoCopy(nil, (data as NSData).bytes.bindMemory(to: UInt8.self, capacity: data.count), data.count, kCFAllocatorNull)
//          let certificate = SecCertificateCreateWithData(nil, data as CFData)
//
//          return certificate!
//      }
//    }
//    func sessionMangerWithCertificateFromDisk(timeOut: Int) -> Session {
//
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = TimeInterval(timeOut)
//        configuration.httpShouldUsePipelining = true
//        let trustManager = ServerTrustManager(allHostsMustBeEvaluated: false,
//                                              evaluators: evaluators)
//
//        let sessionManger = Session(configuration: configuration, delegate: self, startRequestsImmediately: true, serverTrustManager: trustManager)
//
//        return sessionManger
//    }
    
    //MARK:- Working sessionManger
    func sessionManger(timeOut: Int) -> Session {
        let configuration = URLSessionConfiguration.default
        //        configuration.httpMaximumConnectionsPerHost = 10


        configuration.timeoutIntervalForRequest = TimeInterval(timeOut)
        configuration.httpShouldUsePipelining = true
        
        //  MARK: - Without Certificate
        let sessionManager = Session(configuration: configuration, startRequestsImmediately: true)
        
//        //MARK: - With Disable Trust Evulator Certificate
//        let trustManager = ServerTrustManager(allHostsMustBeEvaluated: false,
//                                              evaluators: ["10.100.37.45": DisabledTrustEvaluator(),
//                                                           "www.lexusqatar.com": DisabledTrustEvaluator(),
//                                                           "https://aab-engage-app.herokuapp.com":DisabledTrustEvaluator()])
//        let sessionManager = Session(configuration: configuration, delegate: self, startRequestsImmediately: true, serverTrustManager: trustManager)
//
//        //MARK: - With Trust Evulator Certificate
//        let sessionManager = sessionMangerWithCertificateFromDisk(timeOut: timeOut)
        return sessionManager
    }
    
    
    
    
    static func load(URL: NSURL) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL as URL)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data: Data!, response: URLResponse!, error: Error!) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
//                print("Success: \(statusCode)")

                // This is your file-variable:
                // data
            }
            else {
                // Failure
                print("Failure: %@", error.localizedDescription);
            }
        })
        task.resume()
    }
    
    
    static func funDownloadFileViaUrl(_ urlString: String, viewController: UIViewController) {
        
    }

    
//    static let ipAddress = UIDevice.current.ipAddress() ?? ""
//    static let deviceInfo = UIDevice.modelName
//    static let grantType = "password"
//    static let deviceToken = General_Elements.shared.deviceToken
//    //static let authToken = "bearer \(General_Elements.shared.userProfileData?.data?.accessTokenResponse?.accessToken ?? "")"
//    static let authToken = "bearer \(Constant.kAccessToken)"
//    static let header: HTTPHeaders = ["Content-Type": "application/json"
//                               ,"device_info" : deviceInfo ,
//                               "device_token" : deviceToken ,
    
    
//                               "ip" : ipAddress ,
//                               "grant_type" : grantType]
//
//    static let headerWithToken: HTTPHeaders = ["Content-Type": "application/json"
//                               ,"device_info" : deviceInfo ,
//                               "device_token" : deviceToken ,
//                               "ip" : ipAddress ,
//                               "grant_type" : grantType,
//                               "Authorization" : authToken]
    
    
//    static func getAPI(apiName: APIs.name, parameters: [String: Any]? = nil, viewController: UIViewController? = nil, completion: @escaping(_ response: JSON?, Bool, _ error: String) -> Void) {
//        let url = "\(baseURL)\(apiName.rawValue)"
//
//        //        let ipAddress = UIDevice.current.ipAddress() ?? ""
////        let deviceInfo = UIDevice.modelName
////        let grantType = "password"
////        let deviceToken = General_Elements.shared.deviceToken
//        let authToken = "Bearer \(kAccessToken)"
//        let headerWithToken: HTTPHeaders = ["Content-Type": "application/json",
//                                   "Authorization" : authToken]
//
//        print("URL: \(url)")
//        print("Parameters: \(parameters)")
//        //print("Headers: \(headerWithToken)")
//
//        let sessionManger = APIs.shared.sessionManger(timeOut: 30)
//        if viewController != nil {
//            viewController?.view.showLoader(viewController: viewController!)
//        }
//
//        sessionManger.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headerWithToken).responseJSON { (response) in
//            sessionManger.cancelAllRequests()
//            if viewController != nil {
//                viewController?.view.removeLoader(viewController: viewController!)
//            }
//            print("Response: \(response)")
//
//            switch response.result {
//            case .success(let json):
//                let serverResponse = JSON(response.value!)
//                print("JSON: \(serverResponse)")
//                print("JSON: \(json)")
//                switch response.response?.statusCode {
//                case 200 :
//                    let responseCode = kfunCheckResponseCode(responseJSON: serverResponse)
//                    if responseCode == 1 {
//                        completion(serverResponse, true, "")
//                    }
//                    else {
//                        let errorMessage = kfunCatchError(responseJSON: serverResponse)
//                        completion(serverResponse, false, errorMessage)
//                    }
//                    break
//                default :
//                    let errorMessage = kfunCatchError(responseJSON: serverResponse)
//                    completion(serverResponse, false, errorMessage)
//                    break
//                }
//            case .failure( _):
//                var errorMessage = ""
//                if let error = response.error?.localizedDescription {
//                    let errorArray = error.components(separatedBy: ":")
//                    errorMessage = errorArray.count > 1 ? errorArray[1] : error
//                    //completion(nil, false, errorMessage)
//                }
//                else {
//                    errorMessage = response.error.debugDescription
//                    //completion(nil, false, response.error.debugDescription)
//                }
//                if viewController != nil {
//                    viewController?.showAlert(message: errorMessage)
//                }
//                else {
//                    completion(nil, false, errorMessage)
//                }
//                break
//            }
//            
//        }
//    }
    
    
    static func getAPI(apiName: APIs.name, parameters: [String: Any]? = nil, viewController: UIViewController? = nil, completion: @escaping(_ response: JSON?, Bool, _ error: String) -> Void) {
        
        let urlString = "\(baseURL)\(apiName.rawValue)"
        
        var url = URLComponents(string: urlString)
        var queryItems: [URLQueryItem] = url?.queryItems ??  []
        if parameters != nil {
            for keyValue in parameters!  {
                // Create query item
                let queryItem = URLQueryItem(name: keyValue.key, value: keyValue.value as? String)
                // Append the new query item in the existing query items array
                queryItems.append(queryItem)
            }
            // Append updated query items array in the url component object
            url?.queryItems = queryItems
        }
        let authToken = "Bearer \(kAccessToken)"
        let headerWithToken: HTTPHeaders = ["Content-Type": "application/json",
                                            "Authorization" : authToken]
        
        print("URL: \(String(describing: url))")
        print("Parameters: \(String(describing: parameters))")
        print("Headers: \(headerWithToken)")
        
        let sessionManger = APIs.shared.sessionManger(timeOut: 120)
//        if viewController != nil {
//            viewController?.view.showLoader(viewController: viewController!)
//        }
        
        sessionManger.request(url!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headerWithToken).responseJSON { (response) in
            sessionManger.cancelAllRequests()
//            if viewController != nil {
//                viewController?.view.removeLoader(viewController: viewController!)
//            }
//            print("Response: \(response)")
           
            switch response.result {
            case .success(let json):
                let serverResponse = JSON(response.value!)
//                print("JSON: \(serverResponse)")
//                print("JSON: \(json)")
                switch response.response?.statusCode {
                case 200 :
                    let responseCode = kfunCheckResponseCode(responseJSON: serverResponse)
                    if responseCode == 1 {
                        completion(serverResponse, true, "")
                    }
                    else {
                        let errorMessage = kfunCatchError(responseJSON: serverResponse)
                        completion(serverResponse, false, errorMessage)
                    }
                    break
                default :
                    let errorMessage = kfunCatchError(responseJSON: serverResponse)
                    completion(serverResponse, false, errorMessage)
                    break
                }
            case .failure( _):
                    var errorMessage = ""
                if let error = response.error?.localizedDescription {
                    let errorArray = error.components(separatedBy: ":")
                    errorMessage = errorArray.count > 1 ? errorArray[1] : error
                    completion(nil, false, errorMessage)
                }
                else {
                    errorMessage = response.error.debugDescription
                    completion(nil, false, response.error.debugDescription)
                }
                if viewController != nil {
//                    viewController?.showAlert(message: errorMessage)
                }
                break
            }
            
        }
    }
    
    static func getAPI(remeaningURL: String, parameters: [String: Any]? = nil, viewController: UIViewController? = nil, completion: @escaping(_ response: JSON?, Bool, _ error: String) -> Void) {
        let url = "\(baseURL)\(remeaningURL)".validURL()
        
        let authToken = "Bearer \(kAccessToken)"
        let headerWithToken: HTTPHeaders = ["Content-Type": "application/json",
                                            "Authorization" : authToken]
        
        print("URL: \(url)")
        print("Parameters: \(String(describing: parameters))")
        print("Headers: \(headerWithToken)")
        
        let sessionManger = APIs.shared.sessionManger(timeOut: 120)
        if viewController != nil {
//            viewController?.view.showLoader(viewController: viewController!)
        }
        
        sessionManger.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headerWithToken).responseJSON { (response) in
            sessionManger.cancelAllRequests()
            if viewController != nil {
//                viewController?.view.removeLoader(viewController: viewController!)
            }
//            print("Response: \(response)")
           
            switch response.result {
            case .success(let json):
                let serverResponse = JSON(response.value!)
//                print("JSON: \(serverResponse)")
//                print("JSON: \(json)")
                switch response.response?.statusCode {
                case 200 :
                    let responseCode = kfunCheckResponseCode(responseJSON: serverResponse)
                    if responseCode == 1 {
                        completion(serverResponse, true, "")
                    }
                    else {
                        let errorMessage = kfunCatchError(responseJSON: serverResponse)
                        completion(serverResponse, false, errorMessage)
                    }
                    break
                default :
                    let errorMessage = kfunCatchError(responseJSON: serverResponse)
                    completion(serverResponse, false, errorMessage)
                    break
                }
            case .failure( _):
                    var errorMessage = ""
                if let error = response.error?.localizedDescription {
                    let errorArray = error.components(separatedBy: ":")
                    errorMessage = errorArray.count > 1 ? errorArray[1] : error
                    //completion(nil, false, errorMessage)
                }
                else {
                    errorMessage = response.error.debugDescription
                    //completion(nil, false, response.error.debugDescription)
                }
                if viewController != nil {
//                    viewController?.showAlert(message: errorMessage)
                }
                break
            }
            
        }
    }
    
    /// Converts the dictionary to key values
    static func convertToParameters(_ params: [String: String?]) -> String {
        var paramList: [String] = []

        for (key, value) in params {
            guard let value = value else {
                continue
            }

            guard let scapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                print("Failed to convert key \(key)")
                continue
            }

            guard let scapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                print("Failed to convert value \(value)")
                continue
            }

            paramList.append("\(scapedKey)=\(scapedValue)")
        }

        return paramList.joined(separator: "&")
    }
    
    static func postAPIKeyValuesKey(completeUrl: APIs.name, parameters: [String: String?]? = nil, viewController: UIViewController? = nil, completion: @escaping(_ response: [String: Any]?, Bool, _ error: String) -> Void) {
        
        let url = URL(string: completeUrl.rawValue)!
        let request = NSMutableURLRequest(url: url)
//        let sessionManger = APIs.shared.sessionManger(timeOut: 20)
        request.httpMethod = "POST"
//        var err: NSError?
        let bodyData = APIs.convertToParameters(parameters!)
        request.httpBody = bodyData.data(using: String.Encoding.utf8, allowLossyConversion: true)

        let sessionManger = URLSession.shared

        if viewController != nil {
//            viewController?.view.showLoader(viewController: viewController!)
        }
        
        let task = sessionManger.dataTask(with: request as URLRequest,
                                                     completionHandler: {data, response, error -> Void in
            let dataString = String(data: data!, encoding: String.Encoding.utf8)
            print(dataString as Any)
            print(dataString as Any)
            
            if viewController != nil {
                DispatchQueue.main.async {
//                    viewController?.view.removeLoader(viewController: viewController!)
                }
            }
//            print("Response: \(response)")
           
            if let error = error {
                var errorMessage = ""
                errorMessage = error.localizedDescription
                //completion(nil, false, errorMessage)
                 if viewController != nil {
//                     viewController?.showAlert(message: errorMessage)
                 }
                return
            }
                    
            switch (response as! HTTPURLResponse).statusCode {
            case 200:
                let stringKeyValuesArrary = dataString?.components(separatedBy: "&")
                let dictionary = NSMutableDictionary()
                for keyvlaue in stringKeyValuesArrary! {
                    let tempArray = keyvlaue.split(separator: "=")
                    
                    let key = tempArray[0].split(separator: ".").last!
                    let value = tempArray.count > 1 ? "\(tempArray[1])" : ""
                    dictionary.setValue("\(value)", forKey: "\(key)")
                }
                completion(dictionary as? [String : Any], true, "")
                break
            default:
               
                break
            }
        })
        task.resume()
    }
    
    
    static func getAPI(completeURL: String, parameters: [String: Any]? = nil, viewController: UIViewController? = nil, completion: @escaping(_ response: JSON?, Bool, _ error: String) -> Void) {
        let url = "\(completeURL)"
        let authToken = "Bearer \(kAccessToken)"
        let headerWithToken: HTTPHeaders = ["Content-Type": "application/json",
                                            "Authorization" : authToken]
        print("URL: \(url)")
        print("Parameters: \(parameters)")
        print("Headers: \(headerWithToken)")
        
        let sessionManger = APIs.shared.sessionManger(timeOut: 120)
        if viewController != nil {
//            viewController?.view.showLoader(viewController: viewController!)
        }
        
        sessionManger.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            sessionManger.cancelAllRequests()
            if viewController != nil {
//                viewController?.view.removeLoader(viewController: viewController!)
            }
//            print("Response: \(response)")
           
            switch response.result {
            case .success(let json):
                let serverResponse = JSON(response.value!)
//                print("JSON: \(serverResponse)")
//                print("JSON: \(json)")
                switch response.response?.statusCode {
                case 200 :
                    let responseCode = kfunCheckResponseCode(responseJSON: serverResponse)
                    if responseCode == 1 {
                        completion(serverResponse, true, "")
                    }
                    else {
                        let json  = JSON(rawValue: response.data!)
                        let responseCode = kfunCheckResponseCode(responseJSON:  json!)
                            if responseCode == 1 {
                                completion(json, true, "")
                            }
                            else {
                                let errorMessage = kfunCatchError(responseJSON: json!)
                                completion(json, false, errorMessage)
                            }
                        break
                    }
                    break
                default :
                    let errorMessage = kfunCatchError(responseJSON: serverResponse)
                    completion(serverResponse, false, errorMessage)
                    break
                }
            case .failure( _):
                var errorMessage = ""
                if let error = response.error?.localizedDescription {
                    let errorArray = error.components(separatedBy: ":")
                    errorMessage = errorArray.count > 1 ? errorArray[1] : error
                    //completion(nil, false, errorMessage)
                }
                else {
                    errorMessage = response.error.debugDescription
                    //completion(nil, false, response.error.debugDescription)
                }
                if viewController != nil {
//                    viewController?.showAlert(message: errorMessage)
                }
                break
            }
            
        }
    }
    
    static func deleteAPI(apiName: APIs.name, parameters: [String: Any]? = nil, viewController: UIViewController? = nil, completion: @escaping(_ response: JSON?, Bool, _ error: String) -> Void) {
        let url = "\(baseURL)\(apiName.rawValue)"

        let authToken = "Bearer \(kAccessToken)"
        let headerWithToken: HTTPHeaders = ["Content-Type": "application/json",
                                            "Authorization" : authToken]
        
        print("URL: \(url)")
        print("Parameters: \(String(describing: parameters))")
        //print("Headers: \(headerWithToken)")
        
        let sessionManger = APIs.shared.sessionManger(timeOut: 120)
        if viewController != nil {
//            viewController?.view.showLoader(viewController: viewController!)
        }
        
        sessionManger.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headerWithToken).responseJSON { (response) in
            sessionManger.cancelAllRequests()
            if viewController != nil {
//                viewController?.view.removeLoader(viewController: viewController!)
            }
//            print("Response: \(response)")
           
            switch response.result {
            case .success(let json):
                let serverResponse = JSON(response.value!)
//                print("JSON: \(serverResponse)")
//                print("JSON: \(json)")
                switch response.response?.statusCode {
                case 200 :
                    let responseCode = kfunCheckResponseCode(responseJSON: serverResponse)
                    if responseCode == 1 {
                        completion(serverResponse, true, "")
                    }
                    else {
                        let errorMessage = kfunCatchError(responseJSON: serverResponse)
                        completion(serverResponse, false, errorMessage)
                    }
                    break
                default :
                    let errorMessage = kfunCatchError(responseJSON: serverResponse)
                    completion(serverResponse, false, errorMessage)
                    break
                }
            case .failure( _):
                var errorMessage = ""
                if let error = response.error?.localizedDescription {
                    let errorArray = error.components(separatedBy: ":")
                    errorMessage = errorArray.count > 1 ? errorArray[1] : error
                    //completion(nil, false, errorMessage)
                }
                else {
                    errorMessage = response.error.debugDescription
                    //completion(nil, false, response.error.debugDescription)
                }
                if viewController != nil {
//                    viewController?.showAlert(message: errorMessage)
                }
                break
            }
            
        }
    }
    
    
    static func deleteAPI(remeaningURL: String, parameters: [String: Any]? = nil, viewController: UIViewController? = nil, completion: @escaping(_ response: JSON?, Bool, _ error: String) -> Void) {
        let url = "\(baseURL)\(remeaningURL)"
        
        let authToken = "Bearer \(kAccessToken)"
        let headerWithToken: HTTPHeaders = ["Content-Type": "application/json",
                                            "Authorization" : authToken]
        
        print("URL: \(url)")
        print("Parameters: \(parameters)")
        //print("Headers: \(headerWithToken)")
        
        let sessionManger = APIs.shared.sessionManger(timeOut: 120)
        if viewController != nil {
//            viewController?.view.showLoader(viewController: viewController!)
        }
        
        sessionManger.request(url, method: .delete, parameters: parameters, encoding: URLEncoding.default, headers: headerWithToken).responseJSON { (response) in
            sessionManger.cancelAllRequests()
            if viewController != nil {
//                viewController?.view.removeLoader(viewController: viewController!)
            }
//            print("Response: \(response)")
           
            switch response.result {
            case .success(let json):
                let serverResponse = JSON(response.value!)
//                print("JSON: \(serverResponse)")
//                print("JSON: \(json)")
                switch response.response?.statusCode {
                case 200 :
                    let responseCode = kfunCheckResponseCode(responseJSON: serverResponse)
                    if responseCode == 1 {
                        completion(serverResponse, true, "")
                    }
                    else {
                        let errorMessage = kfunCatchError(responseJSON: serverResponse)
                        completion(serverResponse, false, errorMessage)
                    }
                    break
                default :
                    let errorMessage = kfunCatchError(responseJSON: serverResponse)
                    completion(serverResponse, false, errorMessage)
                    break
                }
            case .failure( _):
                var errorMessage = ""
                if let error = response.error?.localizedDescription {
                    let errorArray = error.components(separatedBy: ":")
                    errorMessage = errorArray.count > 1 ? errorArray[1] : error
                    //completion(nil, false, errorMessage)
                }
                else {
                    errorMessage = response.error.debugDescription
                    //completion(nil, false, response.error.debugDescription)
                }
                if viewController != nil {
//                    viewController?.showAlert(message: errorMessage)
                }
                break
            }
            
        }
    }
    
    static func getAPIURLSession(completeURL: String, parameters: [String: Any]? = nil, viewController: UIViewController? = nil, completion: @escaping(_ response: JSON?, Bool, _ error: String) -> Void) {
        
        let url = URL(string: completeURL)!
        print("URL: \(url)")
        //print("Parameters: \(parameters)")
        //print("Headers: \(headerWithToken)")
        if viewController != nil {
//            viewController?.view.showLoader(viewController: viewController!)
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if viewController != nil {
                DispatchQueue.main.async {
//                    viewController?.view.removeLoader(viewController: viewController!)
                }
            }
            guard let data = data else { return }
            //print(String(data: data, encoding: .utf8)!)
            guard error == nil else {
                return
            }
            
            do {
                if let httpResponse = response as? HTTPURLResponse {
//                    print(httpResponse.statusCode)
                    switch httpResponse.statusCode {
                    case 200 :
//                        let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, Any>
                        let json  = JSON(rawValue: data)
                        let responseCode = kfunCheckResponseCode(responseJSON:  json!)
                            if responseCode == 1 {
                                completion(json, true, "")
                            }
                            else {
                                let errorMessage = kfunCatchError(responseJSON: json!)
                                completion(json, false, errorMessage)
                            }
                        break
                        
                    default :
//                        let json:  JSON  = JSON(rawValue: try JSONSerialization.jsonObject(with: data) as! Dictionary<String, Any>) ?? JSON() {
                        let json  = JSON(rawValue: data)
                        let errorMessage = kfunCatchError(responseJSON: json!)
                            completion(json, false, errorMessage)
                            
//                        }
                        break
                    }
                }
            }
            catch var error {
            print(error.localizedDescription)
        }
//            print("Response: \(data)")
        }

        task.resume()
    }
    
    static func postAPI(apiName: APIs.name, parameters: [String: Any], viewController: UIViewController? = nil, timeout: Int? = 120, encoding: ParameterEncoding? = JSONEncoding.default, completion: @escaping(_ response: JSON?, Bool, _ errorMsg: String) -> Void) {
        let url = "\(baseURL)\(apiName.rawValue)"
        
        let authToken = "Bearer \(kAccessToken)"
        let headerWithToken: HTTPHeaders = ["Content-Type": "application/json",
                                   "Authorization" : authToken]
        
        print("URL: \(url)")
        print("Parameters: \(parameters)")
//        print("Header: \(header)")
        
        let sessionManger = APIs.shared.sessionManger(timeOut: timeout!)
        if viewController != nil {
//            viewController?.view.showLoader(viewController: viewController!)
        }
        sessionManger.request(url, method: .post, parameters: parameters, encoding: encoding!, headers: headerWithToken).responseString { response in
            sessionManger.cancelAllRequests()
            if viewController != nil {
//                viewController?.view.removeLoader(viewController: viewController!)
            }
            //print("Response: \(response)")
           
            switch response.result {
            case .success(let json):
                let serverResponse = JSON(response.value!)
//                print("JSON: \(serverResponse)")
//                print("JSON: \(json)")
                switch response.response?.statusCode {
                case 200 :
                    let responseCode = kfunCheckResponseCode(responseJSON: serverResponse)
                    if responseCode == 1 {
                        completion(serverResponse, true, "")
                    }
                    else {
                        let errorMessage = kfunCatchError(responseJSON: serverResponse)
                        completion(serverResponse, false, errorMessage)
                    }
                    break
                default :
                    let errorMessage = kfunCatchError(responseJSON: serverResponse)
                    completion(serverResponse, false, errorMessage)
                    break
                }
            case .failure( _):
                var errorMessage = ""
                if let error = response.error?.localizedDescription {
                    let errorArray = error.components(separatedBy: ":")
                    errorMessage = errorArray.count > 1 ? errorArray[1] : error
                    //completion(nil, false, errorMessage)
                }
                else {
                    errorMessage = response.error.debugDescription
                    //completion(nil, false, response.error.debugDescription)
                }
                if viewController != nil {
//                    viewController?.showAlert(message: errorMessage)
                }
                break
            }
        }
    }
    static func putAPI(apiName: APIs.name, parameters: [String: Any], viewController: UIViewController? = nil, completion: @escaping(_ response: JSON?, Bool, _ errorMsg: String) -> Void) {
        let url = "\(baseURL)\(apiName.rawValue)"
        
        let authToken = "Bearer \(kAccessToken)"
        let headerWithToken: HTTPHeaders = ["Content-Type": "application/json",
//                                   "device_info" : deviceInfo ,
//                                   "device_token" : deviceToken ,
//                                   "ip" : ipAddress ,
//                                   "grant_type" : grantType,
                                   "Authorization" : authToken]
        
        print("URL: \(url)")
        print("Parameters: \(parameters)")
//        print("Header: \(header)")
        
        
        let sessionManger = APIs.shared.sessionManger(timeOut: 500)
        if viewController != nil {
//            viewController?.view.showLoader(viewController: viewController!)
        }
        sessionManger.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headerWithToken).responseString { response in
            sessionManger.cancelAllRequests()
            if viewController != nil {
//                viewController?.view.removeLoader(viewController: viewController!)
            }
//            print("Response: \(response)")
           
            switch response.result {
            case .success(let json):
                let serverResponse = JSON(response.value!)
//                print("JSON: \(serverResponse)")
//                print("JSON: \(json)")
                switch response.response?.statusCode {
                case 200 :
                    let responseCode = kfunCheckResponseCode(responseJSON: serverResponse)
                    if responseCode == 1 {
                        completion(serverResponse, true, "")
                    }
                    else {
                        let errorMessage = kfunCatchError(responseJSON: serverResponse)
                        completion(serverResponse, false, errorMessage)
                    }
                    break
                default :
                    let errorMessage = kfunCatchError(responseJSON: serverResponse)
                    completion(serverResponse, false, errorMessage)
                    break
                }
            case .failure( _):
                var errorMessage = ""
                if let error = response.error?.localizedDescription {
                    let errorArray = error.components(separatedBy: ":")
                    errorMessage = errorArray.count > 1 ? errorArray[1] : error
                    //completion(nil, false, errorMessage)
                }
                else {
                    errorMessage = response.error.debugDescription
                    //completion(nil, false, response.error.debugDescription)
                }
                if viewController != nil {
//                    viewController?.showAlert(message: errorMessage)
                }
                break
            }
        }
    }
    
    //Working Code with Alamofire Request
    static func downloadFileFromURLAlamoFire(urlString: String, viewController: UIViewController, completion: @escaping(_ success: Bool, _ filePath: String, _ errorMsg: String) -> Void) {
        let arrayStr = urlString.components(separatedBy: "/")
        if let _ = URL(string: urlString) {
            let destination: DownloadRequest.Destination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent(arrayStr.last ?? "documentName")
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            
//            viewController.view.showLoader(viewController: viewController)
            AF.download(urlString, to: destination).response { response in
//                viewController.view.removeLoader(viewController: viewController)
//                print("Response: \(response)")
                
                switch response.result {
                case .success(let result):
//                    print("Result: ", result!)
                    if response.error == nil, let filePath = response.fileURL?.path {
                        //let image = UIImage(contentsOfFile: imagePath)
                        completion(true, "\(filePath)", "")
                    }
                    else {
                        completion(false, "", "\(String(describing: response.error))")
                    }
                    break
                case .failure( _):
                    var errorMessage = ""
                    if let error = response.error?.localizedDescription {
                        let errorArray = error.components(separatedBy: ":")
                        errorMessage = errorArray.count > 1 ? errorArray[1] : error
                        //completion(nil, false, errorMessage)
                    }
                    else {
                        errorMessage = response.error.debugDescription
                        //completion(nil, false, response.error.debugDescription)
                    }
//                    viewController.showAlert(message: errorMessage)
                    break
                }
            }
        }
        else {
            
        }
    }
    
    //Working Code with URLSession Request
    static func downloadFileFromURLSessionRequest(URL: NSURL) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL as URL)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data: Data!, response: URLResponse!, error: Error!) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
//                print("Success: \(statusCode)")

                // This is your file-variable:
                // data
            }
            else {
                // Failure
                print("Failure: %@", error.localizedDescription);
            }
        })
        task.resume()
    }
    
    enum name: String {
        //MARK: - Prefetch APIs
        //MARK: - Form data
        case form = "form"
        case pickupDate = "form/pickup-dates"
        case pickupTime = "form/pickup-times"
        case serviceLocation = "form/service-locations"
        case hardcodevalues = "form/hardcodevalues"
        case isocode = "/form/isocode"

        case vehiclesapi_Lexus = "https://www.lexusqatar.com/api/vehiclesapi"
        case vehiclesapi_Toyota = "https://www.toyotaqatar.com/api/vehiclesapi"

        //MARK: - Auth
        case login = "auth/login"
        case check = "auth/check/"
        case otp = "auth/otp"
        case passwordUpdate = "auth/password"
        case c4cRegister = "auth/c4c/register"
        case idpRegister = "auth/idp/register"
        case updateFcmToken = "/auth/fcm"
        
        //MARK: - My Vehcile
        case vehicles = "vehicles"
        case updateMileage = "vehicles/mileage"
        
        //MARK: - Orders
        case sequenceSet = "orders/services/sequence-set"
        case getCategories = "orders/services/categories"
        case getServices = "orders/services/status"
        case lextoSubscription = "lexto/subscription"
        case lextoSubscriptionRenew = "lexto/subscriptionrenew"

        case lextoPayment = "lexto/payment"
        case updatePaymentStatus = "orders/services/payment"
        case getFlexSubscription = "orders/services/getFlexSubscription"

        
        //MARK: - Parts
        case getPartsSequenceSet = "form/parts-sequence-set"
        case getvehicleParts = "orders/parts/groups"
        case getParts = "orders/parts/order-status-set"
        case getUserExistingAddress = "orders/parts/customer-address-set"
        case partsCategories = "orders/parts/categories/"
        case validatePickupDateTime = "orders/parts/validate-pickup-date-time"
        case checkoutParts = "orders/parts/create-order-set"
        case createTransactionID = "orders/parts/transaction-id"
        case cancelPartsOrderManual = "orders/parts/cancel-order-request" 
        //Only use in checkout Screen below mention automatic api
        case cancelPartsOrderAutomatic = "orders/parts/cancel-order-set"
        case validateVin = "orders/parts/vin-set/"
        case transaction = "orders/services/transaction"
        
        case addAppointment = "vehicles/appointment"

        //MARK: -
        case getPackagesLexusFlex = "lexto/packages"

        //MARK: -
        case racVehicleStockSet = "rentacar/racVehicleStockSet"
        case rentSubscription = "rentacar/rentsubscription"
        case rentActiveSubscription = "rentacar/rentactivesubscription"

        
        
        //MARK: -
        case qPAYRequest = "https://pgtest3.qcb.gov.qa/QPayOneWeb/EZConnectRequestServlet"
    
        //MARK: - Pushnotifications
        case pushNotificationSet = "profilesection/PushNotificationSet"
        
        //MARK: - Profile
        case individualCustomerCollection = "profilesection/IndividualCustomerCollection"
        case individualCustomerIdentification = "profilesection/IndividualCustomerIdentification"
        case individualCustomerAttachmentFolder = "profilesection/IndividualCustomerAttachmentFolder"
        case verifyEmailSet = "profilesection/verifyEmailSet"
        case verifyChangeEmailSet = "profilesection/verifyChangeEmailSet"
        case serviceRequestCollection = "profilesection/ServiceRequestCollection"
        case updateProfile = "profilesection/updateprofile"
        case customerAddressesSet = "profilesection/customerAddressesSet"

        
        
        //MARK: - PurchaseVehicles
        case modelSpecsset = "purchasevehicles/modelspecsset?"
        case locationsSet = "purchasevehicles/locationsset?VTWEG=10&"
        case btdLeadCollection = "purchasevehicles/btdleadcollection"
        case btdLeadAttachmentFolder = "purchasevehicles/btdleadattachmentfolder"
        case leadCollection = "/purchasevehicles/leadcollection"
        case emiInterestRatesSet = "/purchasevehicles/emiinterestratesSet"

        //MARK: - PreownedVehicles
        case preOwnedVehicles = "preowned/preownedvehicles"

        //MARK: - FinancialServices
        case dashboardComplaints = "financialservices/DashboardComplaints"
        case dashboardRequest = "financialservices/DashboardRequest"

        case financialRequests = "financialservices/GetFinancialRequests"
        case vehicleFinanceLoanRequest  = "financialservices/VehicleFinanceLoanRequest"
        case outstandingLoanBalance = "/financialservices/GetOutstandingLoanBalance"
        case dashboardePaymentHistory = "financialservices/DashboardePaymentHistory"
        case dashboardOutstandingPayments = "financialservices/DashboardOutstandingPayments"
        case ePayReceiptPDFSet = "financialservices/ePayReceiptPDFSet"
        case acknowledgementPDFSet = "financialservices/acknowledgementPDFSet"
        case bankTransactionSet = "financialservices/bankTransactionSet"

        //MARK: - CMSCPOV
        case cpovapi = "https://cmscpov.aabqatar.com/api/CPOVAPI"

        //MARK: - News
        case news = "form/news"
        
        // MARK: - Merge Images
        case mergeBase64 = "/form/mergebase64"
        
        // MARK: - Locate Us
        case locateUs = "/form/locLang?language=EN"
    }
    
    enum storyBoards : String {
        case main = "Main"
        case dashboard = "Dashboard"
        case emailcofirmation = "UserEmailConfirmation"
        case appGuide = "AppGuide"
        case contactUs = "ContactUs"
        case walkThroughs = "WalkThroughs"
        case vehicleServices = "VehicleServices"
        case myVehicle = "MyVehicle"
        case myOrder = "MyOrder"
        case vehicleParts = "VehiclesParts"
        case lexusFlex = "LexusFlex"
        case payNow = "PayNow"
        case notifications = "Notifications"
        case menu = "Menu"
        case purchaseVehicle = "PurchaseVehicle"
        case preOwnedVehicles = "PreOwnedVehicles"
        case profile = "Profile"
        case complaints = "Complaints"
        case popup = "Popup"
        case financialServices = "FinancialServices"
        case termsAndConditions = "TermsAndConditions"
        case ePayment = "ePayment"
        case rentalVehicle = "RentalVehicle"
    }
}

//let baseURL = "https://aab-engage-app.herokuapp.com/api/v1/" //Client Build Testing
//let baseURL = "https://aabapis.azurewebsites.net/api/v1/" //New AZURE Build Testing
let baseURL = "https://aab-test.herokuapp.com/api/v1/"


let baseURLLexusImages = "https://www.lexusqatar.com/"
let baseURLToyotaImages = "https://www.toyotaqatar.com/"
let baseURLVehiclePartsImages = "https://cmscpov.aabqatar.com/"
let baseURLcmscpov = "https://cmscpov.aabqatar.com"


extension APIs {
    //json String to json Dictionary
    static func kfunGetDataFromJSONString(jsonString: String) -> [String: AnyObject] {
        var jsonData = [String:AnyObject]()
        do{
            if let json = jsonString.data(using: .utf8){
                if let tempJsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{
//                    print(tempJsonData)
                    jsonData = tempJsonData
                }
            }
        }
        catch {
            print(error.localizedDescription)

        }
        return jsonData
    }
    //get Data From JSON
    static func kfunGetDataFromJSON(json: JSON) -> Data {
        var jsonData = Data()
        let jsonEncoder = JSONEncoder()
        do  {
            jsonData = try jsonEncoder.encode(json)
        }
        catch {
            
        }
        return jsonData
    }
    static func kfunGetDataFromDic(dicResponse: [String : AnyObject]) -> Data {
        var jsonData = Data()
        do  {
            jsonData = try! JSONSerialization.data(withJSONObject:dicResponse)
        }
        catch {
            print(error.localizedDescription)
        }
        return jsonData
    }
    //Exception handler
    static func kfunCatchJsonDecoderError<T: BaseResponseModel>(_ model: T.Type, responseJSON: JSON) -> (T?, NSDictionary?) {
        do {// process data
            var dataResponse = Data()
            switch responseJSON.type {
              case .array:
                print("list is Array")
                dataResponse = try responseJSON.rawData()
              case .dictionary:
                print("list is Dictionary")
                dataResponse = kfunGetDataFromJSON(json: responseJSON)
            case .string:
                print("list is String")
                let jsonDictionary = kfunGetDataFromJSONString(jsonString: responseJSON.rawString()!)
                dataResponse = kfunGetDataFromDic(dicResponse: jsonDictionary)
              default: break
            }
            
//            let recordDataModel = try JSONDecoder().decode(model, from: dataResponse)
            return (nil, nil)
        }
        catch let DecodingError.dataCorrupted(context) {
            print(context)
            let dic: NSDictionary = ["codingPath:": context.codingPath, "context": context]
            return (nil, dic)
        }
        catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            let dic: NSDictionary = ["Key": key, "not found:": context.debugDescription, "codingPath:": context.codingPath]
            return (nil, dic)
        }
        catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            let dic: NSDictionary = ["Value": value, "not found:": context.debugDescription, "codingPath:": context.codingPath]
            return (nil, dic)
        }
        catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            let dic: NSDictionary = ["type": type, "mismatch:": context.debugDescription, "codingPath:": context.codingPath]
            return (nil, dic)
        }
        catch {
            print("error: ", error)
            let dic: NSDictionary = ["error": error]
            return (nil, dic)
        }
    }
    
    static func kfunCatchError(responseJSON: JSON) -> String {
        var errorMessage = ""
        switch responseJSON.type {
          case .array:
            print("list is Array")
          case .dictionary:
            print("list is Dictionary")
            errorMessage = responseJSON["message"].string ?? ""
        case .string:
            print("list is String")
            let jsonDictionary = kfunGetDataFromJSONString(jsonString: responseJSON.rawString()!)
            errorMessage = jsonDictionary["message"] as? String ?? "Error Occured"
          default: break
        }
        return errorMessage
    }
    
    static func kfunCheckResponseCode(responseJSON: JSON) -> Int {
        var responseCode = 0
        switch responseJSON.type {
          case .array:
            print("list is Array")
//            responseCode = responseJSON["responseCode"].int ?? 0
          case .dictionary:
            print("list is Dictionary")
            responseCode = responseJSON["responseCode"].int ?? 0
        case .string:
            print("list is String")
            let jsonDictionary = kfunGetDataFromJSONString(jsonString: responseJSON.rawString()!)
            responseCode = jsonDictionary["responseCode"] as? Int ?? 0
          default: break
        }
        return responseCode
    }
}
extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    
    func validURL() -> URL {
        var url = URL(string: "")
        if self.isValidURL {
            url = URL(string: self)
        }
        else {
            if let encodedString  = self.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let tempURL = URL(string: encodedString) {
//                print(url) // www.mydomain.com%2Fkey=%E0%A4%85%E0%A4%95%E0%A5%8D%E0%A4%B7%E0%A4%AF
                url = tempURL
            }
        }
        return url!
    }
}

