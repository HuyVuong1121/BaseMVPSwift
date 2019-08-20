//
//  EndPointType.swift
//  BASE_MVP
//
//  Created by Chung-Sama on 7/27/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
