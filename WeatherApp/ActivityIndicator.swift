//
//  ActivityView.swift
//  CallRecorder
//
//  Created by Admin on 16.02.17.
//  Copyright © 2017 Intehno. All rights reserved.
//

import UIKit

class ActivityIndicator: UIView
{
    var activityView: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func showActivity(_ view: UIView, title: String = "")
    {
        view.isUserInteractionEnabled = false
        view.window?.isUserInteractionEnabled = false
        view.endEditing(true)
      
        activityView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.addSubview(activityView)
        addTopConstraint(activityView, toView: view)
        addBottomConstraint(activityView, toView: view)
        addLeadingConstraint(activityView, toView: view)
        addTrailingConstraint(activityView, toView: view)
        
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 15
        activityView.addSubview(loadingView)
        addHeightConstraint(loadingView, height: 80)
        addWidthConstraint(loadingView, width: 80)
        addXConstraint(loadingView, toView: activityView)
        addYConstraint(loadingView, toView: activityView)
      
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        loadingView.addSubview(activityIndicator)
        addHeightConstraint(activityIndicator, height: 40)
        addWidthConstraint(activityIndicator, width: 40)
        addXConstraint(activityIndicator, toView: loadingView)
        addYConstraint(activityIndicator, toView: loadingView)
        activityIndicator.startAnimating()
    }
    
    func removeActivity(_ view: UIView)
    {
        view.isUserInteractionEnabled = true
        view.window?.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
        activityView.removeFromSuperview()
    }
}
