// AddContactViewController.swift
//
// 추가 연락처 화면 컨트롤러를 관리
// 작성자: Jamong
// 작성일: 2024-12-10

import UIKit
import SnapKit
import SwiftUI

protocol AddContactDelegate: AnyObject {
    func didAddContact(_ contact: ContactModel)
}

// MARK: - AddContactViewController
/// 연락처 추가 화면을 표시
class AddContactViewController: UIViewController, UITextFieldDelegate {
    // AddContactView Components 가져오기
    private let addContactView = AddContactView()
    weak var delegate: AddContactDelegate?
    private var randomImageUrl: String?
    
    override func loadView() {
        self.view = addContactView
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupActions()
        
        // TextField delegate 설정
        addContactView.phoneNumberTextField.delegate = self
    }
    
    // MARK: - UI Setup
    private func setupNavigationBar() {
        title = "연락처 추가"
        let addButton = UIBarButtonItem(
            title: "적용",
            style: .plain,
            target: self,
            action: #selector(didTapAppendButton)
        )
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(confirmAction)
        present(alertController, animated: false)
    }
    
    private func isStringName(_ name: String) -> Bool {
        // 정규식을 사용해 이름에 문자만 포함되었는지 확인
        let nameRegex = "^[a-zA-Z가-힣]+$" // 영문 또는 한글만 허용
        let predicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return predicate.evaluate(with: name)
    }
    
    private func isIntPhoneNumber(_ phoneNumber: String) -> Bool {
        // 정규식을 사용해 전화번호에 숫자만 포함되었는지 확인
        let phoneRegex = "^[0-9]+$" // 숫자만 허용
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: phoneNumber)
    }
    
    private func setupActions() {
        addContactView.randomImageButton.addTarget(self, action: #selector(didTapRandomImageButton), for: .touchUpInside)
    }
    
    // 이미지 불러오기(API 데이터 호출)
    @objc private func didTapRandomImageButton() {
        let randomId = Int.random(in: 1...1025)
        let urlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(randomId).png"
        guard let url = URL(string: urlString) else {
            print("URL 생성 실패")
            return
        }

        // URL에서 이미지 다운로드
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("이미지 다운로드 실패: \(error?.localizedDescription ?? "알 수 없는 오류")")
                return
            }

            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.addContactView.profileImageView.image = image
                    self.randomImageUrl = urlString // 이미지 URL 저장
                }
            }
        }.resume()
    }
    
    private func formatPhoneNumber(_ phoneNumber: String) -> String {
        // 숫자만 추출
        let numbers = phoneNumber.filter { $0.isNumber }
        
        // 11자리가 아니면 원본 반환
        guard numbers.count == 11 else { return phoneNumber }
        
        // 문자열을 배열로 변환하여 처리
        let numbersArray = Array(numbers)
        
        // 3-4-4 형식으로 포맷팅
        let part1 = numbersArray[0...2].map { String($0) }.joined()
        let part2 = numbersArray[3...6].map { String($0) }.joined()
        let part3 = numbersArray[7...10].map { String($0) }.joined()
        
        return "\(part1)-\(part2)-\(part3)"
    }

    
    @objc private func didTapAppendButton() {
        guard let name = addContactView.nameTextField.text,
              let phoneNumber = addContactView.phoneNumberTextField.text,
              // 비어있을때 예외처리
              !name.isEmpty, !phoneNumber.isEmpty else {
            showAlert(title: "입력 오류", message: "이름과 전화번호를 모두 입력해주세요.")
            return
        }
        
        // 이름 - 문자열
        if !isStringName(name) {
            showAlert(title: "입력 오류", message: "이름에는 문자만 입력할 수 있습니다.")
            return
        }
        
        // 전화번호 - 숫자
        if !isIntPhoneNumber(phoneNumber) {
            showAlert(title: "입력 오류", message: "전화번호에는 숫자만 입력할 수 있습니다.")
            return
        }
        
        let formattedPhoneNumber = formatPhoneNumber(phoneNumber)
        
        let newContact = ContactModel (
            id: UUID(), imageUrl: randomImageUrl, name: name, phoneNumber: formattedPhoneNumber
            )
        
        delegate?.didAddContact(newContact)
        navigationController?.popViewController(animated: true)
    }
}

#Preview {
    AddContactViewController()
}
