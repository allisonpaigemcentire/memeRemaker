//
//  GeneratedMeme.swift
//  memeRemaker
//
//  Created by Allison Mcentire on 9/18/22.
//

import Foundation
import UIKit

struct MemeName: Codable, Identifiable, Hashable {
    var id: UUID
    var name: String
    
    init(name: String) {
        self.name = name
        self.id = UUID()
    }
}

struct GeneratedMeme {
    let memeImage: UIImage
    let memeText: String
    let timeStamp: Date
}

struct InfoData: Codable {
 let name: String
}

struct InfoResponse: Codable {
  let request: InfoData
}
