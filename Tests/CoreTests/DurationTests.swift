//
//  DurationTests.swift
//  webrtc-core
//
//  Created by sunlubo on 2020/9/24.
//  Copyright © 2020 sunlubo. All rights reserved.
//

@testable
import Core
import XCTest

final class DurationTests: XCTestCase {

  func testConversion() {
    XCTAssertEqual(Duration.hours(8).hours, 8)
    XCTAssertEqual(Duration.hours(8).minutes, 480)
    XCTAssertEqual(Duration.hours(8).seconds, 28_800)
    XCTAssertEqual(Duration.hours(8).milliseconds, 28_800_000)
    XCTAssertEqual(Duration.hours(8).microseconds, 28_800_000_000)
    XCTAssertEqual(Duration.hours(8).nanoseconds, 28_800_000_000_000)
  }

  func testTimeval() {
    let duration = Duration.seconds(8) + Duration.microseconds(8)
    XCTAssertEqual(duration.ctimeval.tv_sec, 8)
    XCTAssertEqual(duration.ctimeval.tv_usec, 8_000_008)
  }

  static var allTests = [
    ("testConversion", testConversion),
    ("testTimeval", testTimeval)
  ]
}
