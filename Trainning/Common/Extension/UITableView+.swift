//
//  UITableView+.swift
//  altar
//
//  Created by Tri on 2020/08/07.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    func registerCell<T>(ofType type: T.Type) {
        let typeName = String(describing: type)
        self.register(UINib(nibName: typeName, bundle: nil), forCellReuseIdentifier: typeName)
    }
    
    func dequeueCell<T>(indexPath: IndexPath) -> T {
        let typeName = String(describing: T.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: typeName, for: indexPath) as? T else {
            fatalError("couldnt dequeue cell with identifier \(typeName)")
        }
        return cell
    }
    
    func registerHeaderFooterCell<T>(ofType type: T.Type) {
        let typeName = String(describing: type)
        self.register(UINib(nibName: typeName, bundle: nil), forHeaderFooterViewReuseIdentifier: typeName)
    }
    
    func dequeueHeaderFooteCell<T>() -> T {
        let typeName = String(describing: T.self)
        guard let cell = self.dequeueReusableHeaderFooterView(withIdentifier: typeName) as? T else {
            fatalError("couldnt dequeue header or footer cell with identifier \(typeName)")
        }
        
        return cell
    }
    
    func removeFooterSlowly() {
        UIView.beginAnimations(nil, context: nil)
        self.tableFooterView = nil
        UIView.commitAnimations()
    }
}

