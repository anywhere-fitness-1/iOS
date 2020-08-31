//
//  FiltersViewController.swift
//  AnywhereFitness
//
//  Created by John McCants on 8/28/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var filterTableView: UITableView!

    var filtersArray: [String] = ["Type", "Duration", "Intensity Level", "Location"]
    let classTypeArray = ["Yoga", "Pilates", "Aerobics", "Dance", "Cross Fit", "Strength Training", "Martial Arts", "Other"]
    let intensityArray = ["Beginner", "Intermediate", "Expert"]
    let locationArray = ["San Francisco", "New York"]
    let durationArray = ["30 Minutes", "45 Minutes", "60 Minutes", "90 Minutes"]

    var filterString : String = ""
    var filterDelegate: FilterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFilterDetail" {
            guard let destinationVC = segue.destination as? FiltersDetailViewController else {return}
            destinationVC.filterDelegate = self.filterDelegate
            print("passed guard")
            guard let selectedRow = self.filterTableView.indexPathsForSelectedRows?.first else {return}

            switch filtersArray[selectedRow.row] {
            case "Type":
                destinationVC.filtersArray = classTypeArray
                destinationVC.navBar.title = "Type"
                "Type Selected"
            case "Duration":
                destinationVC.filtersArray = durationArray
                destinationVC.navBar.title = "Duration"
            case "Intensity Level":
                destinationVC.filtersArray = intensityArray
                destinationVC.navBar.title = "Intensity Level"
            case "Location":
                destinationVC.filtersArray = locationArray
                destinationVC.navBar.title = "Location"
            default:
                break
            }

        }
    }
}
    
    

extension FiltersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filtersArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       let cell = tableView.dequeueReusableCell(withIdentifier: "filters", for: indexPath)
        cell.textLabel?.text = filtersArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     
    }
}

extension FiltersViewController: FilterDelegate {
    func filterSelected(filter: String) {
        print("Filter Selected")
    }
    
    
}
