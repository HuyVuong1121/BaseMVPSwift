//
//  NetworkLogger.swift
//  BASE_MVP
//
//  Created by Chung-Sama on 7/27/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest) {
        
        print("\n ℹ️ℹ️ℹ️ REQUEST ℹ️ℹ️ℹ️ \n")
        defer { print("\n ℹ️ℹ️ℹ️  END ℹ️ℹ️ℹ️ \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
        \(urlAsString) \n\n
        \(method) \(path)?\(query) HTTP/1.1 \n
        HOST: \(host)\n
        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        print(logOutput)
    }
    
    static func log(response: HTTPURLResponse, data: Data) {
        print("\n ℹ️ℹ️ℹ️ RESPONSE ℹ️ℹ️ℹ️ \n")
        defer { print("\n ℹ️ℹ️ℹ️  END ℹ️ℹ️ℹ️ \n") }
        
        let urlAsString = response.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
        \(urlAsString) \n\n
        \(path)?\(query) HTTP/1.1 \n
        HOST: \(host)\n
        """
        for (key,value) in response.allHeaderFields {
            logOutput += "\(key): \(value) \n"
        }
        logOutput += "\n \(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "")"
        
        print(logOutput)
    }
}
