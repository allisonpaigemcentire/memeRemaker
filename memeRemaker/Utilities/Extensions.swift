//
//  Extensions.swift
//  memeRemaker
//
//  Created by Allison Mcentire on 9/11/22.
//
import Foundation

extension Array {
    func split() -> (left: [Element], right: [Element]) {
        let ct = self.count
        let half = ct / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< ct]
        return (left: Array(leftSplit), right: Array(rightSplit))
    }
}

extension InputStream {
  /// The avalable stream data.
  public var data: Data {
    var data = Data()
    open()

    let maxLength = 1024
    let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxLength)
    while hasBytesAvailable {
      let read = read(buffer, maxLength: maxLength)
      guard read > 0 else { break }
      data.append(buffer, count: read)
    }

    buffer.deallocate()
    close()

    return data
  }
}
