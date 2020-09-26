//
//  Thread.swift
//  webrtc-core
//
//  Created by sunlubo on 2020/9/20.
//  Copyright © 2020 sunlubo. All rights reserved.
//

#if canImport(Darwin)
import Darwin.C
#else
import Glibc
#endif

public final class Thread {
  internal var handler: ()->Void
  internal var tid: pthread_t!

  public init(handler: @escaping ()->Void) {
    self.handler = handler
  }

  public func start() {
    pthread_create(&tid, nil, { arg in
      let thread = Unmanaged<Thread>.fromOpaque((arg as UnsafeMutableRawPointer?)!).takeRetainedValue()
      thread.handler()
      return nil
    }, Unmanaged.passRetained(self).toOpaque())
  }

  public func join() {
    pthread_join(tid, nil)
  }
}
