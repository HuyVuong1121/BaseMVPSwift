//
//  ViewProtocol.swift
//  BaseMVP
//
//  Created by Chung-Sama on 11/7/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

public protocol ViewProtocol where Self: UIView {
    func setStatus(status: ViewStatusType)
    func getStatus() -> ViewStatusType
    func attachPresenter(presenter: PresenterProtocol)
    func hasMVPChildren() -> Bool
    func onInitView()
    func onPortrait()
    func onLandscape()
}

public enum ViewStatusType: Int {
    case VIEW_CREATE
    case VIEW_INITING
    case VIEW_INITED
    case VIEW_READY
    case VIEW_DESTROY
}
