//
//  AlertView.swift
//  WeatherApp
//
//  Created by Admin on 15/06/2017.
//  Copyright © 2017 da_manifest. All rights reserved.
//

import UIKit

func fireAlert(title: String, message: String)
{
    let topWindow = UIWindow(frame: UIScreen.main.bounds)
    topWindow.rootViewController = UIViewController()
    topWindow.windowLevel = UIWindowLevelAlert + 1
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "confirm"), style: .cancel, handler:
        {(_ action: UIAlertAction) -> Void in
            topWindow.isHidden = true
    }))
    topWindow.makeKeyAndVisible()
    topWindow.rootViewController?.present(alert, animated: true, completion: { _ in })
}
