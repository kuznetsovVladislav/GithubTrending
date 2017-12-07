//
//  MainViewController.swift
//  GithubTrends
//
//  Created by Владислав  on 23.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

fileprivate enum Constant {
    static let navigationTitle: String = "Trending"
    static let navigationTitleWhitePopover: String = "Adjust time span"
    static let searchBarPlaceholder: String = "Search by languages"
    static let cellHeight: CGFloat = 170.0
    static let popoverHeight: CGFloat = 180.0
    static let popoverAnimationDuration: TimeInterval = 0.3
}

final class TrendsViewController: BaseViewController/*, ViewModelContainerProtocol*/ {
    
    // MARK: - Types
    
    enum TimeSelection: SelectionControllerItemProtocol {
        case day
        case week
        case month
        case allTime
        
        var content: String {
            switch self {
            case .day:
                return "Day"
            case .week:
                return "Week"
            case .month:
                return "Month"
            case .allTime:
                return "All time"
            }
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    private let cellViewModels: MutableProperty<[TrendingCellViewModel]> = .init([])
    
    private lazy var refreshControl: UIRefreshControl = setupRefreshControl()
    private lazy var selectionView: SelectionView = setupSelectionView()
    let searchController = UISearchController(searchResultsController: nil)
    
    var popoverTopConstraint: NSLayoutConstraint?
    
    var viewModel: TrendingViewModel! {
        didSet {
            reactive.trigger(for: #selector(viewDidLoad)).take(during: reactive.lifetime).observeValues {
                self.didSet(self.viewModel, for: self.reactive.lifetime)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupTableView()
        setupSearchController()
    }

    // MARK: - Setup & Bind
    
    private func setupController() {
        navigationItem.title = Constant.navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(rightItemAction(_:)))
        navigationItem.rightBarButtonItem = rightItem
        
        _ = refreshControl
    }
    
    private func setupTableView() {
        tableView.registerNib(for: TrendingTVCell.self)
        tableView.addInfiniteScroll(handler: { _ in })
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constant.searchBarPlaceholder
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func setupRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        return refreshControl
    }
    
    private func setupSelectionView() -> SelectionView {
        let view = SelectionView.instantiateFromNib()
        let content: [TimeSelection] = [.day, .week, .month, .allTime]
        view.configure(with: content)
        view.alpha = 0.0
        
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false        
        popoverTopConstraint =  view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -Constant.popoverHeight)
        popoverTopConstraint?.isActive = true
        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: Constant.popoverHeight).isActive = true
        
        return view
    }
    
    func didSet(_ viewModel: TrendingViewModel, for lifetime: Lifetime) {
        // Collecting view input
        let rowSelection = reactive.rowSelection.map {$0.row}.take(during: lifetime)
        let willDisplayNeededRow = self.willDisplayNeededRow(beforeLast: 3).take(during: lifetime)
        let searchBarInput = searchController.searchBar.reactive.continuousTextValues.skipNil().take(during: lifetime)
        
        let input = TrendingViewModel.Input(
            rowSelection: rowSelection,
            willDisplayRowForPagination: willDisplayNeededRow,
            searchBarInput: searchBarInput)
        
        // Binding viewModel output
        let output = viewModel.transform(input)
        activityIndicator.reactive.isHidden <~ output.isExecuting.negate()
        reactive.shouldShowNetworkActivity <~ output.isExecuting
        tableView.reactive.reloadData <~ output.requestCompleted
		cellViewModels <~ output.cellViewModels
    }

    private func willDisplayNeededRow(beforeLast rowSubscraction: Int) -> Signal<(), NoError> {
        let willDisplayNeededRowSignal = reactive.rowDisplayingBeginning
            .filter { [weak self] in
                guard let `self` = self else { return false }
                return $0.row == self.tableView.numberOfRows(inSection: 0) - rowSubscraction
            }
            .mapToVoid()
        return willDisplayNeededRowSignal
    }
    
    // MARK: - Actions
    
    @objc private func rightItemAction(_ sender: UIBarButtonItem) {
        guard let popoverTop = popoverTopConstraint else { return }
        let isShown = popoverTop.constant == 0.0
        isShown ? hideSelectionPopover(animated: true) : showSelectionPopover(animated: true)
    }
    
    private func showSelectionPopover(animated: Bool = false) {
        navigationItem.title = Constant.navigationTitleWhitePopover
        popoverTopConstraint?.constant = 0.0
        UIView.animate(withDuration: animated ? Constant.popoverAnimationDuration : 0.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.selectionView.alpha = 1.0
        }, completion: nil)
    }
    
    private func hideSelectionPopover(animated: Bool = false) {
        navigationItem.title = Constant.navigationTitle
        popoverTopConstraint?.constant = -Constant.popoverHeight
        UIView.animate(withDuration: animated ? Constant.popoverAnimationDuration : 0.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: animated ? Constant.popoverAnimationDuration / 2.0 : 0.0, delay: animated ? Constant.popoverAnimationDuration / 2.0: 0.0, options: .curveEaseInOut, animations: {
            self.selectionView.alpha = 0.0
        }, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension TrendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: TrendingTVCell.self, for: indexPath)
        cell.configure(with: cellViewModels.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.value.count
    }
}

// MARK: - UITableViewDelegate
extension TrendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UISearchResultsUpdating
extension TrendsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

