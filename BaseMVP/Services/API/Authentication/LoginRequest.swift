//
//  LoginRequest.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/21/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import Foundation

enum LoginRequest {
    case loginFacebook(fb_token: String)
    case loginGoogle(gp_token: String)
}

extension LoginRequest: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: API.BaseUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        return API.V1.User.SignIn.rawValue//APIv1.User.SignIn
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var task: HTTPTask {
        let params: Parameters
        switch self {
        case .loginFacebook(let fb_token):
            params = ["fb_access_token": fb_token]
        case .loginGoogle(let gp_token):
            params = ["gp_access_token": gp_token]
        }
        return .requestParameters(bodyParameters: params, bodyEncoding: .jsonEncoding, urlParameters: nil)
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
