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
    var filterTypeString: String?
    var filtersArray: [String]?
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func filterButtonTapped(_ sender: Any) {
        guard let filtersArray = filtersArray else {
            print("No Filters Array")
            return}
        guard let selectedIndex = selectedIndex else {
            print("No Selected Index")
            return
        }
        filterString = filtersArray[selectedIndex]
        guard let filterDelegate = filterDelegate else {
            print("No filter delegate")
            return
        }
        guard let filterString = filterString, let filterTypeString = filterTypeString else {
            print("No Filter String")
            return}
        filterDelegate.filterSelected(filterType: filterTypeString, filter: filterString)
        navigationController?.popToRootViewController(animated: true)
    }
    
}
extension FiltersDetailViewController: FilterDelegate {
    func filterSelected(filterType: String?, filter: String?) {
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
        if indexPath.row == selectedIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = filtersArray[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}
