//
//  BaseController.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/16/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
    init(isNil: Bool = false) {
        if isNil {
            super.init(nibName: nil, bundle: nil)
        } else {
            super.init(nibName: String.className(type(of: self)), bundle: .main)
        }
        print("🔹🔹🔹 Presenter \(type(of: self)) init 🔹🔹🔹")
        automaticallyAdjustsScrollViewInsets = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("🚫🚫🚫 init(coder:) has not been implemented 🚫🚫🚫")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        print("🔹🔹🔹 Presenter \(type(of: self)) deinit 🔹🔹🔹")
    }
    
}
