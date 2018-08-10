//
//  TableArrayDataSource.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 10.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import Foundation
import UIKit

open class TableArrayDataSource<T, Cell: UITableViewCell>: TableDataSource<TableArrayDataProvider<T>, Cell> where Cell: ConfigurableCell, Cell.T == T {
    public convenience init(tableView: UITableView, array: [T]) {
        self.init(tableView: tableView, array: [array])
    }
    
    public init(tableView: UITableView, array: [[T]]) {
        let provider = TableArrayDataProvider(array: array)
        super.init(tableView: tableView, provider: provider)
    }
    
    public func item(at indexPath: IndexPath) -> T? {
        return provider.item(at: indexPath)
    }
    
    public func updateItem(at indexPath: IndexPath, value: T) {
        provider.updateItem(at: indexPath, value: value)
    }
    
    public func removeItem(at indexPath: IndexPath) {
        provider.removeItem(at: indexPath)
    }
}
