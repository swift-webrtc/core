//
//  Duration.swift
//  webrtc-core
//
//  Created by sunlubo on 2020/9/18.
//  Copyright © 2020 sunlubo. All rights reserved.
//

#if canImport(Darwin)
import Darwin.C
#else
import Glibc
#endif

public struct Duration: Equatable {

  public static func hours(_ value: Int) -> Duration {
    .minutes(value * 60)
  }

  public static func minutes(_ value: Int) -> Duration {
    .seconds(value * 60)
  }

  public static func seconds(_ value: Int) -> Duration {
    .milliseconds(value * 1000)
  }

  public static func milliseconds(_ value: Int) -> Duration {
    .microseconds(value * 1000)
  }

  public static func microseconds(_ value: Int) -> Duration {
    .nanoseconds(value * 1000)
  }

  public static func nanoseconds(_ value: Int) -> Duration {
    Duration(nanoseconds: value)
  }

  public var hours: Int { minutes / 60 }
  public var minutes: Int { seconds / 60 }
  public var seconds: Int { milliseconds / 1000 }
  public var milliseconds: Int { microseconds / 1000 }
  public var microseconds: Int { nanoseconds / 1000 }
  public var nanoseconds: Int

  public init(nanoseconds: Int) {
    self.nanoseconds = nanoseconds
  }
}

// MARK: - timeval

extension Duration {
  public var ctimeval: timeval {
    timeval(tv_sec: seconds, tv_usec: __darwin_suseconds_t(microseconds))
  }

  public init(_ ctimeval: timeval) {
    self.nanoseconds = ctimeval.tv_sec * 1_000_000 + Int(ctimeval.tv_usec)
  }
}

extension Duration {

  public static func + (lhs: Duration, rhs: Duration) -> Duration {
    Duration(nanoseconds: lhs.nanoseconds + rhs.nanoseconds)
  }
}
