//
//  AppManager.swift
//  altar
//
//  Created by Tri on 2020/08/01.
//

import Foundation

enum AppKey: String {

    case FIRST_LAUNCH = "FIRST_LAUNCH"
}

protocol AppManagerType {
    
    func isFirstLaunchApp() -> Bool
}

final class AppManager: AppManagerType {
    
    static let shared: AppManager = AppManager()
    
    var userDefault = UserDefaults.standard
    
    init() {
    
    }
    
    func isFirstLaunchApp() -> Bool {
        return !self.userDefault.bool(forKey: .FIRST_LAUNCH)
    }
}

extension UserDefaults {
    
    func set<T>(_ value: T?, forKey key: AppKey) {
        set(value, forKey: key.rawValue)
    }
    
    func value<T>(forKey key: AppKey) -> T? {
        return value(forKey: key.rawValue) as? T
    }
}
 
extension UserDefaults {
    
    func bool(forKey key: AppKey) -> Bool {
        return bool(forKey: key.rawValue)
    }
    
    func integer(forKey key: AppKey) -> Int {
        return integer(forKey: key.rawValue)
    }
}
