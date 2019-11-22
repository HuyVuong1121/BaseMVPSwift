//
//  ActionException.swift
//  BaseMVP
//
//  Created by Chung-Sama on 11/8/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import Foundation

struct ActionException: Error {
    private let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
