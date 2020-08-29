//
//  SearchCollectionViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/27/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class SearchCollectionViewController: UIViewController {
    
    //MARK: -IBOutlets -
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
//        collectionView.dataSource = self
    }
    
    

}
//MARK: - Extensions -
extension SearchCollectionViewController: UICollectionViewDelegate {
    
}

//extension SearchCollectionViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
//
//
//}
