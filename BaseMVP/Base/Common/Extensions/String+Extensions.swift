//
//  String+Extensions.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/16/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}
