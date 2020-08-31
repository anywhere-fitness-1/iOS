//
//  SearchCollectionViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/27/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SearchCollectionViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var filterDelegate: FilterDelegate?
    var classListing: ClassListing?
    var classDataArray: [ClassListing]?
    var dataArray: [ClassListing] = [ClassListing(classTitle: "Yoga", classType: .yoga, instructorID: "123", startTime: Date(), duration: .sixtyMin, intensity: .beginner, location: .sanFran, maxClassSize: 15, attendees: ["123"])]

    var filterString: String?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginController.shared.setCurrentUser { (user) in
            DispatchQueue.main.async {
                LoginController.shared.currentUser = user
            }
        }
        ClassController.shared.getClasses { (_) in
            print("Successfully got classes")
        }
    }
}

// MARK: - Extensions
extension SearchCollectionViewController: UICollectionViewDelegate {
}

extension SearchCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchCollectionViewCell else {
            print("no cell returned")
            return UICollectionViewCell()
        }

        cell.classListing = dataArray[indexPath.row]
        
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        classListing = dataArray[indexPath.item]
    }
}

extension SearchCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        //        classDataArray = searchText.isEmpty ? dataArray : dataArray.filter { (item: String) -> Bool in
        // If dataItem matches the searchText, return true to include it
        //          return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        //      }
        //
        //      collectionView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filters" {
            guard let destinationVC = segue.destination as? FiltersViewController else {return}
            destinationVC.filterDelegate = self
            print("working")

        } else if segue.identifier == "detail" {
            if let destinationVC = segue.destination as? DetailViewController, let index = collectionView.indexPathsForSelectedItems?.first  {
                
                destinationVC.classListing = dataArray[index.item]
            }
        }
    }
}

extension SearchCollectionViewController: FilterDelegate {

    func filterSelected(filter: String) {
        print(filter)
        filterString = filter

    }

}

protocol FilterDelegate {
    func filterSelected(filter: String)
    //    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //
    //    }
    //
    //
}

//extension SearchCollectionViewController: NSFetchedResultsControllerDelegate {
//
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        self.tableView.beginUpdates()
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        self.tableView.endUpdates()
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//        switch type {
//        case .insert:
//            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
//        case .delete:
//            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
//        default:
//            break
//        }
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            guard let newIndexPath = newIndexPath else { return }
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
//        case .update:
//            guard let indexPath = indexPath else { return }
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//        case .move:
//            guard let oldIndexPath = indexPath,
//                let newIndexPath = newIndexPath else { return }
//            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
//        case .delete:
//            guard let indexPath = indexPath else { return }
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        default:
//            break
//        }
//    }
//
//}
