//
//  KFConstraints.swift
//  KonturFocus
//
//  Created by Admin on 24.03.17.
//  Copyright © 2017 Intechno. All rights reserved.
//

import UIKit

func addTopConstraint(_ view: UIView, toView: UIView, constant: CGFloat = 0)
{
    let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: toView, attribute: .top, multiplier: 1, constant: constant)
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([topConstraint])
}

func addBottomConstraint(_ view: UIView, toView: UIView, constant: CGFloat = 0)
{
    let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: toView, attribute: .bottom, multiplier: 1, constant: constant)
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([bottomConstraint])
}

func addLeadingConstraint(_ view: UIView, toView: UIView, constant: CGFloat = 0)
{
    let bottomConstraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: toView, attribute: .leading, multiplier: 1, constant: constant)
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([bottomConstraint])
}

func addTrailingConstraint(_ view: UIView, toView: UIView, constant: CGFloat = 0)
{
    let trailingConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: toView, attribute: .trailing, multiplier: 1, constant: constant)
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([trailingConstraint])
}

func addHeightConstraint(_ view: UIView, height: CGFloat)
{
    let heightConstraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([heightConstraint])
}

func addWidthConstraint(_ view: UIView, width: CGFloat)
{
    let widthConstraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([widthConstraint])
}

func addXConstraint(_ view: UIView, toView: UIView, constant: CGFloat = 0)
{
    let xConstraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: toView, attribute: .centerX, multiplier: 1, constant: constant)
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([xConstraint])
}

func addYConstraint(_ view: UIView, toView: UIView, constant: CGFloat = 0)
{
    let yConstraint = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: toView, attribute: .centerY, multiplier: 1, constant: constant)
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([yConstraint])
}
