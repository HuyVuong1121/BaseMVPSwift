//
//  IView.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/16/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import Foundation

protocol IView: class {
    func attachPresenter(_ presenter: IPresenter)
    var hasMVPChildren: Bool { get set }
    func onInitView()
    func onPortrait()
    func onLandscape()
}
