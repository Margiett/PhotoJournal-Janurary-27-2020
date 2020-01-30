//
//  ViewController.swift
//  PhotoJournal Janurary 27 2020
//
//  Created by Margiett Gil on 1/27/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var gearBarButton: UIBarButtonItem!
    var photoDidSet = [T](){
    didSet{
        collectionView.reloadData()
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
//MARK: DataSource
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoDidSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCVC else { fatalError("unable to type cast reusuable cell")
        }
        let image = photoDidSet[indexPath.row]
        
        cell.configureCell(for: image)
        
        return cell
    }
}

//MARK: Delegate
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    //MARK: This is what size the pictures in the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let interItemSpacing = CGFloat(1)
                let maxWidth = UIScreen.main.bounds.size.width // device's width
        //      let maxHeight = UIScreen.main.bounds.size.height
                let numberOfItems: CGFloat = 1 // items per row
                let totalSpacing: CGFloat = numberOfItems * interItemSpacing
                let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
                
                //this sizing is so it prints squares.
                return CGSize(width: itemWidth, height: itemWidth)
            }
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
                
                return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
            }
    }
    

