// ContactListViewController.swift
//
// 메인 연락처 화면 컨트롤러를 관리
// 작성자: Jamong
// 작성일: 2024-12-10

import UIKit
import SnapKit
import SwiftUI

// MARK: - ContactViewController
/// 연락처 메인 화면을 표시
class ContactListViewController: UIViewController {
    // MARK: - Properties
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(ContactItemCell.self, forCellReuseIdentifier: ContactItemCell.identifier)
        table.rowHeight = 80
        return table
    }()
    
    // 데이터
    private var contacts: [ContactModel] = [
    ]

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupConstraints()
        
        // 테이블뷰의 데이터 소스, 델리게이트 설정
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         loadContacts()
     }
    
    // MARK: - UI Setup
    private func setupNavigationBar() {
        title = "친구 목록"
        
        let addButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addButtonTabpped)
        )
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func addButtonTabpped() {
        let addVC = AddContactViewController()
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: false)
    }
}

// MARK: - UITableViewDataSource
extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    /// 테이블뷰의 행 개수를 반환하는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    /// 각 행의 셀을 구성하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactItemCell.identifier, for: indexPath) as? ContactItemCell else {
            return UITableViewCell()
        }
        
        // 데이터 설정
        let contact = contacts[indexPath.row]
        cell.configure(with: contact)
        return cell
    }

    /// 셀이 선택되었을 때 호출되는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("\(contacts[indexPath.row].name) 선택됨")
    }
    
    private func loadContacts() {
        contacts = CoreDataManager.shared.fetchContacts()
        contacts.sort { $0.name < $1.name }
        tableView.reloadData()
    }
}

extension ContactListViewController: AddContactDelegate {
    func didAddContact(_ contact: ContactModel) {
        // CoreData에 저장
        CoreDataManager.shared.saveContact(
            id: contact.id,
            name: contact.name,
            phoneNumber: contact.phoneNumber,
            imageUrl: contact.imageUrl
        )
        // 데이터 다시 로드
        loadContacts()
    }
}

#Preview {
    ContactListViewController()
}
