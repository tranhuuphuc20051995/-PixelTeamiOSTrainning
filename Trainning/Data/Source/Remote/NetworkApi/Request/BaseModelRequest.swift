//
//  BaseModelRequest.swift
//  Trainning
//
//  Created by Tri on 2020/10/08.
//

import Foundation

public struct BaseModelRequest {
    var query: String? = nil
    var orderBy: String? = nil
    var order: String? = nil
    var page: Int = Constants.API.PAGE_DEFAULT
    var totalPage = Constants.API.TOTAL_PAGE_DEFAULT
    
    mutating func resetData() {
        self.query = nil
        self.orderBy = nil
        self.order = nil
        self.page = Constants.API.PAGE_DEFAULT
        self.totalPage = Constants.API.TOTAL_PAGE_DEFAULT
    }
}
