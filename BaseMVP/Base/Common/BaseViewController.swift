//
//  BaseViewController.swift
//  BaseMVP
//
//  Created by Chung-Sama on 11/7/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
        Log.debug("Presenter \(type(of: self)) init")
        automaticallyAdjustsScrollViewInsets = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Log.debug("Presenter \(type(of: self)) deinit")
    }
}
