//
//  BaseRequest.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/21/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import Foundation

class BaseRequest<EndPoint: EndPointType>: Router<EndPoint> {
    
    override func handleDataResponse<T>(data: Data?, response: URLResponse?, error: Error?, success: @escaping (T) -> Void, failure: @escaping (String?, Int) -> Void) where T : Decodable {
        guard error == nil else {
            failure(NetworkError.failed.rawValue, 998)
            print("\n ℹ️ℹ️ℹ️  RESPONSE  ℹ️ℹ️ℹ️ \n")
            print(error?.localizedDescription ?? "")
            print("\n ℹ️ℹ️ℹ️  END  ℹ️ℹ️ℹ️ \n")
            return
        }
        guard let _response = response as? HTTPURLResponse, let responseData = data else {
            failure(NetworkError.noData.rawValue, 999)
            return
        }
        NetworkLogger.log(response: _response, data: responseData)
        
        switch _response.statusCode {
        case 200...299:
            do {
                let model = try JSONDecoder().decode(T.self, from: responseData)
                success(model)
            } catch {
                failure(NetworkError.unableToDecode.rawValue, 0)
            }
        case 501...599:
            failure(NetworkError.badRequest.rawValue, _response.statusCode)
        case 600:
            failure(NetworkError.outdated.rawValue, _response.statusCode)
        default:
            let message = try? JSONDecoder().decode(MessageError.self, from: responseData)
            failure(message?.message ?? NetworkError.failed.rawValue, _response.statusCode)
        }
    }
}
