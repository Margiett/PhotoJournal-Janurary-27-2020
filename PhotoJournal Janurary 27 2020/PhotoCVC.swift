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
    
    
   
    //MARK: Step 2. long press setup
    // setup long press gesture recognizer
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let actionPress = UILongPressGestureRecognizer()
        //MARK: This code is not going to work unless you create Step 1 long press setup
        actionPress.addTarget(self, action: #selector(longPressAction(gesture:)))
        return actionPress
    }()
    
    //MARK: Step 1: to make long pressaction work
        @objc
        private func longPressAction(gesture: UILongPressGestureRecognizer){
            
            if gesture.state == .began { // if gesture is actived (touched)
                gesture.state = .cancelled
                return
                
            }
        }
 
    
    func configureCell(for item: T){
        titileLabel.text = item.title
        dateLabel.text = item.date
        photo.image = UIImage(data: item.imageData)
        
    }
    
    
}
