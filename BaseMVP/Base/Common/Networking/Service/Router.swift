//
//  Router.swift
//  BASE_MVP
//
//  Created by Chung-Sama on 7/27/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request<T>(type: T.Type, route: EndPoint,
                    success: @escaping (T)->Void,
                    failure: @escaping (_ message: String?, _ statusCode: Int)->Void) where T: Decodable
    func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    
    init() {
        Log.debug("Router \(type(of: self)) init")
        print("🔹🔹🔹 Router \(type(of: self)) init 🔹🔹🔹")
    }
    
    deinit {
        Log.debug("Router \(type(of: self)) deinit")
    }
    private var task: URLSessionTask?
    
    func request<T>(type: T.Type, route: EndPoint,
                    success: @escaping (T) -> Void,
                    failure: @escaping (String?, Int) -> Void) where T : Decodable {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            NetworkLogger.log(request: request)
            task = session.dataTask(with: request, completionHandler: { [weak self]  data, response, error in
                DispatchQueue.main.async {
                    self?.handleDataResponse(data: data,
                                             response: response,
                                             error: error,
                                             success: success, failure: failure)
                }
                
            })
        } catch {
            failure(error.localizedDescription, 997)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    
    func handleDataResponse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?,
                                                  success: @escaping (T)->Void,
                                                  failure: @escaping (_ message: String?, _ statusCode: Int)->Void) {
        /// 
    }
}
