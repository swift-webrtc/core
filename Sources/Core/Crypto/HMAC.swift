//
//  HMAC.swift
//  Core
//
//  Created by sunlubo on 2020/9/13.
//  Copyright © 2020 sunlubo. All rights reserved.
//

import COpenSSL

public struct HMAC {
  internal var key: Array<UInt8>
  internal var hash: Hash

  public init(key: String, hash: Hash) {
    self.key = key.bytes
    self.hash = hash
  }

  public init(key: Array<UInt8>, hash: Hash) {
    self.key = key
    self.hash = hash
  }

  public func authenticate(_ message: String) -> Array<UInt8> {
    authenticate(message.bytes)
  }

  public func authenticate(_ bytes: Array<UInt8>) -> Array<UInt8> {
    let cipher = hash.cipher
    return key.withUnsafeBytes { k in
      bytes.withUnsafeBufferPointer { d in
        Array<UInt8>(unsafeUninitializedCapacity: Int(EVP_MD_meth_get_result_size(cipher))) {
          buffer, count in var digestLength = UInt32(0)
          COpenSSL.HMAC(
            cipher,
            k.baseAddress, Int32(k.count),
            d.baseAddress, d.count,
            buffer.baseAddress, &digestLength
          )
          count = Int(digestLength)
        }
      }
    }
  }
}

extension HMAC {
  public enum Hash {
    case sha1
    case sha256
    case sha384
    case sha512
    case md5

    internal var cipher: OpaquePointer {
      switch self {
      case .sha1:
        return EVP_sha1()
      case .sha256:
        return EVP_sha256()
      case .sha384:
        return EVP_sha384()
      case .sha512:
        return EVP_sha512()
      case .md5:
        return EVP_md5()
      }
    }
  }
}
