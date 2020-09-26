//
//  OptionalExt.swift
//  webrtc-core
//
//  Created by sunlubo on 2020/9/6.
//  Copyright © 2020 sunlubo. All rights reserved.
//

extension Optional {

  public func unwrap(or error: Error) throws -> Wrapped {
    guard let wrapped = self else {
      throw error
    }
    return wrapped
  }
}
