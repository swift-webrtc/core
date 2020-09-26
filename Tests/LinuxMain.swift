//
//  LinuxMain.swift
//  webrtc-core
//
//  Created by sunlubo on 2020/9/5.
//  Copyright © 2020 sunlubo. All rights reserved.
//

import CoreTests
import XCTest

var tests = [XCTestCaseEntry]()
tests += ByteReadWriteTests.allTests
tests += ChecksumTests.allTests
tests += HMACTests.allTests
tests += HashTests.allTests
tests += DurationTests.allTests
XCTMain(tests)
