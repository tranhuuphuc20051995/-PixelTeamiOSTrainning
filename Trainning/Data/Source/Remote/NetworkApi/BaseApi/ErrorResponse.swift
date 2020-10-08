//
//  ApiError.swift
//  altar
//
//  Created by Tri on 2020/08/30.
//

import Foundation

enum APIError: Error {
    case server(ErrorResponse?)
    case unknown(String?)
}

public struct ErrorResponse: Codable {
    
    var code: Int?
    var messages: String?
    
    public init(code: Int?, messages: String?) {
        self.code = code
        self.messages = messages
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case code = "statusCode"
        case messages = "message"
    }
}
