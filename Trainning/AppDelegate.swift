//
//  AppDelegate.swift
//  Trainning
//
//  Created by Tri on 2020/10/08.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .white
        
        let initialNav = BaseNav()
        initialNav.navigationBar.isHidden = true
        initialNav.setRootViewController(MainViewController.instance())
        
        window?.rootViewController = initialNav
        window?.makeKeyAndVisible()
        return true
    }
 
}

