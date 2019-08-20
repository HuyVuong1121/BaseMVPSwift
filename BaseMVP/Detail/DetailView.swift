//
//  DetailView.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/19/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

class DetailView: MVPView {
    
    // Assign custom class to table view in storyboard
    @IBOutlet weak var tableView: PaginatedTableView!
    
    var list = [Int]()
    
    override func onInitView(topLayoutGuide: UILayoutSupport, bottomLayoutGuide: UILayoutSupport) {
        super.onInitView(topLayoutGuide: topLayoutGuide, bottomLayoutGuide: bottomLayoutGuide)
        
        tableView.registerCell(type: DetailTableViewCell.self)
        
        // Add paginated delegates only
        tableView.paginatedDelegate = self
        tableView.paginatedDataSource = self
        
        // More settings
        tableView.enablePullToRefresh = true
        
        tableView.loadData(refresh: true)
    }
    
    @IBAction func gotoPrevScreen(_ sender: UIButton) {
        mPresenter?.executeCommand(command: PrevCommand())
    }
    
    struct PrevCommand: ICommand {}
}

//
// MARK Paginated Delegate - Where magic happens
//
extension DetailView: PaginatedTableViewDelegate {

    func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?) {
        // Call your api here
        // Send true in onSuccess in case new data exists, sending false will disable pagination
        
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

//
// MARK: Paginated Data Source
//
extension DetailView: PaginatedTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: DetailTableViewCell.self, for: indexPath)
        cell.indexLbl.text = "\(indexPath.row)"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
