//
//  AuthorizationAdapter.swift
//  altar
//
//  Created by Tri on 2020/08/29.
//

import Alamofire

class InterceptorImpl: RequestInterceptor, RequestRetrier {
    
    static let shared = InterceptorImpl()
    
    var accessToken: String?
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.headers.add(.accept("application/json"))
        // TODO add token from keychain
        if let accessToken = accessToken {
            urlRequest.headers.add(.authorization(bearerToken: accessToken))
        }
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
    }

}
   
