//
//  LineWriter.swift
//  webrtc-core
//
//  Created by sunlubo on 2020/9/26.
//  Copyright © 2020 sunlubo. All rights reserved.
//

public struct LineWriter {
  public var buffer: String

  public init() {
    buffer = ""
  }

  public mutating func write(_ string: String) {
    buffer.append(string)
    buffer.append("\n")
  }
}
