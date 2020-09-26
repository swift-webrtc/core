//
//  ByteReadWriteTests.swift
//  webrtc-core
//
//  Created by sunlubo on 2020/9/5.
//  Copyright © 2020 sunlubo. All rights reserved.
//

@testable
import Core
import XCTest

final class ByteReadWriteTests: XCTestCase {

  func testReadWrite() {
    var writer = ByteWriter()
    writer.writeInteger(8, as: UInt8.self)
    writer.writeInteger(16, as: UInt16.self)
    writer.writeInteger(32, as: UInt32.self)
    writer.writeInteger(64, as: UInt64.self)
    writer.writeInteger(-8, as: Int8.self)
    writer.writeInteger(-16, as: Int16.self)
    writer.writeInteger(-32, as: Int32.self)
    writer.writeInteger(-64, as: Int64.self)
    writer.writeString("hello")
    writer.writeString("world")
    writer.writeBytes([0x00, 0x01, 0x02, 0x03, 0x04, 0x05])

    var reader = ByteReader(writer: writer)
    XCTAssertEqual(reader.readInteger(as: UInt8.self), 8)
    XCTAssertEqual(reader.readInteger(as: UInt16.self), 16)
    XCTAssertEqual(reader.readInteger(as: UInt32.self), 32)
    XCTAssertEqual(reader.readInteger(as: UInt64.self), 64)
    XCTAssertEqual(reader.readInteger(as: Int8.self), -8)
    XCTAssertEqual(reader.readInteger(as: Int16.self), -16)
    XCTAssertEqual(reader.readInteger(as: Int32.self), -32)
    XCTAssertEqual(reader.readInteger(as: Int64.self), -64)
    XCTAssertEqual(reader.readString(count: 5), "hello")
    XCTAssertEqual(reader.readString(count: 5), "world")
    XCTAssertEqual(reader.readBytes(count: 6), [0x00, 0x01, 0x02, 0x03, 0x04, 0x05])
  }

  static var allTests = [
    ("testReadWrite", testReadWrite)
  ]
}
