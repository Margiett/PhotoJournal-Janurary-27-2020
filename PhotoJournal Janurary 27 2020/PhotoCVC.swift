//
//  PhotoCVC.swift
//  PhotoJournal Janurary 27 2020
//
//  Created by Margiett Gil on 1/27/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit



class PhotoCVC: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    func configureCell(for item: Pictures){
        titileLabel.text = item.title
        dateLabel.text = item.date
        photo.image = UIImage(data: item.imageData)
        
    }
    
    
}
