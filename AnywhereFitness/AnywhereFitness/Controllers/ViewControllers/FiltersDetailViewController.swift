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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(filtersArray)

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

//            guard let filterDelegate = filterDelegate else {
//                print("no filter delegate")
//                return}
//            filterDelegate.filterSelected(filter: filterString)
//            print(filterString)
            navigationController?.popToRootViewController(animated: true)
//        }
    

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
        print("passed filtersArray guard")
       
        return cell
    
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}
