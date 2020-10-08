//
//  JSONEncodingHelper.swift
//  altar
//
//  Created by Tri on 2020/08/29.
//

import Foundation

open class JSONEncodingHelper {
    
    open class func encodingParameters<T: Encodable>(forEncodableObject encodableObj: T?) -> [String: Any]? {
        var params: [String: Any]? = nil
        
        // Encode the Encodable object
        if let encodableObj = encodableObj {
            let encodeResult = CodableHelper.encode(encodableObj)
            do {
                let data = try encodeResult.get()
                params = JSONDataEncoding.encodingParameters(jsonData: data)
            } catch {

                print(error.localizedDescription)
            }
        }
        
        return params
    }
    
    open class func encodeToJsonFilePath<T:Encodable>(forEncodableObject encodableObj: T) -> URL? {
        let encodeResult = CodableHelper.encode(encodableObj)
        do {
            let data = try encodeResult.get()
            let tmpDirectory = NSHomeDirectory() + "/tmp"
            let url = URL(fileURLWithPath: tmpDirectory + "/\(UUID().uuidString).json")
            try data.write(to: url)
            return url
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
