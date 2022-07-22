//
//  URLRequest+Extension.swift
//  iOSSwiftMarvel
//
//  Created by Jonashio on 21/7/22.
//

import Foundation
import CryptoKit

extension URLRequest {

    static var URL_BASE: String = "https://gateway.marvel.com:443/"
    
    static func buildRequest(method: String, methodType: MethodType, params: Params? = [:]) -> URLRequest? {
        guard var url = URL(string: URL_BASE + method) else {
            return nil
        }

        if var urlComponents = URLComponents(string: URL_BASE + method), methodType == .GET {
            let apyKey = URLRequest.generateAPIKey()
            urlComponents.queryItems = []
            urlComponents.queryItems = params?.map { key, value in
                return URLQueryItem(name: key, value: value)
            }
            
            urlComponents.queryItems?.append(URLQueryItem(name: "ts", value: apyKey.ts))
            urlComponents.queryItems?.append(URLQueryItem(name: "apikey", value: try? KeychainHelper.getValue(type: .publicKey)))
            urlComponents.queryItems?.append(URLQueryItem(name: "hash", value: apyKey.apiKey))

            if let urlWithParams = urlComponents.url?.absoluteURL {
                url = urlWithParams
            }
        }

        return URLRequest.buildRequest(url: url, methodType: methodType, params: params ?? [:])
    }

    static func buildRequest(url: URL, methodType: MethodType, params: Params = [:]) -> URLRequest {
        var request = URLRequest(url: url)
        var mutableParams: Params = Params()

        request.httpMethod = methodType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        if methodType != .GET {
            do {
                let apyKey = URLRequest.generateAPIKey()
                
                mutableParams.merge(dict: ["ts": apyKey.ts])
                mutableParams.merge(dict: ["apykey": (try? KeychainHelper.getValue(type: .publicKey)) ?? "" ])
                mutableParams.merge(dict: ["hash": apyKey.apiKey])
                mutableParams.merge(dict: params)
                
                request.httpBody = try JSONSerialization.data(withJSONObject: mutableParams, options: .prettyPrinted)
            } catch {
                print(error.localizedDescription)
            }
        }

        return request
    }
    
    static func generateAPIKey() -> (ts: String, apiKey: String) {
        do {
            let ts = "\(Date().timeIntervalSince1970)".removeLastIfCan(10)
            let privateKey = try KeychainHelper.getValue(type: .privateKey)
            let publicKey = try KeychainHelper.getValue(type: .publicKey)
            
            return (ts, URLRequest.md5Hash(value: "\(ts)\(privateKey)\(publicKey)"))
        } catch {
            print(error.localizedDescription)
            return ("", "")
        }
    }
    
    static func md5Hash(value: String) -> String {
        let digest = Insecure.MD5.hash(data: value.data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
