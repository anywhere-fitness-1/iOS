//
//  SearchVC.swift
//  AnywhereFitness
//
//  Created by Norlan Tibanear on 8/30/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class SearchVC: UIViewController {

    // Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var filterTypeString: String?
    var filterString: String?
    var filterDelegate: FilterDelegate?
    
    
    // MARK: - Properties

    // MARK: - FetchResult Properties
    lazy var fetchedResultsController: NSFetchedResultsController<ClassListing> =
        {
        let fetchRequest: NSFetchRequest<ClassListing> = ClassListing.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "classType", ascending: true), NSSortDescriptor(key: "startTime", ascending: true)]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "classType", cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            NSLog("Unable to fetch classes from main context: \(error)")
        }
        return frc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.filterDelegate = self
        LoginController.shared.setCurrentUser { (user) in
            DispatchQueue.main.async {
                LoginController.shared.currentUser = user
            }
        }
        ClassController.shared.getClasses { (_) in
            DispatchQueue.main.async {
                ClassController.shared.getUserClasses { (_) in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filters" {
            guard let destinationVC = segue.destination as? FiltersViewController else {return}
            destinationVC.filterDelegate = self
        }
    }

} // Class

extension SearchVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell else { fatalError("Can't dequeue cell of type \(SearchTableViewCell.reuseIdentifier)") }

        cell.classListing = fetchedResultsController.object(at: indexPath)

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailViewSegue" {
            if let detailVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                detailVC.classListing = fetchedResultsController.object(at: indexPath)
            }
        }
    }

} // Extension

extension SearchVC: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }

} //

extension SearchVC: FilterDelegate {
    func filterSelected(filterType: String?, filter: String?) {
        self.filterString = filter
        self.filterTypeString = filterType
        guard let filterString = filterString, let filterTypeString = filterTypeString else {return}
        print(filterString)
        print(filterTypeString)
    }
    
    
}

protocol FilterDelegate {
    func filterSelected(filterType: String?, filter: String?)
}


