//
//  TableArrayDataProvider.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 10.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import Foundation

public class TableArrayDataProvider<T>: TableDataProvider {
    var items: [[T]] = []
    
    init(array: [[T]]) {
        items = array
    }
    
    public func numberOfSections() -> Int {
        return items.count
    }
    
    public func numberOfItems(in section: Int) -> Int {
        guard section >= 0 && section < items.count else {
            return 0
        }
        return items[section].count
    }
    
    public func item(at indexPath: IndexPath) -> T? {
        guard indexPath.section >= 0 &&
            indexPath.section < items.count &&
            indexPath.row >= 0 &&
            indexPath.row < items[indexPath.section].count else {
                return nil
        }
        
        return items[indexPath.section][indexPath.row]
    }
    
    public func updateItem(at indexPath: IndexPath, value: T) {
        guard indexPath.section >= 0 &&
            indexPath.section < items.count &&
            indexPath.row >= 0 &&
            indexPath.row < items[indexPath.section].count else {
                return
        }
        
        items[indexPath.section][indexPath.row] = value
    }
    
    public func removeItem(at indexPath: IndexPath) {
        guard indexPath.section >= 0 &&
            indexPath.section < items.count &&
            indexPath.row >= 0 &&
            indexPath.row < items[indexPath.section].count else {
                return
        }
        items[indexPath.section].remove(at: indexPath.row)
    }
}
