//
//  CodableHelper.swift
//  Trainning
//
//  Created by Tri on 2020/10/08.
//

public typealias EncodeResult = (data: Data?, error: Error?)

public class CodableHelper {
    
    private static var customDateFormatter: DateFormatter?
    private static var defaultDateFormatter: DateFormatter = OpenISO8601DateFormatter()
    private static var customJSONDecoder: JSONDecoder?
    private static var defaultJSONDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(CodableHelper.dateFormatter)
        return decoder
    }()
    private static var customJSONEncoder: JSONEncoder?
    private static var defaultJSONEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(CodableHelper.dateFormatter)
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }()
    
    public static var dateFormatter: DateFormatter {
        get { return self.customDateFormatter ?? self.defaultDateFormatter }
        set { self.customDateFormatter = newValue }
    }
    
    public static var jsonDecoder: JSONDecoder {
        get { return self.customJSONDecoder ?? self.defaultJSONDecoder }
        set { self.customJSONDecoder = newValue }
    }
    
    public static var jsonEncoder: JSONEncoder {
        get { return self.customJSONEncoder ?? self.defaultJSONEncoder }
        set { self.customJSONEncoder = newValue }
    }
    
    open class func decode<T>(_ type: T.Type, from data: Data) -> Result<T, Error> where T: Decodable {
        return Result { try self.jsonDecoder.decode(type, from: data) }
    }
    
    open class func encode<T>(_ value: T) -> Result<Data, Error> where T: Encodable {
        return Result { try self.jsonEncoder.encode(value) }
    }
}

