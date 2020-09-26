//
//  Checksum.swift
//  webrtc-core
//
//  Created by sunlubo on 2020/9/13.
//  Copyright © 2020 sunlubo. All rights reserved.
//

public protocol Checksum {
  /// The current checksum value.
  var value: UInt32 { get }
  /// Updates the current checksum with the given bytes.
  mutating func update(_ bytes: Array<UInt8>)
}

extension Checksum {

  public mutating func update(_ message: String) {
    update(message.bytes)
  }
}

// MARK: - CRC32

/// This implementation is based on the sample implementation in RFC 1952.
public struct CRC32: Checksum {
  /// CRC32 polynomial, in reversed form.
  /// See RFC 1952, or http://en.wikipedia.org/wiki/Cyclic_redundancy_check
  static let polynomial: UInt32 = 0xEDB88320
  static let table: Array<UInt32> = {
    Array<UInt32>(unsafeUninitializedCapacity: 256) { buffer, count in
      for i in 0 ..< buffer.count {
        var c = UInt32(i)
        for j in 0 ..< 8 {
          if c & 1 != 0 {
            c = polynomial ^ (c >> 1)
          } else {
            c >>= 1
          }
        }
        buffer[i] = c
      }
      count = 256
    }
  }()

  public var value: UInt32 = 0

  public mutating func update(_ bytes: Array<UInt8>) {
    var c = value ^ 0xFFFFFFFF
    for i in 0 ..< bytes.count {
      c = CRC32.table[Int((c ^ UInt32(bytes[i])) & 0xFF)] ^ (c >> 8)
    }
    value = c ^ 0xFFFFFFFF
  }
}

// MARK: - Array

extension Array where Element == UInt8 {
  public var crc32: UInt32 {
    var checksum = CRC32()
    checksum.update(self)
    return checksum.value
  }
}

// MARK: - String

extension String {
  public var crc32: UInt32 {
    var checksum = CRC32()
    checksum.update(bytes)
    return checksum.value
  }
}
