//
//  APIConstant.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/21/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import Foundation

enum API {
    
    static let BaseUrl: String = {
        let path = Bundle.main.path(forResource: "EnvConfiguration", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        if let keyStr =  dict?.object(forKey: "Environment") as? String {
            print("---BaseURL: \(String(describing: dict!.object(forKey: keyStr)))---")
            return dict!.object(forKey: keyStr) as! String
        } else {
            assertionFailure("Please enter Environment item's value in EnvConfiguration.plist")
            return ""
        }
        
    }()
    
    enum V1 {
        enum User: String {
            case SignIn = "api/v1/users/sign_in"
        }
        enum Academy: String {
            case AcademyWithPage = "api/v1/academy"
        }
    }
}
