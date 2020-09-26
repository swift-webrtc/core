//
//  Endianness.swift
//  Core
//
//  Created by sunlubo on 2020/9/11.
//  Copyright © 2020 sunlubo. All rights reserved.
//

public enum Endianness {
  case big
  case little

  public static let host: Endianness = {
    let number = UInt32(0x12345678)
    return number == number.bigEndian ? .big : .little
  }()

  public func convert<T>(_ value: T) -> T where T: FixedWidthInteger {
    switch self {
    case .little:
      return value.littleEndian
    case .big:
      return value.bigEndian
    }
  }
}
