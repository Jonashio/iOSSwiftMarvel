import Foundation
import PKHUD
import UIKit

public typealias Response<Value> = ((Result<Value, WrapperError<Error>>) -> Void)
public typealias Params = [String: String]

public enum Result<T, U> {
    case success(T)
    case error(U)
}

public enum WrapperError<U> {
    case invalidToken
    case buildRequestFailure
    case serverFailure(U?)
    case businessFailure
    case parseFailure
    case unknown
    
    static func isBusinessFailure(response: URLResponse?) -> Bool {
        guard let parseResponse = response as? HTTPURLResponse, parseResponse.statusCode != 200 else {
            return false
        }
        return true
    }
}

public enum MethodType: String {
    case GET
    case HEAD
    case POST
    case PUT
    case DELETE
}
