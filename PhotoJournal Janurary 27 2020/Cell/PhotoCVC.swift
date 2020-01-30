//
//  PhotoCVC.swift
//  PhotoJournal Janurary 27 2020
//
//  Created by Margiett Gil on 1/27/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import Foundation



class PhotoCVC: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    //MARK: Step 2: creating custome delegation - define optional delegate variable
    weak var delegate: imageJorunalDelegate?
    
    
    //MARK: Step 1. long press setup
    // setup long press gesture recognizer
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let actionPress = UILongPressGestureRecognizer()
        //MARK: This code is not going to work unless you create Step 1 long press setup
        actionPress.addTarget(self, action: #selector(longPressAction(gesture:)))
        return actionPress
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20.0
        backgroundColor = .orange
        
        //Step 3: long press setup - added gesture to view
        addGestureRecognizer(longPressGesture)
    }
    
    //MARK: Step 1: to make long pressaction work
    // why does this code have to be down here in order to work and not before the private lazy var function ???????
    @objc
    private func longPressAction(gesture: UILongPressGestureRecognizer){
        
        if gesture.state == .began { // if gesture is actived (touched)
            gesture.state = .cancelled
            return
            
        }
        // MARK: Step 3: creating custom delegation - explicity use, delegate object to notify of any updates example notifying the ImagsViewController when the user long presses on the cell
        delegate?.didLongPress(self)
        
        //cell.delegate = self
        //imagesViewController -> didLongPress(:)
    }
    
    
    func configureCell(for item: PhotoModel){
        guard let image = UIImage(data: item.imageData) else {
            return
        }
        photo.image = image
        titileLabel.text = item.title
        dateLabel.text = item.date
        //        photo.image = UIImage(data: item.imageData)
        
    }
    
    
}
