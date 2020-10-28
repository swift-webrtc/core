//
//  Logger.swift
//  webrtc-core
//
//  Created by sunlubo on 2020/9/24.
//  Copyright © 2020 sunlubo. All rights reserved.
//

import Logging

public struct LoggerConfiguration {
  public static var `default` = LoggerConfiguration()

  public var logLevel: Logger.Level = .info
}
