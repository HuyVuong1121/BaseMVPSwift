//
//  MVPViewController.swift
//  BaseMVP
//
//  Created by Chung-Sama on 11/7/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

public class MVPViewController<V: ViewProtocol>: BaseViewController, PresenterProtocol {
    
    public var mView: V?
    
    public override func loadView() {
        self.view = V.loadNib()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        preparePresenter(view)
        initMVPView(orientation: UIDevice.current.orientation)
        onPresenterReady()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        onPresenterRelease()
        mView = nil
    }
    
    public func onPresenterReady() {
        
    }
    
    public func onPresenterRelease() {
        mView?.setStatus(status: .VIEW_DESTROY)
    }
    
    final public func executeCommand(command: CommandProtocol) {
        onExecuteCommand(command: command)
    }
    
    public func onExecuteCommand(command: CommandProtocol) {
        
    }
    
    private func preparePresenter(_ rootView: UIView) {
        if let _ = rootView as? ViewProtocol {
            mView = (rootView as? V)
            preparePresenterForChildren(rootView)
        } else {
            fatalError("Layout ViewController \(type(of: self)) must have View extend ViewProtocol")
        }
    }
    
    private func preparePresenterForChildren(_ parent: UIView) {
        if let _parent = parent as? ViewProtocol,
            _parent.getStatus() == ViewStatusType.VIEW_CREATE {
            _parent.setStatus(status: .VIEW_INITING)
            _parent.attachPresenter(presenter: self)
        }
    }
    
    private func initMVPView(orientation: UIDeviceOrientation) {
        if let viewMVP = view as? ViewProtocol,
            viewMVP.getStatus() == ViewStatusType.VIEW_INITING {
            viewMVP.setStatus(status: ViewStatusType.VIEW_INITED)
            viewMVP.onInitView()
            if orientation == UIDeviceOrientation.portrait {
                viewMVP.onPortrait()
            } else if orientation == UIDeviceOrientation.landscapeLeft
                || orientation == UIDeviceOrientation.landscapeRight {
                viewMVP.onLandscape()
            }
        }
    }
    
}
