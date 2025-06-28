//
//  Item.swift
//  Coco
//
//  Created by 김기영 on 6/28/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
