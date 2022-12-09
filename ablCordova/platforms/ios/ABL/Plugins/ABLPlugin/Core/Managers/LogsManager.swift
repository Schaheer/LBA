//
//  LogsManager.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import Foundation
import Alamofire
import ObjectMapper

let logsManager = LogsManager.self

final class LogsManager: NSObject {
    
    class func isDebuggingEnabled() -> Bool {
        #if RELEASE
            return false
        #else
            return true
        #endif
    }
    
    /// log something generally unimportant (lowest priority)
    class func verbose(_ items: Any...) {
        
        //swiftylog.verbose(message)
        logsPrint(items)
    }
    
    /// log something which help during debugging (low priority)
    class func debug(_ items: Any...) {
        
        //swiftylog.debug(message)
        logsPrint(items)
    }
    
    /// log something which you are really interested but which is not an issue or error (normal priority)
    class func info(_ items: Any...) {
        
        //swiftylog.info(message)
        logsPrint(items)
    }
    
    /// log something which may cause big trouble soon (high priority)
    class func warning(_ items: Any...) {
        
        //swiftylog.warning(message)
        logsPrint(items)
    }
    
    /// log something which will keep you awake at night (highest priority)
    class func error(_ items: Any...) {
        
        //swiftylog.error(message)
        logsPrint(items)
    }
    
    class func logsPrint(_ items: Any...) {
        
        if isDebuggingEnabled() {
            print(items)
        }
    }
    
    class func printRequestLogs(_ items: String) {
        
        if isDebuggingEnabled() {
            print(items)
        }
    }
    
    class func logRequest<T: BaseMappable>(response: AFDataResponse<T>, requestTime: TimeInterval? = nil, successFlag: Bool) {
        
        let dataJSON            = response.data?.prettyJSONString() ?? ""
        
        let requestLogFlag      = successFlag ? "✅✅✅✅✅" :  "❌❌❌❌❌"
        
        let requestStartString  = String(format: "\n%@================ REQUEST START ================%@\n", requestLogFlag, requestLogFlag)
        let requestEndString    = String(format: "%@================ REQUEST END ================%@\n", requestLogFlag, requestLogFlag)
        
        logsManager.printRequestLogs(requestStartString)
        
        if let url = response.request?.url?.absoluteString {
            logsManager.printRequestLogs("URL: \n\(url)\n")
        }
        
        if let httpMethod = response.request?.httpMethod {
            logsManager.printRequestLogs("HTTP METHOD: \n\(httpMethod)\n")
        }
        
        if let headers = response.request?.allHTTPHeaderFields {
            logsManager.printRequestLogs("REQUEST HEADERS: \n\(headers)\n")
        }
        
        if let body = response.request?.httpBody?.prettyJSONString() {
            logsManager.printRequestLogs("REQUEST: \n\(body)\n")
        }
        
        if let responseHeaders = response.response?.allHeaderFields as? [String: String] {
            logsManager.printRequestLogs("RESPONSE HEADERS: \n\(responseHeaders)\n")
        }
        
        if let time = requestTime?.roundToDecimal(3) {
            logsManager.printRequestLogs("RESPONSE TIME: \n\(time) SECONDS\n")
        }
        
        logsManager.printRequestLogs("RESPONSE: \n\(dataJSON)\n")
        
        logsManager.printRequestLogs(requestEndString)
    }
    
    class func logRequest(response: AFDataResponse<Data?>, requestTime: TimeInterval? = nil, successFlag: Bool) {
        
        let dataJSON            = response.data?.prettyJSONString() ?? ""
        
        let requestLogFlag      = successFlag ? "✅✅✅✅✅" :  "❌❌❌❌❌"
        
        let requestStartString  = String(format: "\n%@================ REQUEST START ================%@\n", requestLogFlag, requestLogFlag)
        let requestEndString    = String(format: "%@================ REQUEST END ================%@\n", requestLogFlag, requestLogFlag)
        
        logsManager.printRequestLogs(requestStartString)
        
        if let url = response.request?.url?.absoluteString {
            logsManager.printRequestLogs("URL: \n\(url)\n")
        }
        
        if let httpMethod = response.request?.httpMethod {
            logsManager.printRequestLogs("HTTP METHOD: \n\(httpMethod)\n")
        }
        
        if let headers = response.request?.allHTTPHeaderFields {
            logsManager.printRequestLogs("REQUEST HEADERS: \n\(headers)\n")
        }
        
        if let body = response.request?.httpBody?.prettyJSONString() {
            logsManager.printRequestLogs("REQUEST: \n\(body)\n")
        }
        
        if let responseHeaders = response.response?.allHeaderFields as? [String: String] {
            logsManager.printRequestLogs("RESPONSE HEADERS: \n\(responseHeaders)\n")
        }
        
        if let time = requestTime?.roundToDecimal(3) {
            logsManager.printRequestLogs("RESPONSE TIME: \n\(time) SECONDS\n")
        }
        
        logsManager.printRequestLogs("RESPONSE: \n\(dataJSON)\n")
        
        logsManager.printRequestLogs(requestEndString)
    }
    
}
