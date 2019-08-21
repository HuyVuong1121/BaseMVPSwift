//
//  MainController.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/16/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class MainController: MVPController<MainView> {
    
    let loginRequest = BaseRequest<LoginRequest>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mView?.setName(name: "Chungtv")
    }

    override func onExecuteCommand(command: ICommand) {
        if let _ = command as? MainView.NextCommand {
            navigationController?.pushViewController(DetailController(), animated: true)
        } else if let _ = command as? MainView.FacebookCommand {
            loginRequest.request(type: AccountSession.self, route: .loginFacebook(fb_token: "access_token_from_facebook"), success: { account in
                // hidden loading and process UI
            }, failure: { [weak self] (message, _ ) in
                // show error and hidden loading
            })
        } else if let _ = command as? MainView.FacebookCommand {
            loginRequest.request(type: AccountSession.self, route: .loginGoogle(gp_token: "access_token_from_google"), success: { account in
                // hidden loading and process UI
            }, failure: { [weak self] (message, _ ) in
                // show error and hidden loading
            })
        }
    }

}

