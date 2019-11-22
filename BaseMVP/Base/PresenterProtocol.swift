//
//  PresenterProtocol.swift
//  BaseMVP
//
//  Created by Chung-Sama on 11/7/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

public protocol PresenterProtocol where Self: UIViewController {
    func onPresenterReady()
    func onPresenterRelease()
    func executeCommand(command: CommandProtocol)
}
