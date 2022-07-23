//
//  KeychainHelperTestCase.swift
//  iOSSwiftMarvelTests
//
//  Created by Jonashio on 23/7/22.
//
import XCTest
@testable import iOSSwiftMarvel

class KeychainHelperTestCase: XCTestCase {
    
    private let privateKey = "1234asdf"
    private let publicKey = "asdf1234"

    override func setUpWithError() throws {
        _ = try KeychainHelper.savePublicKey(value: publicKey)
        _ = try KeychainHelper.savePrivateKey(value: privateKey)
    }

    override func tearDownWithError() throws {}

    func testSavedPublicKeyCorrectly() throws {
        XCTAssertEqual(try KeychainHelper.getValue(type: .publicKey), publicKey)
    }

    func testSavedPrivateKeyCorrectly() throws {
        XCTAssertEqual(try KeychainHelper.getValue(type: .privateKey), privateKey)
    }

    func testDelete() throws {
        KeychainHelper.delete()
        XCTAssertThrowsError(try KeychainHelper.getValue(type: .publicKey))
        XCTAssertThrowsError(try KeychainHelper.getValue(type: .privateKey))
    }
}
