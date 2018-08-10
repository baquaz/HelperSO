//
//  NibLoadableView.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 10.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
