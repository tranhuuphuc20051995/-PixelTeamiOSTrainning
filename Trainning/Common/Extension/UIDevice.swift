//
//  UIDevice.swift
//  altar
//
//  Created by Tri on 2020/08/14.
//

extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    enum ScreenType: String {
        case iPhoneSE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhone8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhonePlus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhoneX = "iPhone X"
        case iPhone11 = "iPhone 11, iPhone XR"
        case iPhone11ProMax = "iPhone 11 ProMax, iPhone XsMax"
        case unknown
    }
    
    static var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .iPhoneSE
        case 1334:
            return .iPhone8
        case 1920, 2208:
            return .iPhonePlus
        case 2436:
            return .iPhoneX
        case 1792:
            return .iPhone11
        case 2688:
            return .iPhone11ProMax
        default:
            return .unknown
        }
    }
}
