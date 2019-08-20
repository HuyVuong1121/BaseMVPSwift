//
//  MVPController.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/16/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class MVPController<V: IView>: BaseController, IPresenter {
    
    weak var mView: V?
    
    override func loadView() {
        initMVPView(orientation: UIDevice.current.orientation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onPresenterReady()
    }
    
    deinit {
        mView = nil
        onPresenterRelease()
    }
    
    func onPresenterReady() {
        
    }
    
    func onPresenterRelease() {
        
    }
    
    final func executeCommand(command: ICommand) {
        onExecuteCommand(command: command)
    }
    
    func onExecuteCommand(command: ICommand) {
        
    }
    
    private func initMVPView(orientation: UIDeviceOrientation) {
        mView = V.loadNib()
        view = mView
        mView?.attachPresenter(self)
        mView?.onInitView(topLayoutGuide: topLayoutGuide, bottomLayoutGuide: bottomLayoutGuide)
        if orientation.isPortrait {
            mView?.onPortrait()
        } else if orientation.isLandscape {
            mView?.onLandscape()
        }
    }
    
}
