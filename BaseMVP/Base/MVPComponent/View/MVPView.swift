//
//  BaseView.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/16/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class MVPView: UIView, IView {
    
    @IBOutlet weak var mWrapperView: UIView!
    
    @IBOutlet weak var mNameTitleLb: UILabel!
    
    internal weak var mPresenter: IPresenter?
    
    func attachPresenter(_ presenter: IPresenter) {
        mPresenter = presenter
    }
    
    var hasMVPChildren: Bool = false
    
    func onInitView(topLayoutGuide: UILayoutSupport, bottomLayoutGuide: UILayoutSupport) {
        remakeWrapperView(topLayoutGuide: topLayoutGuide, bottomLayoutGuide: bottomLayoutGuide)
        print("🔹🔹🔹 View \(type(of: self)) init 🔹🔹🔹")
    }
    
    func onPortrait() {
        
    }
    
    func onLandscape() {
        
    }
    
    deinit {
        mPresenter = nil
        print("🔹🔹🔹 View \(type(of: self)) deinit 🔹🔹🔹")
    }
    
    func setTitle(_ name: String) {
        if mNameTitleLb != nil {
            mNameTitleLb.text = name
        }
    }
    
    
    private func remakeWrapperView(topLayoutGuide: UILayoutSupport, bottomLayoutGuide: UILayoutSupport) {
        if #available(iOS 11.0, *) {} else {
            guard let wrapperView = mWrapperView else {fatalError("Need add outlet wrapperView in View")}
            wrapperView.removeFromSuperview()
            addSubview(wrapperView)
            wrapperView.translatesAutoresizingMaskIntoConstraints = false
            let leftConstraint = NSLayoutConstraint(item: wrapperView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
            let topConstraint = NSLayoutConstraint(item: wrapperView, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
            let rightConstraint = NSLayoutConstraint(item: wrapperView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: wrapperView, attribute: .bottom, relatedBy: .equal, toItem: bottomLayoutGuide, attribute: .top, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([leftConstraint, topConstraint, rightConstraint, bottomConstraint])
        }
    }
    
}
