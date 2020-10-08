//
//  BaseApi.swift
//  altar
//
//  Created by Tri on 2020/08/29.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

struct BaseApiConstaint {
    static var END_POINT = "https://api.github.com"
}

final class BaseApi<T: Decodable> {
    
    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    private let interceptor: InterceptorImpl
    
    private typealias Validation = (_ request: URLRequest?,_ response: HTTPURLResponse,_ data: Data?) -> Request.ValidationResult
    private var validator: Validation = { (request, response, data) -> Request.ValidationResult in
        switch response.statusCode {
        case 200..<300:
            return Request.ValidationResult.success(())
        default:
            var errorReponse: ErrorResponse?
            if let data = data {
                do {
                    errorReponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                } catch {
                    return Request.ValidationResult.failure(error)
                }
            }
            
            let error: Error
            
            if let errorReponse = errorReponse {
                error = APIError.server(errorReponse)
            } else {
                let json: String? = (try? JSONSerialization.jsonObject(with: data!, options: []) as? String) ?? nil
                error = APIError.unknown(json)
            }
            Dlog.log(error)
            return Request.ValidationResult.failure(error)
        }
    }
    
    init() {
        self.interceptor = InterceptorImpl.shared
        self.endPoint = BaseApiConstaint.END_POINT
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    func getItem(path: String, parameters: [String: Any]? = nil) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)"
        Dlog.log(absolutePath)
        return RxAlamofire
            .request(.get, absolutePath, parameters: parameters,
                     encoding: URLEncoding.default,
                     interceptor: self.interceptor)
            .observeOn(scheduler)
            .debug()
            .flatMapLatest({ dataRequest -> Observable<(HTTPURLResponse, Data)> in
                return dataRequest.validate(self.validator).rx.responseData()
            })
            .map({ reponse -> T in
                // reponse: (HTTPURLResponse, Data)
                Dlog.logAPI(reponse.0)
                let data = try JSONDecoder().decode(T.self, from: reponse.1)
                Dlog.logAPI(data)
                return data
            })
    }
    
    func postItem(path: String,
                  parameters: [String: Any]? = nil,
                  encoding: ParameterEncoding = JSONEncoding.default) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)"
        Dlog.log(absolutePath)
        return RxAlamofire
            .request(.post, absolutePath, parameters: parameters,
                     encoding: encoding,
                     interceptor: self.interceptor)
            .debug()
            .observeOn(scheduler)
            .flatMapLatest({ dataRequest -> Observable<(HTTPURLResponse, Data)> in
                return dataRequest.validate(self.validator).rx.responseData()
            })
            .map({ reponse -> T in
                // reponse: (HTTPURLResponse, Data)
                Dlog.logAPI(reponse.0)
                let data = try JSONDecoder().decode(T.self, from: reponse.1)
                Dlog.logAPI(data)
                return data
            })
    }
    
    func updateItem(path: String,
                    parameters: [String: Any]? = nil,
                    encoding: ParameterEncoding = JSONEncoding.default) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)"
        Dlog.log(absolutePath)
        return RxAlamofire
            .request(.put, absolutePath, parameters: parameters,
                     encoding: encoding,
                     interceptor: self.interceptor)
            .observeOn(scheduler)
            .debug()
            .flatMapLatest({ dataRequest -> Observable<(HTTPURLResponse, Data)> in
                return dataRequest.validate(self.validator).rx.responseData()
            })
            .map({ reponse -> T in
                // reponse: (HTTPURLResponse, Data)
                Dlog.logAPI(reponse.0)
                let data = try JSONDecoder().decode(T.self, from: reponse.1)
                Dlog.logAPI(data)
                return data
            })
    }
    
    func deleteItem(path: String,
                    parameters: [String: Any]? = nil,
                    encoding: ParameterEncoding = JSONEncoding.default) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)"
        Dlog.log(absolutePath)
        return RxAlamofire
            .request(.delete, absolutePath, parameters: parameters,
                     encoding: encoding,
                     interceptor: self.interceptor)
            .observeOn(scheduler)
            .debug()
            .flatMapLatest({ dataRequest -> Observable<(HTTPURLResponse, Data)> in
                return dataRequest.validate(self.validator).rx.responseData()
            })
            .map({ reponse -> T in
                // reponse: (HTTPURLResponse, Data)
                Dlog.logAPI(reponse.0)
                let data = try JSONDecoder().decode(T.self, from: reponse.1)
                Dlog.logAPI(data)
                return data
            })
    }
}

