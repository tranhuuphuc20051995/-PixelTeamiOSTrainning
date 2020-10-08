//
//  Dlog.swift
//  Trainning
//
//  Created by Tri on 2020/10/08.
//

import Foundation

public struct Dlog {
    
    public static func log(_ contents : Any, file : String = #file, function : String = #function, line : Int = #line) {
        #if DEBUG
        let className = (file as NSString).lastPathComponent
        print("[\(className)] \(function) Line:\(line) \(contents)")
        
        #else
        //
        #endif
    }
    
    public static func logAPI(_ contents : Any) {
        log(contents)
    }
    
    public static func logThread() {
        let contents = Thread.isMainThread ? "MainThread" : "BackgroundThread"
        log(contents)
    }

}
