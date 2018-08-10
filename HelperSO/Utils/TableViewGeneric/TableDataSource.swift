//
//  TableDataSource.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 10.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import Foundation
import UIKit

open class TableDataSource<Provider: TableDataProvider, Cell: UITableViewCell>:
    NSObject,
    UITableViewDataSource,
    UITableViewDelegate,
    UIGestureRecognizerDelegate
where Cell: ConfigurableCell, Provider.T == Cell.T {
    
    public typealias TableViewItemSelectionHandlerType = (IndexPath) -> Void
    public typealias TableVieItemSwipeSelectionHandlerType = (IndexPath) -> Void
    
    let provider: Provider
    let tableView: UITableView
    
    var originalCenter = CGPoint()
    var shouldExtend = false
    var isExtended = false
    
    public var tableSwipeSelectionHandler: TableVieItemSwipeSelectionHandlerType?
    public var tableItemSelectionHandler: TableViewItemSelectionHandlerType?
    
    init(tableView: UITableView, provider: Provider) {
        self.tableView = tableView
        self.provider = provider
        super.init()
        setUp()
    }
    
    func setUp() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.numberOfItems(in: section)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return provider.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(for: indexPath)
        
        if let item = provider.item(at: indexPath) {
            cell.configure(item, at: indexPath)
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableItemSelectionHandler?(indexPath)
    }
}
