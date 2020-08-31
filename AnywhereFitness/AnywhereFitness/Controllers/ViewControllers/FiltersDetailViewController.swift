//
//  FiltersDetailViewController.swift
//  AnywhereFitness
//
//  Created by John McCants on 8/30/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class FiltersDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!

    var filterDelegate: FilterDelegate?
    var filterString: String?

    var filtersArray: [String]?
    var selectedIndexes = [[IndexPath.init(row: 0, section: 0)], [IndexPath.init(row: 0, section: 1)]]

    override func viewDidLoad() {
        super.viewDidLoad()

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

            guard let filterDelegate = filterDelegate, let filterString = filterString else {
                print("no filter delegate")
                return}
            filterDelegate.filterSelected(filter: filterString)
            print(filterString)
            navigationController?.popToRootViewController(animated: true)
        }

}

extension FiltersDetailViewController: FilterDelegate {
    func filterSelected(filter: String) {
        print("Done")
    }

}

extension FiltersDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let filtersArray = filtersArray else {return 1}
       return filtersArray.count
            }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath)
        guard let filtersArray = filtersArray else {return cell}
        cell.textLabel?.text = filtersArray[indexPath.row]

        cell.selectionStyle = .none

        let selectedSectionIndexes = self.selectedIndexes[indexPath.section]
        if selectedSectionIndexes.contains(indexPath) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell

}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath)

        // If current cell is not present in selectedIndexes
        if !self.selectedIndexes[indexPath.section].contains(indexPath) {
            // mark it checked
            cell?.accessoryType = .checkmark

            // Remove any previous selected indexpath
            self.selectedIndexes[indexPath.section].removeAll()

            // add currently selected indexpath
            self.selectedIndexes[indexPath.section].append(indexPath)

            tableView.reloadData()
        }

    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

    }
}
