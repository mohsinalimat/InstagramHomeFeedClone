//
//  AppNavigationController.swift
//  InstagramHomefeedSwift
//
//  Created by Vamshi Krishna on 16/02/18.
//  Copyright © 2018 Vamshi Krishna. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationBar.tintColor = .white
        self.navigationBar.barTintColor = UIColor(red: 18.0 / 255.0, green: 86.0 / 255.0, blue: 136.0 / 255.0, alpha: 1)
        self.navigationBar.isTranslucent = false
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }


}
