//
//  Bundle+.swift
//  altar
//
//  Created by Tri on 2020/08/23.
//

import Foundation

extension Bundle {
    var appVersion: String? {
        self.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    static var mainAppVersion: String? {
        Bundle.main.appVersion
    }
}
