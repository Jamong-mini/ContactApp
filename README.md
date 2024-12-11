# 포켓몬 연락처 앱 (Pokemon Contact App)

## 프로젝트 소개
포켓몬 API를 활용하여 랜덤 포켓몬 이미지를 프로필 사진으로 사용할 수 있는 연락처 앱입니다. 
CoreData를 사용하여 데이터를 저장하며, MVC 패턴을 적용하여 개발되었습니다.

## ⚒️ 개발 환경
* UIKit
* CoreData

## 📌 주요 기능
1. **연락처 목록 화면**
   * 저장된 연락처 목록을 테이블 뷰로 표시
   * 이름순으로 자동 정렬
   * 각 연락처의 포켓몬 프로필 이미지, 이름, 전화번호 표시
2. **연락처 추가 화면** 
   * 랜덤 포켓몬 이미지 생성 기능
   * 이름 및 전화번호 입력
   * 입력값 유효성 검사 (이름, 전화번호)
   * 전화번호 자동 포맷팅 (000-0000-0000)
3. **데이터 저장**
   * CoreData를 사용한 데이터 저장
   * 앱 재실행 시에도 데이터 유지

## 🗂️ 프로젝트 구조

```
ContactApp/
├── Models/
│   ├── ContactModel.swift (연락처 데이터 모델)
│   └── PokemonResponse.swift (포켓몬 API 응답 모델)
├── Views/
│   ├── ContactItemCell.swift (연락처 셀 뷰)  
│   └── AddContactView.swift (연락처 추가 화면 뷰)
├── Controllers/
│   ├── ContactListViewController.swift (메인 화면 컨트롤러)
│   └── AddContactViewController.swift (추가 화면 컨트롤러)
└── Managers/
    └── CoreDataManager.swift (데이터 저장 관리)
```

## 🛠️ 사용된 기술
* **UIKit**: 사용자 인터페이스 구현
* **CoreData**: 데이터 영구 저장
* **URLSession**: 네트워크 통신
* **SnapKit**: Auto Layout 구현 
* **SwiftUI Preview**: UI 미리보기


## ✨ 핵심 구현사항
1. **MVC 패턴 적용**
   * Model: 연락처 데이터 구조 및 비즈니스 로직
   * View: UI 컴포넌트 및 레이아웃
   * Controller: 데이터와 뷰 간의 상호작용 관리
2. **데이터 저장**
   * CoreData를 사용한 CRUD 구현
   * 앱 재실행 시에도 데이터 유지  
3. **포켓몬 API 연동**
   * 랜덤 포켓몬 이미지 생성
   * 이미지 로딩
4. **입력값 검증**
   * 이름: 한글과 영문만 허용
   * 전화번호: 숫자만 허용하며 자동 포맷팅


## 🤔 트러블 슈팅
1. **CoreData Entity 충돌 문제** 
   * 문제: Entity 타입 모호성으로 인한 빌드 에러 발생
   * 해결: Entity 이름을 ContactEntity로 변경하여 명확성 확보
2. **전화번호 포맷팅**
   * 문제: 사용자 입력 시 다양한 형식의 전화번호 처리 필요
   * 해결: 정규식과 문자열 처리를 통한 자동 포맷팅 구현


