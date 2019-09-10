//
//  UILoadControl.swift
//  BaseMVP
//
//  Created by Chung-Sama on 9/10/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class UILoadControl: UIControl {
    fileprivate var activityIndicatorView: UIActivityIndicatorView!
    
    internal var target: AnyObject?
    internal var action: Selector!
    
    public var heightLimit: CGFloat = 80.0
    public fileprivate (set) var loading: Bool = false
    
    var scrollView: UIScrollView = UIScrollView()
    
    override public var frame: CGRect {
        didSet{
            if (frame.size.height > heightLimit) && !loading {
                self.sendActions(for: .valueChanged)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    public init(target: AnyObject?, action: Selector) {
        self.init()
        self.initialize()
        self.target = target
        self.action = action
        addTarget(self.target, action: self.action, for: .valueChanged)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    
    /*
     Update layout at finish to load
     */
    public func endLoading() {
        self.setLoading(isLoading: false)
        self.fixPosition()
    }
    
    public func update() {
        updateUI()
    }
}

extension UILoadControl {
    
    /*
     Initialize the control
     */
    fileprivate func initialize() {
        self.addTarget(self, action: #selector(UILoadControl.didValueChange(sender:)), for: .valueChanged)
        setupActivityIndicator()
    }
    
    /*
     Check if the control frame should be updated.
     This method is called after user hits the end of the scrollView
     */
    fileprivate func updateUI() {
        if self.scrollView.contentSize.height < self.scrollView.bounds.size.height {
            return
        }
        
        let contentOffSetBottom = max(0, ((scrollView.contentOffset.y + scrollView.frame.size.height) - scrollView.contentSize.height))
        print("UILoadControl", "contentOffset y: ", scrollView.contentOffset.y, "frame size height: ", scrollView.frame.size.height, "contentSize height: ", scrollView.contentSize.height)
        if (contentOffSetBottom >= 0 && !loading) || (contentOffSetBottom >= heightLimit && loading) {
            self.updateFrame(rect: CGRect(x: 0.0, y: scrollView.contentSize.height, width: scrollView.frame.size.width, height: contentOffSetBottom))
        }
    }
    
    /*
     Update layout after user scroll the scrollView
     */
    fileprivate func updateFrame(rect: CGRect) {
        guard let superview = self.superview else { return }
        superview.frame = rect
        frame = superview.bounds
        activityIndicatorView.alpha = (((frame.size.height * 100) / heightLimit) / 100)
        activityIndicatorView.center = CGPoint(x: (frame.size.width / 2), y: (frame.size.height / 2))
    }
    
    /*
     Place control at the scrollView bottom
     */
    fileprivate func fixPosition() {
        self.updateFrame(rect: CGRect(x: 0.0,
                                      y: scrollView.contentSize.height,
                                      width: scrollView.contentSize.width,
                                      height: 0.0))
    }
    
    /*
     Set layout to a "loading" or "not loading" state
     */
    fileprivate func setLoading(isLoading: Bool) {
        self.loading = isLoading
        DispatchQueue.main.async { [weak self] in
            guard let StrongSelf = self else { return }
            var contentInset = StrongSelf.scrollView.contentInset
            
            if StrongSelf.loading {
                contentInset.bottom = StrongSelf.heightLimit
                StrongSelf.activityIndicatorView.startAnimating()
            } else {
                contentInset.bottom = 0.0
                StrongSelf.activityIndicatorView.stopAnimating()
            }
            
            StrongSelf.scrollView.contentInset = contentInset
        }
    }
    
    /*
     Prepare activityIndicator
     */
    private func setupActivityIndicator() {
        if self.activityIndicatorView != nil {
            return
        }
        self.activityIndicatorView = UIActivityIndicatorView(style: .gray)
        self.activityIndicatorView.hidesWhenStopped = false
        self.activityIndicatorView.color = UIColor.darkGray
        self.activityIndicatorView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        
        addSubview(self.activityIndicatorView)
        bringSubviewToFront(self.activityIndicatorView)
    }
    
    @objc fileprivate func didValueChange(sender: AnyObject?){
        setLoading(isLoading: true)
    }
}
