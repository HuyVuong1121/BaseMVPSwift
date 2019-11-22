//
//  Log.swift
//  BaseMVP
//
//  Created by Chung-Sama on 11/8/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import Foundation

enum Log {
    static func verbose(_ message: String) {
        print(" 🗯🗯🗯 " + message + " 🗯🗯🗯 ")
    }
    
    static func debug(_ message: String) {
        print(" 🔹🔹🔹 " + message + " 🔹🔹🔹 ")
    }
    
    static func info(_ message: String) {
        print(" ℹ️ℹ️ℹ️ " + message + " ℹ️ℹ️ℹ️ ")
    }
    
    static func warning(_ message: String) {
        print(" ⚠️⚠️⚠️ " + message + " ⚠️⚠️⚠️ ")
    }
    
    static func error(_ message: String) {
        print(" ‼️‼️‼️ " + message + " ‼️‼️‼️ ")
    }
}
