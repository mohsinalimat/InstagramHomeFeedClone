//
//  AppTabBarController.swift
//  InstagramHomefeedSwift
//
//  Created by Vamshi Krishna on 16/02/18.
//  Copyright © 2018 Vamshi Krishna. All rights reserved.
//

import UIKit

let tabBarPostButton = UIButton()
class AppTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .white
        self.tabBar.barTintColor = UIColor(red: 37.0 / 255.0, green: 39.0 / 255.0, blue: 42.0 / 255.0, alpha: 1)
        self.tabBar.isTranslucent = false
        
        // custom button
        let itemWidth = self.view.frame.size.width / 5
        let itemHeight = self.tabBar.frame.size.height
        tabBarPostButton.frame = CGRect(x: itemWidth * 2, y: self.view.frame.size.height - itemHeight, width: itemWidth - 10, height: itemHeight)
        tabBarPostButton.setBackgroundImage(UIImage(named: "upload.png"), for: UIControlState())
        tabBarPostButton.adjustsImageWhenHighlighted = false
        tabBarPostButton.addTarget(self, action: #selector(upload(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(tabBarPostButton)
    }
    
    
    @objc func upload(_ sender : UIButton) {
        self.selectedIndex = 2
    }

}
