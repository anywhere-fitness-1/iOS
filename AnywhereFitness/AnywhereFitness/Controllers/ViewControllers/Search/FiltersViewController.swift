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

    var filtersArray: [String] = ["Type", "Duration", "Intensity Level", "Location", "Day", "Time of Day"]
    let classTypeArray = ClassType.allCases.map { $0.rawValue }
    let intensityArray = Intensity.allCases.map { $0.rawValue }
    let locationArray = Location.allCases.map { $0.rawValue }
    let durationArray = Duration.allCases.map { $0.rawValue }
    let daysArray = ["Today", "Tomorrow", "This Weekend", "Next Week"]
    let timeArray = ["Morning", "Noon", "Afternoon", "Night"]

    var filterString: String = ""
    weak var filterDelegate: FilterDelegate?

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

            guard let selectedRow = self.filterTableView.indexPathsForSelectedRows?.first else {return}

            switch filtersArray[selectedRow.row] {
            case "Type":
                destinationVC.filtersArray = classTypeArray
                destinationVC.navBar.title = "Type"
                destinationVC.filterTypeString = "classType"
            case "Duration":
                destinationVC.filtersArray = durationArray
                destinationVC.navBar.title = "Duration"
                destinationVC.filterTypeString = "duration"
            case "Intensity Level":
                destinationVC.filtersArray = intensityArray
                destinationVC.navBar.title = "Intensity Level"
                destinationVC.filterTypeString = "intensity"
            case "Location":
                destinationVC.filtersArray = locationArray
                destinationVC.navBar.title = "Location"
                destinationVC.filterTypeString = "location"
            case "Day":
                destinationVC.filtersArray = daysArray
                destinationVC.navBar.title = "Days"
                destinationVC.filterTypeString = "startTime"
            case "Time of Day":
                destinationVC.filtersArray = timeArray
                destinationVC.navBar.title = "Time of Day"
                destinationVC.filterTypeString = "startTime"
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
}

extension FiltersViewController: FilterDelegate {
    func filterSelected(filterType: String?, filter: String?) {
    }
    }
