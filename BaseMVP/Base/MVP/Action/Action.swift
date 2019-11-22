//
//  Action.swift
//  BaseMVP
//
//  Created by Chung-Sama on 11/8/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import Foundation

protocol ActionRequestValue {
    
}
struct VoidRequest: ActionRequestValue{}

protocol ActionProtocol {
    associatedtype RequestValue
    associatedtype ResponseValue
    
    func onExecute(reqValue: RequestValue) -> Result<ResponseValue, ActionException>
}

extension ActionProtocol where Self: AsyncOperation {
    
    func execute(reqValue: RequestValue) -> Result<ResponseValue, ActionException> {
        start()
        return onExecute(reqValue: reqValue)
    }
}
