//
//  MainController.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/16/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class MainController: MVPViewController<MainView> {
    
    let loginRequest = BaseRequest<LoginRequest>()
    
    override func onExecuteCommand(command: CommandProtocol) {
        if let _ = command as? MainView.NextCommand {
            //            navigationController?.pushViewController(DetailController(), animated: true)
            let req = CheckNumberAction.CheckNumberActionRequest(value: "1234")
            let action = CheckNumberAction()
            switch action.execute(reqValue: req) {
            case .success(let isNumber):
                Log.debug("\(isNumber) Đúng là số")
            case .failure(let error):
                Log.debug(error.localizedDescription)
            }
            
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

class CheckNumberAction: AsyncOperation, ActionProtocol {
    
    typealias RequestValue = CheckNumberActionRequest
    typealias ResponseValue = Bool
    
    func onExecute(reqValue: CheckNumberAction.CheckNumberActionRequest) -> Result<Bool, ActionException> {
        if let _ = Int(reqValue.value) {
            return Result.success(true)
        } else {
            return Result.failure(ActionException("Méo phải số"))
        }
    }
    
    struct CheckNumberActionRequest: ActionRequestValue {
        let value: String
    }
}

