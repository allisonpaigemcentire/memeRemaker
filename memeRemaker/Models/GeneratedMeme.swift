//
//  GeneratedMeme.swift
//  memeRemaker
//
//  Created by Allison Mcentire on 9/18/22.
//

import Foundation
import UIKit

struct MemeName: Identifiable, Hashable {
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
