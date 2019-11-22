//
//  DetailController.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/19/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class DetailController: MVPViewController<DetailView> {
    override func onExecuteCommand(command: CommandProtocol) {
        if let _ = command as? DetailView.PrevCommand {
            navigationController?.popViewController(animated: true)
        }
    }
}
