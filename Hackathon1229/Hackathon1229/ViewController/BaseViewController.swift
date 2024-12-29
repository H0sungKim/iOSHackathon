//
//  BaseViewController.swift
//  MyKream
//
//  Created by 김호성 on 2024.10.03.
//

import UIKit

class BaseViewController: UITabBarController {
    
    private let homeViewController = UINavigationController(rootViewController: HomeViewController())
    private let timerViewController = UINavigationController(rootViewController: TimerViewController())
    private let chartViewController = UINavigationController(rootViewController: ChartViewController())
    private let myViewController = UINavigationController(rootViewController: MyViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.viewControllers = [
            homeViewController,
            timerViewController,
            chartViewController,
            myViewController,
        ]
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .white
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .black
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
        
        self.tabBar.tintColor = .black
        
        homeViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(resource: .home), tag: 0)
        timerViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(resource: .timer), tag: 1)
        chartViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(resource: .barChartFill), tag: 2)
        myViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(resource: .person), tag: 3)
        
//        homeViewController.tabBarItem.selectedImage = UIImage(named: "icon_home_fill")
//        styleViewController.tabBarItem.selectedImage = UIImage(named: "icon_style_fill")
//        shopViewController.tabBarItem.selectedImage = UIImage(named: "icon_shop_fill")
//        savedViewController.tabBarItem.selectedImage = UIImage(named: "icon_saved_fill")
        
        
        self.selectedIndex = 4
    }
    
}
