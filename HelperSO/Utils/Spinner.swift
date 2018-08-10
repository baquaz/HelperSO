//
//  Spinner.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 10.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import Foundation
import UIKit

class Spinner {
    
    static var container: UIView?
    static var activityIndicator: UIActivityIndicatorView?
    
    static func showActivityIndicator(on view: UIView) {
        guard Spinner.activityIndicator == nil && Spinner.activityIndicator == nil else { return }
        
        let container = UIView()
        
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        let loadingView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        view.addSubview(container)
        
        Spinner.activityIndicator = activityIndicator
        Spinner.container = container
        activityIndicator.startAnimating()
    }
    
    static func stop() {
        Spinner.activityIndicator?.stopAnimating()
        Spinner.container?.removeFromSuperview()
        Spinner.activityIndicator = nil
        Spinner.container = nil
    }
}

