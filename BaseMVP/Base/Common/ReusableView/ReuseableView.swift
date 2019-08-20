//
//  ReuseableView.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/19/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
