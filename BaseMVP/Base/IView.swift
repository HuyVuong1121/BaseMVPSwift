//
//  IView.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/16/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

protocol IView where Self : UIView {
    func attachPresenter(_ presenter: IPresenter)
    var hasMVPChildren: Bool { get set }
    func onInitView(topLayoutGuide: UILayoutSupport, bottomLayoutGuide: UILayoutSupport)
    func onPortrait()
    func onLandscape()
}
