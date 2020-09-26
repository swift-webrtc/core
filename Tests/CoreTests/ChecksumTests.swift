//
//  ChecksumTests.swift
//  CoreTests
//
//  Created by sunlubo on 2020/9/13.
//  Copyright © 2020 sunlubo. All rights reserved.
//

@testable
import Core
import XCTest

final class ChecksumTests: XCTestCase {

  func testBasic() {
    XCTAssertEqual("".crc32, 0x00)
    XCTAssertEqual("abc".crc32, 0x352441C2)
    XCTAssertEqual("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq".crc32, 0x171A3F5F)
  }

  func testMultipleUpdates() {
    let input = "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"
    var checksum = CRC32()
    for i in 0 ..< input.count {
      checksum.update(String(input[input.index(input.startIndex, offsetBy: i)]))
    }
    XCTAssertEqual(checksum.value, 0x171A3F5F)
  }

  static var allTests = [
    ("testBasic", testBasic),
    ("testMultipleUpdates", testMultipleUpdates),
  ]
}
