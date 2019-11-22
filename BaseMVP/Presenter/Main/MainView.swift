//
//  MainView.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/16/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class MainView: MVPView {
    @IBOutlet weak var nameLabel: UILabel!
    
    func setName(name: String) {
        nameLabel.text = name
    }
    
    @IBAction func nextScreen(_ sender: UIButton) {
        mPresenter?.executeCommand(command: NextCommand())
    }
    
    struct NextCommand: CommandProtocol {}
    struct LoginGoogleCommand: CommandProtocol {}
    struct FacebookCommand: CommandProtocol {}
}
