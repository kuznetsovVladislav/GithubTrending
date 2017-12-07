//
//  ProfileViewController.swift
//  GithubTrends
//
//  Created by Владислав  on 12/7/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

fileprivate enum Constant {
    static let navigationTitle: String = "Vlad Kuznetsov"
}

final class ProfileViewController: BaseViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Variables
    
    var sections: [ProfileSection] = [
        ProfileSection(section: .header, rows: [.header]),
        ProfileSection(section: .settings, rows: [.colorTheme, .saveToStore]),
        ProfileSection(section: .logout, rows: [.logout])
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupTableVew()
    }
    
    private func setupController() {
        navigationItem.title = Constant.navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

    private func setupTableVew() {
        tableView.registerNib(for: ProfileHeaderTVCell.self)
        tableView.registerNib(for: ProfileSwitchTVCell.self)
        tableView.registerNib(for: LabelTVCell.self)
    }

}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var resultCell: UITableViewCell
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .header:
            let cell = tableView.dequeueReusableCell(cellClass: ProfileHeaderTVCell.self, for: indexPath)
            resultCell = cell
        case .colorTheme:
            let cell = tableView.dequeueReusableCell(cellClass: ProfileSwitchTVCell.self, for: indexPath)
            cell.keyLabel.text = row.title
            resultCell = cell
        case .saveToStore:
            let cell = tableView.dequeueReusableCell(cellClass: ProfileSwitchTVCell.self, for: indexPath)
            cell.keyLabel.text = row.title
            resultCell = cell
        case .logout:
            let cell = tableView.dequeueReusableCell(cellClass: LabelTVCell.self, for: indexPath)
            cell.titleLabel.text = row.title
            resultCell = cell
        }
        return resultCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsCount = sections[section].rows.count
        return rowsCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].rows[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        return section.height
    }
}
