//
//  ByteWriter.swift
//  Core
//
//  Created by sunlubo on 2020/9/5.
//  Copyright © 2020 sunlubo. All rights reserved.
//

public struct ByteWriter {
  internal var buffer: Array<UInt8>

  public var count: Int {
    buffer.count
  }

  public init() {
    self.buffer = []
  }

  public init(capacity: Int) {
    self.buffer = []
    self.buffer.reserveCapacity(capacity)
  }

  public init<S>(bytes: S) where S: Sequence, S.Element == UInt8 {
    self.buffer = Array(bytes)
  }

  /// Writes a new integer at the end of the buffer.
  ///
  /// - Parameters:
  ///   - integer: The integer to write to the buffer.
  ///   - endianness: The endianness to use, defaults to big endian.
  public mutating func writeInteger<T>(_ integer: T, endianness: Endianness = Endianness.big, as: T.Type = T.self) where T: FixedWidthInteger {
    var value = endianness.convert(integer)
    Swift.withUnsafeBytes(of: &value) {
      buffer.append(contentsOf: $0)
    }
  }

  public mutating func writeInteger<T>(_ integer: T, at index: Int, endianness: Endianness = Endianness.big, as: T.Type = T.self) where T: FixedWidthInteger {
    var value = endianness.convert(integer)
    Swift.withUnsafeBytes(of: &value) {
      buffer.replaceSubrange(index ..< (index + MemoryLayout<T>.size), with: $0)
    }
  }

  /// Writes a new string at the end of the buffer.
  ///
  /// - Parameter string: The string to write to the buffer.
  public mutating func writeString(_ string: String) {
    var string = string
    string.withUTF8 {
      buffer.append(contentsOf: $0)
    }
  }

  /// Writes the bytes to the end of the buffer.
  ///
  /// - Parameter bytes: The bytes to write to the buffer.
  public mutating func writeBytes<S>(_ bytes: S) where S: Sequence, S.Element == UInt8 {
    buffer.append(contentsOf: bytes)
  }

  public func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R {
    try buffer.withUnsafeBytes(body)
  }
}

extension ByteWriter {

  public mutating func removeLast(_ k: Int) {
    buffer.removeLast(k)
  }
}
