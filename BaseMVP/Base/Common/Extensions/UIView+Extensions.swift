//
//  UIView+Extensions.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/19/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

extension UIView {
    static func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    static func loadNib() -> Self {
        return loadNib(self)
    }
}
