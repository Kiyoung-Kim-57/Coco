//
//  ModuleBundle.swift
//  CocoDatasource
//
//  Created by 김기영 on 8/24/25.
//
import Foundation

public final class DataSourceBundle {
    public static var bundle: Bundle {
        return Bundle(for: DataSourceBundle.self)
    }
}
