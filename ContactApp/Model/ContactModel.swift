// ContactModel.swift
//
// 연락처 데이터 구조를 정의
// 작성자: Jamong
// 작성일: 2024-12-10

import UIKit

// MARK: - ContactModel
/// 연락처 데이터 모델
struct ContactModel: Codable {
    let id: UUID
    var imageUrl: String?
    var name: String
    var phoneNumber: String
    
    // MARK: - Initalization
    init(id: UUID, imageUrl: String?, name: String, phoneNumber: String) {
        self.id = id
        self.imageUrl = imageUrl
        self.name = name
        self.phoneNumber = phoneNumber
    }
}
