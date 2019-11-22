//
//  NetworkDefaultMessageError.swift
//  BASE_MVP
//
//  Created by Chung-Sama on 7/27/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import Foundation

public enum NetworkError: String, Error {
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
