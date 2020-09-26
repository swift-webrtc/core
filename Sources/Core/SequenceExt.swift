//
//  SequenceExt.swift
//  webrtc-core
//
//  Created by sunlubo on 2020/9/15.
//  Copyright © 2020 sunlubo. All rights reserved.
//

extension Sequence where Element == UInt8 {
  public var hex: String {
    reduce("") {
      let hex = String($1, radix: 16)
      return $0 + (hex.count == 2 ? hex : "0\(hex)")
    }
  }
}
