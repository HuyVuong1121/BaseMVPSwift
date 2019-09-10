//
//  SubDetailView.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/21/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class SubDetailView: MVPView {
    
    // Assign custom class to table view in storyboard
    @IBOutlet weak var collectionView: PaginatedCollectionView!
    
    var list = [Int]()
    
    override func onInitView(topLayoutGuide: UILayoutSupport, bottomLayoutGuide: UILayoutSupport) {
        super.onInitView(topLayoutGuide: topLayoutGuide, bottomLayoutGuide: bottomLayoutGuide)
        
        collectionView.registerCell(type: SubDetailCollectionViewCell.self)
//
//        // Add paginated delegates only
        collectionView.paginatedDataSource = self
        collectionView.paginatedDelegate = self
        
        // More settings
        collectionView.enablePullToRefresh = true
        collectionView.paginatedDelegateFlowLayout = self
        collectionView.loadData(refresh: true)
    }
    
    @IBAction func gotoPrevScreen(_ sender: UIButton) {
        mPresenter?.executeCommand(command: PrevCommand())
    }
    
    struct PrevCommand: ICommand {}
}

extension SubDetailView: PaginatedCollectionViewDelegate {
    func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?) {
        // Call your api here
        // Send true in onSuccess in case new data exists, sending false will disable pagination
        if pageNumber > 5 {
            onSuccess?(false)
        } else {
            // If page number is first, reset the list
            if pageNumber == 1 { self.list = [Int]() }
            
            // else append the data to list
            let startFrom = (self.list.last ?? 0) + 1
            for number in startFrom..<(startFrom + pageSize) {
                self.list.append(number)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                onSuccess?(true)
            }
        }
        
    }
}

extension SubDetailView: PaginatedCollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: SubDetailCollectionViewCell.self, for: indexPath)
        cell.nameLabel.text = "\(indexPath.row)"
        cell.backgroundColor = .red
        return cell
    }
}

extension SubDetailView: PaginatedCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = UIScreen.main.bounds.width/2
        return CGSize(width: height, height: height)
    }
}
