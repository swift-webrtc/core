//
//  ByteReader.swift
//  webrtc-core
//
//  Created by sunlubo on 2020/9/5.
//  Copyright © 2020 sunlubo. All rights reserved.
//

public struct ByteReader {
  internal var buffer: Array<UInt8>
  internal var index: Array<UInt8>.Index

  public var count: Int {
    buffer.endIndex - index
  }

  public init<S>(_ bytes: S) where S: Sequence, S.Element == UInt8 {
    self.buffer = Array(bytes)
    self.index = buffer.startIndex
  }

  public init(writer: ByteWriter) {
    self.buffer = writer.buffer
    self.index = buffer.startIndex
  }

  public mutating func readInteger<T>(endianness: Endianness = Endianness.big, as: T.Type = T.self) -> T? where T: FixedWidthInteger {
    let size = MemoryLayout<T>.size
    guard index.advanced(by: size) <= buffer.endIndex else {
      return nil
    }

    defer {
      index += MemoryLayout<T>.size
    }
    var value: T = 0
    withUnsafeMutableBytes(of: &value) {
      $0.copyBytes(from: buffer[index..<index.advanced(by: size)])
    }
    return endianness.convert(value)
  }

  public mutating func readString(count: Int) -> String? {
    guard index.advanced(by: count) <= buffer.endIndex else {
      return nil
    }

    defer {
      index += count
    }
    return String(decoding: buffer[index..<index.advanced(by: count)], as: Unicode.UTF8.self)
  }

  public mutating func readBytes(count: Int) -> Array<UInt8>? {
    guard index.advanced(by: count) <= buffer.endIndex else {
      return nil
    }

    defer {
      index += count
    }
    return Array(buffer[index..<index.advanced(by: count)])
  }
}

extension ByteReader {

  public mutating func consume(_ k: Int) {
    index += k
  }
}
