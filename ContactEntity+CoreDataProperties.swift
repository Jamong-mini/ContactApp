// ContactEntity+CoreDataProperties.swift
//
// CoreData Entity 속성을 관리
// 작성자: Jamong
// 작성일: 2024-12-12

import Foundation
import CoreData

// MARK: - Properties
extension ContactEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactEntity> {
        return NSFetchRequest<ContactEntity>(entityName: "ContactEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var imageUrl: String?

}

// MARK: - Identifiable
extension ContactEntity : Identifiable {

}
