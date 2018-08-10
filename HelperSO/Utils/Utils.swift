//
//  Utils.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 10.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import UIKit

//MARK: - Table View
extension UITableView {
    //MARK: Register cell
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableCell {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableCell, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}
