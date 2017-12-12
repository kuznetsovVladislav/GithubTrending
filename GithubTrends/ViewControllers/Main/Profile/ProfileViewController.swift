//
//  ProfileViewController.swift
//  GithubTrends
//
//  Created by Владислав  on 12/7/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import AlamofireImage

fileprivate enum Constant {
    static let navigationTitle: String = "Vlad Kuznetsov"
}

final class ProfileViewController: BaseViewController, ViewModelContainerProtocol {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!

    private let name: MutableProperty<String?> = .init(nil)
    private let login: MutableProperty<String?> = .init(nil)
    private let email: MutableProperty<String?>  = .init(nil)
    private let bio: MutableProperty<String?>  = .init(nil)
    private let avatar: MutableProperty<URL?>  = .init(nil)
    private var isDarkSideChosen: Property<Bool> = .init(value: false)
    
    // MARK: - Variables
    
    var sections: [ProfileSection] = [
        ProfileSection(type: .header, rows: [.header]),
        ProfileSection(type: .settings, rows: [.colorTheme, .saveToStore]),
        ProfileSection(type: .logout, rows: [.logout])
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupTableVew()
    }
    
    // MARK: - Setup & Binding
    
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
    
    func didSet(_ viewModel: ProfileViewModel, for lifetime: Lifetime) {
        // Collecting View input
        tableView.layoutIfNeeded()
        let sectionTypes = sections.map {$0.type}
        guard
            let settingsSectionIndex = sectionTypes.index(of: .settings),
            let logoutSectionIndex = sectionTypes.index(of: .logout),
            let colorThemeRowIndex = sections[settingsSectionIndex].rows.index(of: .colorTheme),
            let saveSearchRowIndex = sections[settingsSectionIndex].rows.index(of: .saveToStore),
            let logoutRowIndex = sections[logoutSectionIndex].rows.index(of: .logout),
            let colorSchemeCell = tableView.cellForRow(at: IndexPath(row: colorThemeRowIndex, section: settingsSectionIndex)) as? ProfileSwitchTVCell,
            let saveSearchCell = tableView.cellForRow(at: IndexPath(row: saveSearchRowIndex, section: settingsSectionIndex)) as? ProfileSwitchTVCell else {
                return
        }
        
        let logoutPressed = reactive.rowSelection.filter {$0 == IndexPath(row: logoutRowIndex, section: logoutSectionIndex)}.mapToVoid()
        
        let input = ProfileViewModel.Input(
            joinDarkSideSwitchChanged: colorSchemeCell.valueSwitch.reactive.isOnValues.take(during: lifetime),
            saveSearchResultsSwitchChanged: saveSearchCell.valueSwitch.reactive.isOnValues.take(during: lifetime),
            logoutButtonPressed: logoutPressed.take(during: lifetime)
        )
        
        // Binding ViewModel output
        let output = viewModel.transform(input)
        name <~ output.name
        login <~ output.login
        email <~ output.email
        bio <~ output.bio
        avatar <~ output.avatar
        isDarkSideChosen = output.isDarkSideChosed
        tableView.reactive.reloadData <~ output.shouldReloadInterface
        showError <~ output.error
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
//            cell.nameLabel.text = name.value ?? "User Name"
//            cell.loginLabel.text = login.value ?? "Login"
//            cell.emailLabel.text = email.value ?? "E-mail"
//            cell.bioLabel.text = bio.value ?? "Biography"
            let placeholder = #imageLiteral(resourceName: "git-logo-black")
            cell.avatarImageView.image = placeholder
            if let url = avatar.value {
            	cell.avatarImageView.af_setImage(
                    withURL: url,
                    placeholderImage: placeholder,
                    imageTransition: .crossDissolve(0.3)
                )
            }
            resultCell = cell
        case .colorTheme:
            let cell = tableView.dequeueReusableCell(cellClass: ProfileSwitchTVCell.self, for: indexPath)
            cell.keyLabel.text = row.title
            cell.valueSwitch.isOn = isDarkSideChosen.value
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
        let section = sections[section].type
        return section.height
    }
}
