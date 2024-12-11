// PokemonResponse.swift
//
// 포켓몬스터 API 응답 데이터 구조를 관리
// 작성자: Jamong
// 작성일: 2024-12-11

import Foundation

// MARK: - PokemonResponse
/// 포켓몬 API 응답 데이터 모델
struct PokemonResponse: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let front: PokemonFront
}

// MARK: - PokemonFront
/// 포켓몬 이미지 URL 데이터 모델
struct PokemonFront: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
