//
//  Hash.swift
//  webrtc-core
//
//  Created by sunlubo on 2020/9/13.
//  Copyright © 2020 sunlubo. All rights reserved.
//

import COpenSSL

public protocol Hash {
  /// Incrementally updates the hash function with the given data.
  mutating func update(_ bytes: Array<UInt8>)
  /// Finalizes the hash function and returns the computed digest.
  mutating func finalize() -> Array<UInt8>
}

// MARK: - MD5

public struct MD5: Hash {
  internal var native: MD5_CTX

  public init() {
    native = MD5_CTX()
    MD5_Init(&native)
  }

  public mutating func update(_ bytes: Array<UInt8>) {
    MD5_Update(&native, bytes, bytes.count)
  }

  public mutating func finalize() -> Array<UInt8> {
    Array(unsafeUninitializedCapacity: Int(MD5_DIGEST_LENGTH)) { buffer, count in
      MD5_Final(buffer.baseAddress, &native)
      count = Int(MD5_DIGEST_LENGTH)
    }
  }
}

// MARK: - SHA1

public struct SHA1: Hash {
  private var native: SHA_CTX

  public init() {
    native = SHA_CTX()
    SHA1_Init(&native)
  }

  public mutating func update(_ bytes: Array<UInt8>) {
    SHA1_Update(&native, bytes, bytes.count)
  }

  public mutating func finalize() -> Array<UInt8> {
    Array(unsafeUninitializedCapacity: Int(SHA_DIGEST_LENGTH)) { buffer, count in
      SHA1_Final(buffer.baseAddress, &native)
      count = Int(SHA_DIGEST_LENGTH)
    }
  }
}

// MARK: - Array

extension Array where Element == UInt8 {
  public var md5: Array<UInt8> {
    var hash = MD5()
    hash.update(self)
    return hash.finalize()
  }

  public var sha1: Array<UInt8> {
    var hash = SHA1()
    hash.update(self)
    return hash.finalize()
  }
}

// MARK: - String

extension String {
  public var md5: Array<UInt8> {
    var hash = MD5()
    hash.update(bytes)
    return hash.finalize()
  }

  public var sha1: Array<UInt8> {
    var hash = SHA1()
    hash.update(bytes)
    return hash.finalize()
  }
}
