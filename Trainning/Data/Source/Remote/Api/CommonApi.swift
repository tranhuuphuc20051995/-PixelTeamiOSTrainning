//
//  CommonApi.swift
//  altar
//
//  Created by Tri on 2020/08/29.
//

import Foundation

public struct CommonApi {
    
    static func getUserList(modelRequest: BaseModelRequest) -> Single<([UserTest], PagingReponse?)> {
        let baseApi = BaseApi<ApiResponse<[UserTest]>>()
        let path = "search/repositories"
        
        var parameters: [String: Any] = [:]
        parameters["q"] = modelRequest.query
        parameters["page"] = modelRequest.page
        
        return baseApi.getItem(path: path, parameters: parameters)
            .asSingle()
            .map({ ($0.data ?? [], nil) })
            .observeOn(MainScheduler.instance)
    }
}

struct UserTest: Codable {
    
    var fullName: String? = nil
        
    init(fullName: String?) {
        self.fullName = fullName
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case fullName = "full_name"
    }
}

