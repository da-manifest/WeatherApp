//
//  CustomInteractionController.swift
//  Calculator
//
//  Created by Admin on 15.12.16.
//  Copyright © 2016 Intehno. All rights reserved.
//

import UIKit

class CustomInteractionController: UIPercentDrivenInteractiveTransition
{
    var navigationController: UINavigationController!
    var shouldCompleteTransition = false
    var transitionInProgress = false
    var completionSeed: CGFloat
    {
        return 1 - percentComplete
    }
    
    func attachToViewController(_ viewController: UIViewController)
    {
        navigationController = viewController.navigationController
        setupGestureRecognizer(viewController.view)
    }
    
    fileprivate func setupGestureRecognizer(_ view: UIView)
    {
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(CustomInteractionController.handlePanGesture(_:))))
    }
    
    func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer)
    {
        let viewTranslation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        switch gestureRecognizer.state
        {
        case .began:
            transitionInProgress = true
            navigationController.popViewController(animated: true)
        case .changed:
            let const = CGFloat(fminf(fmaxf(Float(viewTranslation.x / 200.0), 0.0), 1.0))
            shouldCompleteTransition = const > 0.5
            update(const)
        case .cancelled, .ended:
            transitionInProgress = false
            if !shouldCompleteTransition || gestureRecognizer.state == .cancelled
            {
                cancel()
            }
            else
            {
                finish()
            }
        default:
            print("Swift switch must be exhaustive, thus the default")
        }
    }
}
