//
//  ConfigPaginate.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/22/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit


public protocol CPExtensionsProvider: class {
    associatedtype CompatibleType
    var cp: CompatibleType { get }
}

extension CPExtensionsProvider {
    /// A proxy which hosts reactive extensions for `self`.
    public var cp: CP<Self> {
        return CP(self)
    }
    
}

public struct CP<Base> {
    public let base: Base
    
    // Construct a proxy.
    //
    // - parameters:
    //   - base: The object to be proxied.
    fileprivate init(_ base: Base) {
        self.base = base
    }
}

//
extension UIScrollView: CPExtensionsProvider {}

public extension CP where Base: UIScrollView {
    
    var removeLoadMoreAfterLoading: Bool {
        get {
            return (self.base.layer.value(forKey: UIScrollView.kRemoveLoadMoreView) as? Bool) ?? true
        }
        set {
            self.base.layer.setValue(newValue, forKey: UIScrollView.kRemoveLoadMoreView)
        }
    }
    
    func enableLoadMore(_ enable: Bool) {
        if enable {
            if self.base.loadMoreView == nil {
                self.base.loadMoreView = self.base.initLoadmoreViewIfNeed()
            }
        } else {
            if self.base.loadMoreView != nil {
                self.base.loadMoreView?.removeFromSuperview()
                self.base.loadMoreView = nil
            }
        }
    }
    
    func start() {
        if self.base.loadMoreView == nil {
            self.base.loadMoreView = self.base.initLoadmoreViewIfNeed()
        }
        self.base.loadMoreView?.start()
    }
    
    func stop() {
        self.base.loadMoreView?.stop()
        if removeLoadMoreAfterLoading {
            if self.base.loadMoreView != nil {
                self.base.loadMoreView?.removeFromSuperview()
                self.base.loadMoreView = nil
            }
        }
        
    }
}
extension UIScrollView {
    fileprivate static let kViewForLoadMore = "view_for_load_more"
    fileprivate static let kRemoveLoadMoreView = "remove_load_more_view"
    
    var loadMoreView: LoadMoreView? {
        get {
            return self.layer.value(forKey: UIScrollView.kViewForLoadMore) as? LoadMoreView
        }
        set {
            return self.layer.setValue(newValue, forKey: UIScrollView.kViewForLoadMore)
        }
    }
    
    fileprivate func initLoadmoreViewIfNeed() -> LoadMoreView {
        let footerView = LoadMoreView(frame: CGRect(x: 0, y: self.contentSize.height + self.contentInset.bottom, width: self.bounds.width, height: 100))
        self.addSubview(footerView)
        self.loadMoreView = footerView
        return footerView
    }
}

class LoadMoreView: UIView {
    func start() {
        
    }
    
    func stop() {
        
    }
}
