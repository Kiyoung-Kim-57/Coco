//
//  CocoCoreDataDataSource.swift
//  CocoDatasource
//
//  Created by 김기영 on 6/30/25.
//

import Foundation
import CoreData

// 아직 필요 데이터 모델이나 스키마가 정해져 있지 않아 추후 개발 예정
//final class CocoCoreDataDataSource: CocoDataSourceProtocol {
//    
//    public typealias Item = [NSManagedObject]
//    public typealias Condition = NSPredicate
//    
//    private let persistentContainer: NSPersistentContainer
//    private let context: NSManagedObjectContext
//    
//    init(persistentContainer: NSPersistentContainer) {
//        self.persistentContainer = persistentContainer
//        self.context = persistentContainer.viewContext
//    }
//    
//    /// RequestHandler는 엔티티 이름과 조건을 설정할 수 있게 합니다
//    func readData(requestHandler: (NSPredicate) -> NSPredicate) async throws -> [NSManagedObject] {
//        return []
//    }
//    
//    func writeData(_ item: [NSManagedObject], requestHandler: (NSPredicate) -> NSPredicate) async throws -> Bool {
//        return true
//    }
//    
//    func deleteData(requestHandler: (NSPredicate) -> NSPredicate) async throws -> Bool {
//        return true
//    }
//}
