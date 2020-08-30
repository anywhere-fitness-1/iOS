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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileClassesTableViewCell.reuseIdentifier, for: indexPath) as? ProfileClassesTableViewCell else { fatalError("Can't dequeue cell of type \(ProfileClassesTableViewCell.reuseIdentifier)") }
        
        // cell configure
        
        return cell
    }
    
    
}//
