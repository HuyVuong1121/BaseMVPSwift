//
//  MVPController.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/16/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class MVPController<V: IView>: BaseController, IPresenter {
    
    override func loadView() {
        onPresenterReady()
    }
    
    deinit {
        onPresenterRelease()
    }
    
    func onPresenterReady() {
        
    }
    
    func onPresenterRelease() {
        
    }
    
    func executeCommand(command: ICommand) {
        
    }
    
    private func initMVPView(_view: BaseView, orientation: UIInterfaceOrientation) {
        
    }
    
}
