// CoreDataManager.swift
//
// CoreData를 통한 데이터 영구 저장을 관리
// 작성자: Jamong
// 작성일: 2024-12-12

import CoreData

// MARK: - CoreDataManager
/// CoreData를 사용한 데이터 저장 및 불러오기를 관리
class CoreDataManager {
    // MARK: - Properties
    static let shared = CoreDataManager()
    private let persistentContainer: NSPersistentContainer
    
    // MARK: - Initialization
    private init() {
        persistentContainer = NSPersistentContainer(name: "ContactApp")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData 로드 실패: \(error)")
            }
        }
    }
    
    // MARK: - Methods
    /// 새 연락처 저장
    func saveContact(id: UUID = UUID(), name: String, phoneNumber: String, imageUrl: String?) {
        let context = persistentContainer.viewContext
        let entity = ContactEntity(context: context)
        
        entity.id = id
        entity.name = name
        entity.phoneNumber = phoneNumber
        entity.imageUrl = imageUrl
        
        do {
            try context.save()
        } catch {
            print("저장 실패: \(error)")
        }
    }
    
    /// 모든 연락처 불러오기
    func fetchContacts() -> [ContactModel] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()
        
        do {
            let entities = try context.fetch(fetchRequest)
            return entities.map { entity in
                ContactModel(
                    id: entity.id ?? UUID(),
                    imageUrl: entity.imageUrl,
                    name: entity.name ?? "",
                    phoneNumber: entity.phoneNumber ?? ""
                )
            }
        } catch {
            print("불러오기 실패: \(error)")
            return []
        }
    }
}
