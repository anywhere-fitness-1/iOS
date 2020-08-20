//
//  SearchCollectionViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/20/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class SearchCollectionViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userImage: UIImageView!
    
    //MARK: - UI Properties
    let customUI = CustomUI()
    
    //MARK: - Functional Properties
    let searchCollectionViewCell = "SearchCollectionViewCell"
    let categoryController = CategoryController()
    
    //MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: - Helper Methods
    func configureUI() {
        userImage.layer.cornerRadius = userImage.frame.size.height / 2
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}

//MARK: - Extensions
extension SearchCollectionViewController: UICollectionViewDelegate {
    
}

extension SearchCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryController.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCollectionViewCell, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        let searchCategory = categoryController.categories[indexPath.row]
        cell.category = searchCategory
        DispatchQueue.main.async {
            cell.layer.cornerRadius = 25
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
        }
        return cell
    }
    
    
}
