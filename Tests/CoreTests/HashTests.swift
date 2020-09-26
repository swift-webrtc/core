//
//  HashTests.swift
//  CoreTests
//
//  Created by sunlubo on 2020/9/13.
//  Copyright © 2020 sunlubo. All rights reserved.
//

@testable
import Core
import XCTest

final class HashTests: XCTestCase {

  func testMD5() {
    XCTAssertEqual("0123456789".md5.hex, "781e5e245d69b566979b86e28d23f2c7")
  }

  func testSHA1() {
    XCTAssertEqual("0123456789".sha1.hex, "87acec17cd9dcd20a716cc2cf67417b71c8a7016")
  }

  static var allTests = [
    ("testMD5", testMD5),
    ("testSHA1", testSHA1),
  ]
}
