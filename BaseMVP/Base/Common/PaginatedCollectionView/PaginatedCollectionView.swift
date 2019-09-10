//
//  PaginatedCollectionView.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/21/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit
@objc public protocol PaginatedCollectionViewDataSource: class {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func numberOfSections(in collectionView: UICollectionView) -> Int
    
    @objc optional func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    
}

@objc public protocol PaginatedCollectionViewDelegate: class {
    @objc optional func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    
    @objc optional func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    
    @objc optional func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath)
    
    @objc optional func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    
    @objc optional func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath)
    
    func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?)
}

@objc public protocol PaginatedCollectionViewDelegateFlowLayout: class {
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    
    @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
}


class PaginatedCollectionView: UICollectionView {
    
    // Infinite scrolling
    // Page size can be changed from view controller as well
    public var pageSize = 20
    private var hasMoreData = true
    private(set) var currentPage = 1
    private(set) var isLoading = false
    
    // First page can vary for different APIs thus can be changed from the VC
    public var firstPage = 1
    
    // Table view settings
    private var sections = 0
    public var loadMoreViewHeight: CGFloat = 100
    
    // Only delegates you want to assign value to while using this wrapper
    weak open var paginatedDelegate: PaginatedCollectionViewDelegate?
    weak open var paginatedDataSource: PaginatedCollectionViewDataSource?
    weak open var paginatedDelegateFlowLayout: PaginatedCollectionViewDelegateFlowLayout?
    
    // custom refresh logic after data is loaded, when you do not
    // want to call tableView.reloadData() and want to refresh
    // certain sections instead
    public var customReloadDataBlock: (() -> Void)?
    
    public var enablePullToRefresh = false {
        willSet {
            if newValue == enablePullToRefresh { return }
            if newValue {
                self.addSubview(refreshControlCollectionView)
            } else {
                refreshControlCollectionView.removeFromSuperview()
            }
        }
    }
    
    // refresh control
    lazy var refreshControlCollectionView: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.handleRefreshtableView(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        self.delegate = self
        self.dataSource = self
        // Enable pull to refresh control
        self.enablePullToRefresh = true
        
        // register load more cell
        self.registerCell(type: BaseLoadMoreCollectionCell.self)
    }
}

extension PaginatedCollectionView: UICollectionViewDelegate {

}

extension PaginatedCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return paginatedDataSource?.numberOfSections(in: collectionView) ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return paginatedDataSource?.collectionView(collectionView, numberOfItemsInSection: section) ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return paginatedDataSource?.collectionView(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return paginatedDataSource?.collectionView?(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath) ?? UICollectionReusableView()
    }
    
}

extension PaginatedCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return paginatedDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath) ?? CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return paginatedDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, insetForSectionAt: section) ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return paginatedDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return paginatedDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return paginatedDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, referenceSizeForFooterInSection: section) ?? CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return paginatedDelegateFlowLayout?.collectionView?(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: section) ?? CGSize(width: 0, height: 0)
    }
}

////
//// MARK: Prefetching data source
////
//extension PaginatedCollectionView: UICollectionViewDataSourcePrefetching {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        if indexPaths.contains(where: { $0.section == sections - 1 }) {
//            self.cp.start()
//            load()
//        }
//    }
//
//}

//
// MARK: Helper functions
//
extension PaginatedCollectionView {
    
    public func loadData(refresh: Bool = false) {
        load(refresh: refresh)
    }
    
    @objc fileprivate func handleRefreshtableView(_ refreshControl: UIRefreshControl) {
        load(refresh: true)
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
        paginatedDelegate?.loadMore(currentPage, pageSize, onSuccess: { hasMore in
            self.hasMoreData = hasMore
            self.isLoading = false
            if hasMore {
                self.currentPage += 1
            }
            self.refreshControlCollectionView.endRefreshing()
            self.cp.stop()
            if self.customReloadDataBlock != nil {
                self.customReloadDataBlock?()
            } else {
                self.reloadData()
            }
        }, onError: { _ in
            self.refreshControlCollectionView.endRefreshing()
            self.isLoading = false
            self.cp.stop()
        })
    }
    
    // Scroll to end detector
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            self.cp.start()
            load()
        }
    }
}
