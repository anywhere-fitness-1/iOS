//
//  ProfileViewController.swift
//  AnywhereFitness
//
//  Created by Norlan Tibanear on 8/20/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    

    
    
    
    // MARK: - Properties
    
    lazy var fetchedResultsController: NSFetchedResultsController<ClassListing> = {
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
        
        updateView()
    }
    
    func updateView() {
        userImageView.layer.cornerRadius = 68
        userImageView.clipsToBounds = true
        userImageView.layer.borderWidth = 2
        userImageView.layer.borderColor = UIColor.darkGray.cgColor
        usernameLabel.text = LoginController.shared.currentUser?.name
        if let imageURL = LoginController.shared.currentUser?.image {
            LoginController.shared.getImage(imageUrl: imageURL, completion: { image in
                DispatchQueue.main.async {
                    self.userImageView.image = image
                }
            })
        }
    }

 

} // Class


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileClassesTableViewCell.reuseIdentifier, for: indexPath) as? ProfileClassesTableViewCell else { fatalError("Can't dequeue cell of type \(ProfileClassesTableViewCell.reuseIdentifier)") }
        
        cell.classListing = fetchedResultsController.object(at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = fetchedResultsController.sections?[section] else { return nil }
        return sectionInfo.name
    }
    
}//

extension ProfileViewController: NSFetchedResultsControllerDelegate {
    
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
    
}
