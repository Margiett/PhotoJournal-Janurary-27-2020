//
//  FileManger.swift
//  PhotoJournal Janurary 27 2020
//
//  Created by Margiett Gil on 1/29/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation

extension FileManager {
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // we put a zero because there is only one documentDirectory and is arrary
        // userDomainMask, current user on your device
    
    }
    static func pathToDocumentsDirectory(with filename: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(filename)
    }
}
