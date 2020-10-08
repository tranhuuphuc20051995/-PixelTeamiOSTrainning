//
//  PagingReponse.swift
//  altar
//
//  Created by Tri on 2020/09/12.
//

import Foundation

public struct PagingReponse: Codable {
    
    var totalItems: Int = 0
    var totalPages: Int = 0
    var currentPage: Int = 0
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case totalItems
        case totalPages
        case currentPage
    }
    
    init() {
        currentPage = 1
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            currentPage = try container.decode(Int.self, forKey: .currentPage)
        } catch DecodingError.typeMismatch {
            currentPage = try Int(container.decode(String.self, forKey: .currentPage)) ?? 0
        }
        
        totalItems = try container.decode(Int.self, forKey: .totalItems)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
    }
}

extension PagingReponse {
    func nextPage() -> Int {
        return currentPage + 1
    }
    
    func isCanLoadMore() -> Bool {
        return currentPage < totalPages
    }
}
