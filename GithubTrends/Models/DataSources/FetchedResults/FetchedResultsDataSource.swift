//
//  FetchedResultsDataSource.swift
//  GithubTrends
//
//  Created by Владислав  on 30.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import CoreData
import ReactiveSwift
import Result

typealias FetchResultsConfigureBlock<Item: NSFetchRequestResult, CollectionType, CellType> = (
    _ dataSource: FetchedResultsDataSource<Item>,
    _ view: CollectionType,
    _ cell: CellType,
    _ indexPath: IndexPath)
    -> ()

class FetchedResultsDataSource<T: NSFetchRequestResult>: NSObject, NSFetchedResultsControllerDelegate {

    // MARK: - Types
    
    typealias UpdateEvent = (dataSource: FetchedResultsDataSource<T>, updates: [FetchedResultsDataSourceUpdate])
    
    // MARK: - Variables
    
    private let didChangeContentPipe = Signal<UpdateEvent, NoError>.pipe()
    public var didChangeContent: Signal<UpdateEvent, NoError> {
        return didChangeContentPipe.output
    }
    
    let fetchedResultsController: NSFetchedResultsController<T>
    
    private var insertItems: [IndexPath] = []
    private var updateItems: [IndexPath] = []
    private var moveItems: [(from: IndexPath, to: IndexPath)] = []
    private var deleteItems: [IndexPath] = []
    
    private var insertSections: [Int] = []
    private var updateSections: [Int] = []
    private var deleteSections: [Int] = []

    // MARK: - Lifecycle
    
    init(_ fetchedResultsController: NSFetchedResultsController<T>) {
        self.fetchedResultsController = fetchedResultsController
        super.init()
        
        do {
            fetchedResultsController.delegate = self
            try fetchedResultsController.performFetch()
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        insertItems.removeAll()
        updateItems.removeAll()
        moveItems.removeAll()
        deleteItems.removeAll()
        
        insertSections.removeAll()
        updateSections.removeAll()
        deleteSections.removeAll()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            insertItems.append(newIndexPath!)
        case .update:
            updateItems.append(indexPath!)
        case .move:
            moveItems.append((indexPath!, newIndexPath!))
        case .delete:
            deleteItems.append(indexPath!)
        }
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            insertSections.append(sectionIndex)
        case .update:
            updateSections.append(sectionIndex)
        case .delete:
            deleteSections.append(sectionIndex)
        case .move:
            break
        }   
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        var updates: [FetchedResultsDataSourceUpdate] = []
        updates.append(.insertItems(insertItems))
        updates.append(.updateItems(updateItems))
        updates.append(.moveItems(moveItems))
        updates.append(.deleteItems(deleteItems))
        
        updates.append(.insertSections(insertSections))
        updates.append(.updateSections(updateSections))
        updates.append(.deleteSections(deleteSections))
        
        didChangeContentPipe.input.send(value: (dataSource: self, updates: updates))
    }
}

// MARK: - CollectionDataSource
extension FetchedResultsDataSource: CollectionDataSource {
    var numberOfSections: Int {
    	return fetchedResultsController.sections?.count ?? 0
    }
    
    var totalItemsNumber: Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func numberOfItems(inSection section: Int) -> Int {
    	return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    func item(at indexPath: IndexPath) -> T {
        return fetchedResultsController.object(at: indexPath)
    }
}

