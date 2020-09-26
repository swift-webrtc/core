//
//  IntegerExt.swift
//  Core
//
//  Created by sunlubo on 2020/9/13.
//  Copyright © 2020 sunlubo. All rights reserved.
//

extension FixedWidthInteger {
  /// Returns the number of bits used in the binary representation.
  public var bitCount: Int {
    bitWidth - leadingZeroBitCount
  }

  /// Returns the highest byte.
  public var highestByte: UInt8 {
    UInt8(self >> (bitWidth - 8))
  }

  public init<C>(bigEndianBytes bytes: C) where C: Collection, C.Element == UInt8 {
    self.init(littleEndianBytes: bytes.reversed())
  }

  public init<C>(littleEndianBytes bytes: C) where C: Collection, C.Element == UInt8 {
    precondition(bytes.count == (Self.bitWidth + 7) / 8)
    var iter = bytes.makeIterator()
    self.init(littleEndianBytes: &iter)
  }

  internal init<I>(littleEndianBytes iterator: inout I) where I: IteratorProtocol, I.Element == UInt8 {
    self = stride(from: 0, to: Self.bitWidth, by: 8).reduce(into: 0) {
      $0 |= Self(truncatingIfNeeded: iterator.next()!) &<< $1
    }
  }
}
