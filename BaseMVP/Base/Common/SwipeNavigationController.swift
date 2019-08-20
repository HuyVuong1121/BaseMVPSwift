//
//  SwipeNavigationController.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/20/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class SwipeNavigationController: BaseNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden(true, animated: false)
        interactivePopGestureRecognizer?.delegate = self
    }
    
}
extension SwipeNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
