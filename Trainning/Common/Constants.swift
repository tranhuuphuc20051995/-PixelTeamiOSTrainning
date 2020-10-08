//
//  Constants.swift
//  Trainning
//
//  Created by Tri on 2020/10/08.
//

import Foundation

struct Constants {
    
    struct API {
        static let TOTAL_PAGE_DEFAULT = 1
        static let PAGE_DEFAULT = 1
        static let PAGE_LIMIT = 20
        static let CREATED_AT = "created_at"
        static let ASC = "ASC"
        static let DESC = "DESC"
    }
    
    static func getTopSafeArea() -> CGFloat {
        let window = UIApplication.shared.keyWindow
        let top = window?.safeAreaInsets.top ?? 0
        return top
    }
    
    static func getBottomSafeArea() -> CGFloat {
        let window = UIApplication.shared.keyWindow
        let bottom = window?.safeAreaInsets.bottom ?? 0
        return bottom
    }
}
