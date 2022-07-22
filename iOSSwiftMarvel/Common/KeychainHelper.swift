//
//  KeychainHelper.swift
//  iOSSwiftMarvel
//
//  Created by Jonashio on 21/7/22.
//

import Foundation
import Security

enum KeychainError: Error {
    case noToken
    case unexpectedTokenData
    case unhandledError(status: OSStatus)
}

enum KeychainType: String {
    case privateKey
    case publicKey
}

class KeychainHelper {

    private struct Constants {
        static let server = "com.jonashioapps.iOSSwiftMarvel"
    }
    
    static func savePrivateKey(value: String) throws -> Bool {
        return try KeychainHelper.save(type: .privateKey, value: value)
    }
    
    static func savePublicKey(value: String) throws -> Bool {
        return try KeychainHelper.save(type: .publicKey, value: value)
    }
    
    

    static private func save(type: KeychainType, value: String) throws -> Bool {
        // Build query
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: type.rawValue,
                                    kSecAttrServer as String: Constants.server,
                                    kSecValueData as String: value.data(using: String.Encoding.utf8)!]

        // Save
        let status = SecItemAdd(query as CFDictionary, nil)

        // Control Errors
        guard status != errSecDuplicateItem else {
            return try KeychainHelper.update(type: type, value: value)
        }
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }

        return true
    }

    static private func update(type: KeychainType, value: String) throws -> Bool {
        let query = [kSecClass as String: kSecClassInternetPassword,
                     kSecAttrAccount as String: type.rawValue,
                     kSecAttrServer as String: Constants.server] as CFDictionary

        let updateFields = [
            kSecValueData: value.data(using: .utf8)!
        ] as CFDictionary

        let status = SecItemUpdate(query, updateFields)

        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }

        return true
    }

    static func getValue(type: KeychainType) throws -> String {
        // Build query
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: type.rawValue,
            kSecAttrServer as String: Constants.server,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]

        // Finding
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else {
            throw KeychainError.noToken
        }
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }

        // Parse data
        guard
            let existingItem = item as? [String: Any],
            // 2
            let valueData = existingItem[kSecValueData as String] as? Data,
            // 3
            let value = String(data: valueData, encoding: .utf8)
        else {
            // 4
            throw KeychainError.unhandledError(status: status)
        }

        return value
    }

    static func deleteToken() {
        let spec: NSDictionary = [kSecClass: kSecClassInternetPassword]
        SecItemDelete(spec)
    }
}
