//
//  StringExt.swift
//  webrtc-core
//
//  Created by sunlubo on 2020/9/13.
//  Copyright © 2020 sunlubo. All rights reserved.
//

extension String {
  public var bytes: Array<UInt8> {
    var string = self
    return string.withUTF8(Array.init)
  }
}
