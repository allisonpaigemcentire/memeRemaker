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

extension AsyncSequence {
  func forEach(_ body: (Element) async throws -> Void) async throws {
    for try await element in self {
      try await body(element)
    }
  }
}

extension String: LocalizedError {
  public var errorDescription: String? {
    return self
  }
}

extension URLSession {

    func uploadTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {
        uploadTask(with: request, from: request.httpBody, completionHandler: completionHandler)
    }
}
