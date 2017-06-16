//
//  HTTPHelper.swift
//  CallRecorder
//
//  Created by Admin on 06.02.17.
//  Copyright © 2017 Intehno. All rights reserved.
//

import Alamofire
import SwiftyJSON

class HTTPHelper
{
    //MARK: - Constants
    private let STATUS_OK: Int = 200
    private let SERVER_TIMEOUT: Double = 15
    
    //MARK: - Vars
    private var sessionManager: SessionManager?
    private var cookies = HTTPCookieStorage.shared
    
    var error: Error? = nil
    var responseJSON: JSON = []
    var statusCode = Int()
    
    func makeRequest(_ address: String,
                     method: HTTPMethod = .get,
                     headers: HTTPHeaders? = nil,
                     parameters: Parameters? = nil,
                     completion: @escaping () -> ())
    {
        startConnectionSettings()
        let queue = DispatchQueue(label: "com.admin.response-queue", qos: .utility, attributes: [.concurrent])
        var authHeaders = HTTPHeaders()
        if headers != nil
        {
            if let firstKey = Array(headers!.keys).first,
                let firstValue = Array(headers!.values).first
            {
                let authorizationHeader = Request.authorizationHeader(user: firstKey, password: firstValue)!
                authHeaders[authorizationHeader.key] = authorizationHeader.value
                print("authHeaders: ", authHeaders)
            }
        }
        sessionManager?.request(address,
                                method: method,
                                parameters: parameters,
                                headers: authHeaders).validate().validate(contentType: ["application/json"]).responseJSON(
                                    queue: queue,
                                    completionHandler:
                                    {
                                        response in
                                        
                                        print("HTTPHelper: ", response.request as Any)  // original URL request
                                        print("HTTPHelper: ", response.response as Any) // HTTP URL response
                                        print("HTTPHelper data: ", response.data as Any)     // server data
                                        print("HTTPHelper data representation: ", String.init(data: response.data!, encoding: .utf8) as Any)
                                        print("HTTPHelper: ", response.result as Any)
                                        print("HTTPHelper headers: ", response.request?.allHTTPHeaderFields as Any)
                                        print("HTTPHelper body: ", response.request?.httpBody as Any)
                                        
                                        switch response.result
                                        {
                                        case .success:
                                            if let statusCode = response.response?.statusCode
                                            {
                                                self.statusCode = statusCode
                                            }
                                            
                                            if let JSON = response.result.value
                                            {
                                                let json = SwiftyJSON.JSON(JSON)
                                                self.responseJSON = json
                                                print("HTTPHelper JSON: ", self.responseJSON)
                                            }
                                            
                                        case .failure(let error):
                                            self.error = error
                                            print("http error: ", error)
                                        }
                                        completion()
                                })
    }
    
    private func startConnectionSettings()
    {
        error = nil
        responseJSON = []
        statusCode = 0
        URLCache.shared.removeAllCachedResponses()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = SERVER_TIMEOUT
        configuration.httpCookieAcceptPolicy = .always
        configuration.httpShouldSetCookies = true
        configuration.httpCookieStorage = cookies
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
}
