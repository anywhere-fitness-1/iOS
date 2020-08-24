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
    @IBOutlet weak var userFullName: UILabel!
    
    
    
    // MARK: - Properties
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    

 

} // Class


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileClassesTableViewCell.reuseIdentifier, for: indexPath) as? ProfileClassesTableViewCell else { fatalError("Can't dequeue cell of type \(ProfileClassesTableViewCell.reuseIdentifier)") }
        
        // cell configure
        
        return cell
    }
    
    
}//
