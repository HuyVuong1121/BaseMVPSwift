//
//  BaseView.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/16/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class BaseView: UIView, IView {
    
    internal var mPresenter: IPresenter?
    
    func attachPresenter(_ presenter: IPresenter) {
        mPresenter = presenter;
    }
    
    var hasMVPChildren: Bool = false
    
    func onInitView() {
        
    }
    
    func onPortrait() {
        
    }
    
    func onLandscape() {
        
    }
    
}
