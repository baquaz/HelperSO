//
//  TableDataProvider.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 10.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import Foundation
import UIKit

public protocol TableDataProvider {
    associatedtype T
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> T?
    
    func updateItem(at indexPath: IndexPath, value: T)
}
