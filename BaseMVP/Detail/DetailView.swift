//
//  DetailView.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/19/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class DetailView: MVPView {
    @IBAction func gotoPrevScreen(_ sender: UIButton) {
        mPresenter?.executeCommand(command: PrevCommand())
    }
    
    struct PrevCommand: ICommand {}
}
