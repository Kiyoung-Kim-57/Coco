//
//  AutoRegisterable.swift
//  Coco
//
//  Created by 김기영 on 7/3/25.
//

protocol AutoRegisterable {
    static var typeKey: Any.Type { get }
    static func createInstance() -> Any
}
