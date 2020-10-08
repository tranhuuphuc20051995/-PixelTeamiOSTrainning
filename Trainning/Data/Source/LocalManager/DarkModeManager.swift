//
//  DarkModeManager.swift
//  altar
//
//  Created by Tri on 2020/10/02.
//

class DarkModeManager: NSObject {
    
    static let COLOR_DEFAULT: String = "#333333"
    
    static let shared = DarkModeManager()

    var isDarkMode = false
    
    private override init() {
        super.init()
        isDarkMode = AppManager.shared.userDefault.bool(forKey: .DARK_MODE)
    }
    
    func setDarkMode() {
        isDarkMode = true
        AppManager.shared.userDefault.set(true, forKey: .DARK_MODE)
    }
    
    func disableDarkMode() {
        isDarkMode = false
        AppManager.shared.userDefault.set(false, forKey: .DARK_MODE)
    }
    
    func getColor() -> String {
        return isDarkMode ? "#FFFFFF" : DarkModeManager.COLOR_DEFAULT
    }
    
}
