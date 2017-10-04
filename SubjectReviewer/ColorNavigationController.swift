//
//  ColorNavigationController.swift
//  SubjectReviewer
//
//  Created by siqi yang on 25/9/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//  Reference https://stackoverflow.com/a/45094082  by Fangming Ning 2017 Jul 14 at 3:27

import UIKit

@IBDesignable class ColorNavigationController: UINavigationController {
    
    @IBInspectable var barTintColor: UIColor? {
        set {
            navigationBar.barTintColor = newValue
        }
        get {
            guard  let color = navigationBar.barTintColor else { return nil }
            return color
        }
    }
    
    @IBInspectable var tintColor: UIColor? {
        set {
            navigationBar.tintColor = newValue
        }
        get {
            guard  let color = navigationBar.tintColor else { return nil }
            return color
        }
    }
    
    @IBInspectable var titleColor: UIColor? {
        set {
            guard let color = newValue else { return }
            navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: color]
        }
        get {
            return navigationBar.titleTextAttributes?["NSForegroundColorAttributeName"] as? UIColor
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}
