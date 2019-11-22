//
//  MVPView.swift
//  BaseMVP
//
//  Created by Chung-Sama on 11/7/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

public class MVPView: UIView, ViewProtocol {
    
    @IBOutlet weak var mWrapperView: UIView!
    
    private var mStatus: ViewStatusType = ViewStatusType.VIEW_CREATE
    public weak var mPresenter: PresenterProtocol?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        Log.debug("View \(type(of: self)) init")
    }
    
    deinit {
        Log.debug("View \(type(of: self)) deinit")
    }
    
    public func setStatus(status: ViewStatusType) {
        mStatus = status
    }
    
    public func getStatus() -> ViewStatusType {
        return mStatus
    }
    
    public func attachPresenter(presenter: PresenterProtocol) {
        mPresenter = presenter
    }
    
    public func hasMVPChildren() -> Bool {
        return false
    }
    
    public func onInitView() {
        remakeWrapperView()
    }
    
    public func onPortrait() {
        
    }
    
    public func onLandscape() {
        
    }
    
    private func remakeWrapperView() {
        if #available(iOS 11.0, *) {} else {
            
            guard let parentViewController = mPresenter else {
                fatalError("Expected a view controller here.")
            }
            guard let wrapperView = mWrapperView else {
                fatalError("Need add outlet wrapperView in View \(type(of: self))")
            }
            wrapperView.removeFromSuperview()
            addSubview(wrapperView)
            wrapperView.translatesAutoresizingMaskIntoConstraints = false
            let leftConstraint = NSLayoutConstraint(item: wrapperView,
                                                    attribute: .left,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .left,
                                                    multiplier: 1,
                                                    constant: 0)
            let topConstraint = NSLayoutConstraint(item: wrapperView,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: parentViewController.topLayoutGuide,
                                                   attribute: .bottom,
                                                   multiplier: 1,
                                                   constant: 0)
            let rightConstraint = NSLayoutConstraint(item: wrapperView,
                                                     attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: self,
                                                     attribute: .right,
                                                     multiplier: 1,
                                                     constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: wrapperView,
                                                      attribute: .bottom,
                                                      relatedBy: .equal,
                                                      toItem: parentViewController.bottomLayoutGuide,
                                                      attribute: .top,
                                                      multiplier: 1,
                                                      constant: 0)
            NSLayoutConstraint.activate([leftConstraint, topConstraint, rightConstraint, bottomConstraint])
        }
    }

}
