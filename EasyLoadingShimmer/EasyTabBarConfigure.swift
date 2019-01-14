//
//  EasyTabBarConfigure.swift
//  EasyLoadingShimmer
//
//  Created by sj_w on 2019/1/11.
//  Copyright © 2019年 sj_w. All rights reserved.
//

import Foundation
import UIKit

class EasyTabBarConfigure: NSObject {
    
    func configureTabBarController() -> UITabBarController {
        let tabBar: UITabBarController = UITabBarController()
        
        let v1 = ViewController()
        v1.title = "Home"
        v1.tabBarItem = UITabBarItem (title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        let nav1: UINavigationController = UINavigationController(rootViewController: v1)
        
        let v2 = TableViewController()
        v2.title = "Table"
        v2.tabBarItem = UITabBarItem (title: "Table", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        let nav2: UINavigationController = UINavigationController(rootViewController: v2)
        
        tabBar.viewControllers = [nav1, nav2]
        
        return tabBar
    }
}
