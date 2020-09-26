//
//  LineWriterTests.swift
//  webrtc-core
//
//  Created by sunlubo on 2020/9/26.
//  Copyright © 2020 sunlubo. All rights reserved.
//

@testable
import Core
import XCTest

final class LineWriterTests: XCTestCase {

  func testWrite() {
    var writer = LineWriter()
    writer.write("hello")
    writer.write("world")
    XCTAssertEqual(writer.buffer, "hello\nworld\n")
  }

  static var allTests = [
    ("testWrite", testWrite)
  ]
}
