//
//  PaginatedTableView.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/20/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

@objc public protocol PaginatedTableViewDelegate: class {
    @objc optional func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?)

}

//
// MARK: A wrapper around table view to make pagination easier and reuseable.
// Most of the pagination logic is taken care of here instead of viewcontroller
//
public class PaginatedTableView: UITableView {
    
    // Infinite scrolling
    // Page size can be changed from view controller as well
    public var pageSize = 20
    private var hasMoreData = true
    private(set) var currentPage = 1
    private(set) var isLoading = false
    
    // First page can vary for different APIs thus can be changed from the VC
    public var firstPage = 1
   
    public var enablePullToRefresh = false {
        willSet {
            if newValue == enablePullToRefresh { return }
            if newValue {
                self.addSubview(refreshControltableView)
            } else {
                refreshControltableView.removeFromSuperview()
            }
        }
    }
    
    public var enableLoadMore = false {
        willSet {
            if newValue == enableLoadMore { return }
            if newValue {
                self.loadControl = UILoadControl(target: self, action: #selector(handleLoadMore(sender:)))
            }
        }
    }
    
    // Only delegates you want to assign value to while using this wrapper
    weak open var paginatedDelegate: PaginatedTableViewDelegate?
   
    // refresh control
    lazy var refreshControltableView: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.handleRefreshtableView(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    // custom refresh logic after data is loaded, when you do not
    // want to call tableView.reloadData() and want to refresh
    // certain sections instead
    public var customReloadDataBlock: (() -> Void)?
    
    //initWithFrame to init view from code
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    deinit {
        print("🔹🔹🔹 \(type(of: self)) deinit 🔹🔹🔹")
    }
    
    //common func to init our view
    private func setupView() {
        self.alwaysBounceVertical = true
        
        // Enable pull to refresh control
        self.enablePullToRefresh = true
    }
}

//
// MARK: Helper functions
//
extension PaginatedTableView {
    
    public func loadData(refresh: Bool = false) {
        load(refresh: refresh)
    }
    
    @objc fileprivate func handleRefreshtableView(_ refreshControl: UIRefreshControl) {
        load(refresh: true)
    }
    
    @objc private func handleLoadMore(sender: AnyObject?) {
        load()
    }

    
    // All loading logic goes here i.e. showing/hiding of loaders and pagination
    private func load(refresh: Bool = false) {
        
        // reset page number if refresh
        if refresh {
            currentPage = firstPage
            hasMoreData = true
        }
        
        // return if already loading or dont have any more data
        if !hasMoreData || isLoading { return }
        
        // start loading
        isLoading = true
        paginatedDelegate?.loadMore?(currentPage, pageSize, onSuccess: { hasMore in
            self.hasMoreData = hasMore
            self.currentPage += 1
            self.isLoading = false
            self.refreshControltableView.endRefreshing()
            if self.customReloadDataBlock != nil {
                self.customReloadDataBlock?()
            } else {
                self.reloadData()
            }
        }, onError: { _ in
            self.refreshControltableView.endRefreshing()
            self.isLoading = false
        })
    }
    
    // Scroll to end detector
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.loadControl?.update()
    }
}
