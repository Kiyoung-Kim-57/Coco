//
//  Date+toDate.swift
//  CocoDatasource
//
//  Created by 김기영 on 9/10/25.
//

import Foundation

public extension Date {
    init(milliseconds: TimeInterval) {
        self = Date(timeIntervalSince1970: milliseconds / 1000)
    }
}
