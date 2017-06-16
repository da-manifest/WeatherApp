//
//  NavigationExtension.swift
//  Calculator
//
//  Created by Admin on 27.12.16.
//  Copyright © 2016 Intehno. All rights reserved.
//

import Foundation
import UIKit
let customNavigationAnimationController = CustomNavigationAnimationController()
let customInteractionController = CustomInteractionController()


extension UIViewController
{
    @objc(navigationController:animationControllerForOperation:fromViewController:toViewController:) func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        if operation == .push
        {
            customInteractionController.attachToViewController(toVC)
        }
        customNavigationAnimationController.reverse = operation == .pop
        return customNavigationAnimationController
    }
    
    @objc(navigationController:interactionControllerForAnimationController:) func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    {
        return customInteractionController.transitionInProgress ? customInteractionController : nil
    }

}
