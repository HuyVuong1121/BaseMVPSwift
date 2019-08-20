//
//  UITableView+Extensions.swift
//  BaseMVP
//
//  Created by Chung-Sama on 8/20/19.
//  Copyright © 2019 ChungTV. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(type cellType: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerCell<T: UITableViewCell>(types cellTypes: [T.Type]) where T: ReusableView, T: NibLoadableView {
        for type in cellTypes {
            registerCell(type: type)
        }
    }
    
    func registerCellClass<T: UITableViewCell>(type cellType: T.Type) where T: ReusableView {
        register(cellType, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerCellClass<T: UITableViewHeaderFooterView>(type cellType: T.Type) where T: ReusableView {
        register(cellType, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerCellClass<T: UITableViewCell>(types cellTypes: [T.Type]) where T: ReusableView {
        for type in cellTypes {
            registerCellClass(type: type)
        }
    }
}

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, for indexPath: IndexPath) -> T where T: ReusableView, T: NibLoadableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>(type: T.Type) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewHeaderFooterView>(type: T.Type) -> T where T: ReusableView {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return view
    }
}

