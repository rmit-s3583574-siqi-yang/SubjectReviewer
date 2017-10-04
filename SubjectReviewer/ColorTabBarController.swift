//
//  ColorTabBarController.swift
//  SubjectReviewer
//
//  Created by siqi yang on 3/10/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import UIKit

@IBDesignable class ColorTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBInspectable var barTintColor: UIColor? {
        set {
            tabBar.barTintColor = newValue
        }
        get {
            guard  let color = tabBar.barTintColor else { return nil }
            return color
        }
    }
    
    @IBInspectable var tintColor: UIColor? {
        set {
            tabBar.tintColor = newValue
        }
        get {
            guard  let color = tabBar.tintColor else { return nil }
            return color
        }
    }

}
