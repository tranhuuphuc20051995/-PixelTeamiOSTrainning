//
//  ApiResponse.swift
//  altar
//
//  Created by Tri on 2020/08/29.
//

import Foundation

public struct ApiResponse<T: Codable>: Codable {
    
    var data: T?
    var statusCode: Int?
    var message: String?
    
    public init(data: T?, statusCode: Int?, message: String?) {
        self.data = data
        self.statusCode = statusCode
        self.message = message
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case data = "items"
        case statusCode
        case message
    }
    
}

public struct ItemsReponse<T: Codable>: Codable {
    
    var items: T?
    var paging: PagingReponse?
    
    public init(items: T?, paging: PagingReponse?) {
        self.items = items
        self.paging = paging
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case items = "items"
        case paging = "meta"
    }
    
}
