//
//  HMACTests.swift
//  CoreTests
//
//  Created by sunlubo on 2020/9/13.
//  Copyright © 2020 sunlubo. All rights reserved.
//

@testable
import Core
import XCTest

final class HMACTests: XCTestCase {

  func testSha1HMAC() {
    let hmac1 = HMAC(key: Array(repeating: 0x0b, count: 20), hash: .sha1).authenticate("Hi There")
    XCTAssertEqual(hmac1.hex, "b617318655057264e28bc0b6fb378c8ef146be00")

    let hmac2 = HMAC(key: "Jefe", hash: .sha1).authenticate("what do ya want for nothing?")
    XCTAssertEqual(hmac2.hex, "effcdf6ae5eb2fa2d27416d5f184df9c259a7c79")

    let hmac3 = HMAC(key: Array(repeating: 0xaa, count: 20), hash: .sha1).authenticate(Array(repeating: 0xdd, count: 50))
    XCTAssertEqual(hmac3.hex, "125d7342b9ac11cd91a39af48aa17b4f63f175d3")

    let hmac4 = HMAC(
      key: [
        0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
        0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19,
      ],
      hash: .sha1
    ).authenticate(Array(repeating: 0xcd, count: 50))
    XCTAssertEqual(hmac4.hex, "4c9007f4026250c6bc8414f9bf50c86c2d7235da")

    let hmac5 = HMAC(key: Array(repeating: 0x0c, count: 20), hash: .sha1).authenticate("Test With Truncation")
    XCTAssertEqual(hmac5.hex, "4c1a03424b55e07fe7f27be1d58bb9324a9a5a04")

    let hmac6 = HMAC(key: Array(repeating: 0xaa, count: 80), hash: .sha1).authenticate("Test Using Larger Than Block-Size Key - Hash Key First")
    XCTAssertEqual(hmac6.hex, "aa4ae5e15272d00e95705637ce8a3b55ed402112")

    let hmac7 = HMAC(key: Array(repeating: 0xaa, count: 80), hash: .sha1).authenticate("Test Using Larger Than Block-Size Key and Larger Than One Block-Size Data")
    XCTAssertEqual(hmac7.hex, "e8e99d0f45237d786d6bbaa7965c7808bbff1a91")
  }

  static var allTests = [
    ("testSha1HMAC", testSha1HMAC)
  ]
}
