//
//  PhotoModel.swift
//  PhotoJournal Janurary 27 2020
//
//  Created by Margiett Gil on 1/27/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation

struct PhotoModel: Codable & Equatable {
    let imageData: Data
    let date: String // this would be either the date that was taken or saved
    
    let identified =  UUID().uuidString // to identify if the two picture are the same than do some code if not do the other, this is giving an id on the picture
    let title: String
    
}


