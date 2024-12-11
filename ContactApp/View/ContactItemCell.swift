// ContactCell.swift
//
// 연락처 테이블 셀 컴포넌트를 관리
// 작성자: Jamong
// 작성일: 2024-12-09

import UIKit
import SnapKit
import SwiftUI

// MARK: - ContactItemCell
/// 연락처 아이템을 표시하는 테이블 뷰 셀
/// 연락처 이미지, 이름, 전화번호를 표시
class ContactItemCell: UITableViewCell {
    static let identifier = "ContactItemCell"
    
    // MARK: - UI ContainerView Components
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    /// 정보를 담을 수평 스택뷰
    private let horizontalStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = 16
        stackview.distribution = .equalSpacing
        stackview.alignment = .center
        return stackview
    }()
    
    /// 연락처 이미지를 표시하는 이미지 뷰
    private let contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    /// 이름 레이블
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    /// 번호 레이블
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Initalization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    /// UI 컴포넌트들의 레이아웃 설정
    private func setupUI() {
        // 컨테이너 뷰 추가
        contentView.addSubview(containerView)
        
        // 컨테이너 뷰에 스택뷰 집어넣기
        containerView.addSubview(horizontalStackView)
        
        // 스택 뷰에 집어넣기
        [contactImageView, nameLabel, phoneNumberLabel].forEach { horizontalStackView.addArrangedSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
            $0.centerY.equalTo(containerView.snp.centerY)
        }
        
        contactImageView.snp.makeConstraints {
            $0.width.height.equalTo(60)
        }
    }
    
    func configure(with contact: ContactModel) {
        nameLabel.text = contact.name
        phoneNumberLabel.text = contact.phoneNumber
        
        if let imageUrlString = contact.imageUrl,
           let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, error in
                if let error = error {
                    print("이미지 로드 실패: \(error.localizedDescription)")
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.contactImageView.image = image
                    }
                }
            }.resume()
        } else {
            contactImageView.image = UIImage(systemName: "person.circle")
        }
    }
    
}


#Preview {
    ContactItemCell()
}
