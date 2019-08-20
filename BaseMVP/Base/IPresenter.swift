//
//  IPresenter.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/16/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

protocol IPresenter where Self : UIViewController {
    func onPresenterReady()
    func onPresenterRelease()
    func executeCommand(command: ICommand)
}
