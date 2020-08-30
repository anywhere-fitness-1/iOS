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

    var filtersArray: [String] = ["Class"]

    enum Filters : String {
        case chosenClass = "Class"
        case location = "Location"

    }
    var filterString : String = ""
    var filterDelegate: FilterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        filterButton.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func filterButtonTapped(_ sender: Any) {

        guard let filterDelegate = filterDelegate else {
            print("no filter delegate")
            return}
        filterDelegate.filterSelected(filter: filterString)
        print(filterString)
        navigationController?.popToRootViewController(animated: true)
    }
}

extension FiltersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filtersArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       let cell = tableView.dequeueReusableCell(withIdentifier: "filters", for: indexPath)
        cell.textLabel?.text = filtersArray[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        if tableView.cellForRow(at: indexPath)?.textLabel?.text == "Class" {
            filterString = Filters.chosenClass.rawValue
        }
    }
}
