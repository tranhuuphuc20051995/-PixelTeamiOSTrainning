//
//  CommonRepository.swift
//  Trainning
//
//  Created by Tri on 2020/10/08.
//

protocol CommonRepository {
    func getUserList(modelRequest: BaseModelRequest) -> Single<([UserTest], PagingReponse?)>
}

class CommonRepositoryImpl: CommonRepository {
    
    func getUserList(modelRequest: BaseModelRequest) -> Single<([UserTest], PagingReponse?)> {
        return CommonApi.getUserList(modelRequest: modelRequest)
            .observeOn(MainScheduler.instance)
    }
}
 
