//
//  MainController.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/16/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class MainController: MVPController<MainView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        mView?.setName(name: "Chungtv")
    }

    override func onExecuteCommand(command: ICommand) {
        if let _ = command as? MainView.NextCommand {
            navigationController?.pushViewController(DetailController(), animated: true)
        }
    }

}

