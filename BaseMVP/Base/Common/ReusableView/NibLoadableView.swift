//
//  NibLoadableView.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/19/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension NibLoadableView where Self: UIView {
    static func instantiateView() -> Self {
        guard let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? Self else {
            fatalError("Can not load nib with name '\(nibName)'")
        }
        return view
    }
}
